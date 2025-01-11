import 'package:kiki/common/dto/api_response.dart';
import 'package:kiki/common/exception/custom_exception.dart';
import 'package:kiki/common/exception/global_exception_code.dart';

abstract class SimpleService {
  T? throwOrReturn<T>(
    ApiResponse<T> response, {
    required List<ExceptionCode> expectedExceptionCodes,
  }) {
    if (response.codeName != "OK") {
      throwByCodeName(expectedExceptionCodes, actual: response.codeName);
    }

    return response.value;
  }

  void throwByCodeName<T extends ExceptionCode>(
    List<T> expectedExceptionCodes, {
    required String actual,
  }) {
    for (var value in [
      ...GlobalExceptionCode.values,
      ...expectedExceptionCodes
    ]) {
      if (value.codeName == actual) {
        throw CustomException(exceptionCode: value);
      }
    }
  }
}
