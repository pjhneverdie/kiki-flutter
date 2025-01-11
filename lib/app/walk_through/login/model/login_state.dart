import 'package:kiki/common/exception/custom_exception.dart';
import 'package:kiki/common/model/exception_state.dart';
import 'package:kiki/feature/member/model/member.dart';

abstract class LoginState {
  final Member? member;

  LoginState({required this.member});
}

class LoginStateInit extends LoginState {
  LoginStateInit() : super(member: null);
}

class LoginStateLogin extends LoginState {
  LoginStateLogin({required super.member});
}

class LoginStateLogout extends LoginState {
  LoginStateLogout() : super(member: null);
}

class LoginStateOnLoading extends LoginState {
  LoginStateOnLoading() : super(member: null);
}

/// 엑세스, 리프레시 토큰만 있고 아직 멤버 조회까지는 안 된 상황
class LoginStateTokenSaved extends LoginState {
  LoginStateTokenSaved() : super(member: null);
}

class LoginStateOnException extends LoginState implements ExceptionState {
  @override
  final CustomException customException;

  LoginStateOnException({required this.customException}) : super(member: null);
}
