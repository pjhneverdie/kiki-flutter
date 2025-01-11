import 'package:kiki/common/exception/global_exception_code.dart';

class CustomException implements Exception {
  final ExceptionCode exceptionCode;

  CustomException({required this.exceptionCode});

  @override
  String toString() {
    return "CustomException: ${exceptionCode.codeName}";
  }
}
