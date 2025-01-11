import 'package:kiki/common/exception/custom_exception.dart';
import 'package:kiki/common/model/exception_state.dart';

abstract class SimpleDataState<T> {
  T? data;

  SimpleDataState(this.data);
}

class Init<T> extends SimpleDataState<T> {
  Init() : super(null);
}

class Data<T> extends SimpleDataState<T> {
  Data(super.data);
}

class OnLoading<T> extends SimpleDataState<T> {
  OnLoading() : super(null);
}

class OnException<T> extends SimpleDataState<T> implements ExceptionState {
  @override
  final CustomException customException;

  OnException({required this.customException}) : super(null);
}
