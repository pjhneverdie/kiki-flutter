abstract class ExceptionCode {
  String get codeName;

  String get message;
}

enum GlobalExceptionCode implements ExceptionCode {
  INVALID_TOKEN("INVALID_TOKEN", "로그인이 만료되어 요청을 수행할 수 없습니다."),
  SERVER_MAINTAINING("SERVER_MAINTAINING", "서버 점검중입니다. 잠시후 다시 시도해 주세요."),
  INTERNAL_SERVER_ERROR(
      "INTERNAL_SERVER_ERROR", "서버에 오류가 발생했습니다. 잠시후 다시 시도해 주세요.");

  @override
  final String codeName;

  @override
  final String message;

  const GlobalExceptionCode(this.codeName, this.message);
}
