import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:kiki/app/walk_through/login/dto/Tokens.dart';
import 'package:kiki/app/walk_through/login/exception/login_exception_code.dart';
import 'package:kiki/app/walk_through/login/model/login_state.dart';
import 'package:kiki/app/walk_through/login/service/token_service.dart';
import 'package:kiki/common/exception/custom_exception.dart';
import 'package:kiki/feature/member/model/member.dart';

@lazySingleton
class LoginCubit extends Cubit<LoginState> {
  final TokenService _tokenService;

  LoginCubit(this._tokenService) : super(LoginStateInit());

  Future<void> login({
    required Tokens? tokens,
    required Member? member,
  }) async {
    if (tokens == null && member == null) return;

    if (tokens == null && member != null) {
      return emit(LoginStateLogin(member: member));
    }

    if (tokens!.value == null) {
      emit(
        LoginStateOnException(
          customException: CustomException(
            exceptionCode: LoginExceptionCode.LOGIN_FAILED,
          ),
        ),
      );

      return;
    }

    emit(LoginStateOnLoading());

    await _tokenService.saveTokens(tokens);

    emit(LoginStateTokenSaved());
  }

  Future<void> logout() async {
    emit(LoginStateOnLoading());

    await _tokenService.logout();

    emit(LoginStateLogout());
  }
}
