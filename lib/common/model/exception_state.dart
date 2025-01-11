import 'package:kiki/common/exception/custom_exception.dart';

abstract class ExceptionState {
  final CustomException customException;

  ExceptionState({required this.customException});
}
