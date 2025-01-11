import 'package:kiki/common/exception/global_exception_code.dart';

enum LoginExceptionCode implements ExceptionCode {
  /// 로그인 실패 시
  LOGIN_FAILED("LOGIN_FAILED", "로그인 실패 다시 로그인해 주세요.");

  @override
  final String codeName;

  @override
  final String message;

  const LoginExceptionCode(
    this.codeName,
    this.message,
  );
}
