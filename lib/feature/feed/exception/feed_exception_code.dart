import 'package:kiki/common/exception/global_exception_code.dart';

enum FeedExceptionCode implements ExceptionCode {
  UPLOAD_FAILED("UPLOAD_FAILED", "이미지 업로드 도중 오류가 발생했습니다."),
  UN_SUPPORTED_FILE("UN_SUPPORTED_FILE", "업로드할 수 없는 파일입니다."),
  COMPRESSING_FAILED("COMPRESSING_FAILED", "5MB 이상은 업로드할 수 없습니다.");

  @override
  final String codeName;

  @override
  final String message;

  const FeedExceptionCode(
    this.codeName,
    this.message,
  );
}
