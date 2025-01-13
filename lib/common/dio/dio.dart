import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:kiki/app/config/data/iconfig.dart';
import 'package:kiki/app/di/custom_profile.dart';
import 'package:kiki/app/walk_through/login/cubit/login_cubit.dart';
import 'package:kiki/app/walk_through/login/dto/Tokens.dart';
import 'package:kiki/app/walk_through/login/service/token_service.dart';
import 'package:kiki/common/dto/api_response.dart';
import 'package:kiki/common/exception/global_exception_code.dart';
import 'package:kiki/common/util/base64_util.dart';

@module
abstract class DioModule {
  @prod
  @lazySingleton
  Dio dioProd(
    DioTimeoutInterceptor timeOutInterceptor,
    DioBaseUrlInterceptor baseUrlInterceptor,
    DioExceptionHandler exceptionInterceptor,
    DioTokenInterceptor tokenInterceptor,
  ) {
    final Dio dio = Dio();

    dio.interceptors.add(timeOutInterceptor);
    dio.interceptors.add(baseUrlInterceptor);

    dio.interceptors.add(exceptionInterceptor);
    dio.interceptors.add(tokenInterceptor);

    return dio;
  }

  @localhost
  @lazySingleton
  Dio dioLocalhost(
    DioTimeoutInterceptor timeOutInterceptor,
    DioBaseUrlInterceptor baseUrlInterceptor,
    DioExceptionHandler exceptionInterceptor,
    DioTokenInterceptor tokenInterceptor,
    PrettyDioLogger logger,
  ) {
    final Dio dio = Dio();

    dio.interceptors.add(timeOutInterceptor);
    dio.interceptors.add(baseUrlInterceptor);

    dio.interceptors.add(exceptionInterceptor);
    dio.interceptors.add(tokenInterceptor);

    dio.interceptors.add(logger);

    return dio;
  }
}

@module
abstract class DioLoggerModule {
  @localhost
  @lazySingleton
  PrettyDioLogger get logger =>
      PrettyDioLogger(requestHeader: true, requestBody: true);
}

@lazySingleton
class DioTimeoutInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.sendTimeout = const Duration(seconds: 10);
    options.connectTimeout = const Duration(seconds: 10);
    options.receiveTimeout = const Duration(seconds: 20);

    super.onRequest(options, handler);
  }
}

@lazySingleton
class DioBaseUrlInterceptor extends Interceptor {
  final String _baseUrl;

  DioBaseUrlInterceptor(IConfig iConfig) : _baseUrl = iConfig.baseUrl;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.baseUrl = _baseUrl;
    super.onRequest(options, handler);
  }
}

@lazySingleton
class DioTokenInterceptor extends Interceptor {
  final TokenService _tokenService;

  DioTokenInterceptor(this._tokenService);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers["Authorization"]) {
      final String? accessToken = await _tokenService.getAccessToken();

      if (accessToken == null) {
        options.headers.addAll({
          "Authorization": "Bearer has-no-access-token",
        });

        return super.onRequest(options, handler);
      }

      options.headers.addAll({
        "Authorization": "Bearer $accessToken",
      });
    }

    super.onRequest(options, handler);
  }
}

@lazySingleton
class DioExceptionHandler extends Interceptor {
  final String _baseUrl;
  final TokenService _tokenService;
  final LoginCubit _loginCubit;

  DioExceptionHandler(
    IConfig iConfig,
    this._tokenService,
    this._loginCubit,
  ) : _baseUrl = iConfig.baseUrl;

  Response _getResponse502(DioException err) {
    return Response(
      data: ApiResponse(
        value: null,
        codeName: GlobalExceptionCode.SERVER_MAINTAINING.codeName,
      ).toJson((value) => value),
      requestOptions: err.requestOptions,
    );
  }

  Future<void> _reissue({
    required Dio dio,
    required String refreshToken,
  }) async {
    final Response response = await dio.post(
      "$_baseUrl/reissue",
      options: Options(
        headers: {"Authorization": "Bearer $refreshToken"},
      ),
    );

    final Tokens tokens =
        Tokens(Base64Util.normalizeBase64(response.data["value"]));

    await _tokenService.saveTokens(tokens);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    /// 서버 점검 시
    ///
    if (err.response == null || err.response!.statusCode == 502) {
      return handler.resolve(_getResponse502(err));
    }

    if (err.response!.statusCode == 401) {
      final String? refreshToken = await _tokenService.getRefreshToken();

      if (refreshToken == null) {
        return handler.resolve(err.response!);
      }

      try {
        final Dio dio = Dio();

        await _reissue(
          dio: dio,
          refreshToken: refreshToken,
        );

        final RequestOptions options = err.requestOptions;
        options.headers.addAll(
          {"Authorization": "Bearer ${await _tokenService.getAccessToken()}"},
        );

        handler.resolve(await dio.fetch(options));
      } on DioException catch (err2) {
        if (err.response == null || err.response!.statusCode == 502) {
          return handler.resolve(_getResponse502(err2));
        }

        if (err2.response!.statusCode == 401) {
          await _loginCubit.logout();
        }

        handler.resolve(err2.response!);
      } catch (e) {
        rethrow;
      }
    } else {
      handler.resolve(err.response!);
    }
  }
}
