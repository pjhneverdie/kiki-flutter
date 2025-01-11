// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter/material.dart' as _i409;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:go_router/go_router.dart' as _i583;
import 'package:image_picker/image_picker.dart' as _i183;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;

import '../../common/dio/dio.dart' as _i954;
import '../../common/secure_storage/secure_storage.dart' as _i632;
import '../../common/service/image_picker.dart' as _i820;
import '../../common/util/aes_util.dart' as _i1024;
import '../../feature/feed/cubit/feed_cud_cubit.dart' as _i29;
import '../../feature/feed/cubit/feed_read_cubit.dart' as _i970;
import '../../feature/feed/service/feed_crud_service.dart' as _i77;
import '../../feature/member/repository/member_repository.dart' as _i823;
import '../../feature/member/service/member_service.dart' as _i441;
import '../config/data/app_data_localhost.dart' as _i908;
import '../config/data/app_data_prod.dart' as _i280;
import '../config/data/iconfig.dart' as _i372;
import '../config/router/go_router.dart' as _i1002;
import '../config/theme/theme_cubit.dart' as _i382;
import '../walk_through/login/cubit/login_cubit.dart' as _i674;
import '../walk_through/login/service/token_service.dart' as _i353;

const String _localhost = 'localhost';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final secureStorageModule = _$SecureStorageModule();
    final imagePickerModule = _$ImagePickerModule();
    final dioLoggerModule = _$DioLoggerModule();
    final goRouterModule = _$GoRouterModule();
    final dioModule = _$DioModule();
    gh.lazySingleton<_i1002.CurrentLocationTracker>(
        () => _i1002.CurrentLocationTracker());
    gh.lazySingleton<_i954.DioTimeoutInterceptor>(
        () => _i954.DioTimeoutInterceptor());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
        () => secureStorageModule.flutterSecureStorage);
    gh.lazySingleton<_i183.ImagePicker>(() => imagePickerModule.picker);
    gh.singleton<_i372.IConfig>(
      () => _i908.AppDataLocalhost()..init(),
      registerFor: {_localhost},
    );
    gh.lazySingleton<_i77.FeedCRUDService>(() => _i77.FeedCRUDService(
          gh<_i372.IConfig>(),
          gh<_i558.FlutterSecureStorage>(),
        ));
    gh.lazySingleton<_i528.PrettyDioLogger>(
      () => dioLoggerModule.logger,
      registerFor: {_localhost},
    );
    gh.factoryParam<_i382.ThemeCubit, _i409.ThemeMode, dynamic>((
      initThemeMode,
      _,
    ) =>
        _i382.ThemeCubit(initThemeMode));
    gh.lazySingleton<_i583.GoRouter>(
        () => goRouterModule.goRouter(gh<_i1002.CurrentLocationTracker>()));
    gh.lazySingleton<_i970.FeedReadCubit>(
        () => _i970.FeedReadCubit(gh<_i77.FeedCRUDService>()));
    gh.lazySingleton<_i29.FeedCUDCubit>(
        () => _i29.FeedCUDCubit(gh<_i77.FeedCRUDService>()));
    gh.lazySingleton<_i1024.AESUtil>(() => _i1024.AESUtil(gh<_i372.IConfig>()));
    gh.lazySingleton<_i954.DioBaseUrlInterceptor>(
        () => _i954.DioBaseUrlInterceptor(gh<_i372.IConfig>()));
    gh.lazySingleton<_i353.TokenService>(() => _i353.TokenService(
          gh<_i372.IConfig>(),
          gh<_i1024.AESUtil>(),
          gh<_i558.FlutterSecureStorage>(),
        ));
    gh.lazySingleton<_i674.LoginCubit>(
        () => _i674.LoginCubit(gh<_i353.TokenService>()));
    gh.lazySingleton<_i954.DioTokenInterceptor>(
        () => _i954.DioTokenInterceptor(gh<_i353.TokenService>()));
    gh.lazySingleton<_i954.DioExceptionHandler>(() => _i954.DioExceptionHandler(
          gh<_i372.IConfig>(),
          gh<_i353.TokenService>(),
          gh<_i674.LoginCubit>(),
        ));
    gh.singleton<_i372.IConfig>(
      () => _i280.AppDataProd()..init(),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i361.Dio>(
      () => dioModule.dioLocalhost(
        gh<_i954.DioTimeoutInterceptor>(),
        gh<_i954.DioBaseUrlInterceptor>(),
        gh<_i954.DioExceptionHandler>(),
        gh<_i954.DioTokenInterceptor>(),
        gh<_i528.PrettyDioLogger>(),
      ),
      registerFor: {_localhost},
    );
    gh.lazySingleton<_i361.Dio>(
      () => dioModule.dioProd(
        gh<_i954.DioTimeoutInterceptor>(),
        gh<_i954.DioBaseUrlInterceptor>(),
        gh<_i954.DioExceptionHandler>(),
        gh<_i954.DioTokenInterceptor>(),
      ),
      registerFor: {_prod},
    );
    gh.singleton<_i823.MemberRepository>(
        () => _i823.MemberRepository(gh<_i361.Dio>()));
    gh.lazySingleton<_i441.MemberService>(
        () => _i441.MemberService(gh<_i823.MemberRepository>()));
    return this;
  }
}

class _$SecureStorageModule extends _i632.SecureStorageModule {}

class _$ImagePickerModule extends _i820.ImagePickerModule {}

class _$DioLoggerModule extends _i954.DioLoggerModule {}

class _$GoRouterModule extends _i1002.GoRouterModule {}

class _$DioModule extends _i954.DioModule {}
