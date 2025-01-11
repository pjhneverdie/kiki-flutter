import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kiki/common/exception/custom_exception.dart';
import 'package:kiki/common/model/simple_data_state.dart';

class ControllerAdvice<T> extends Cubit<SimpleDataState<T>> {
  ControllerAdvice() : super(Init());

  Future<void> catchCustomException(Future<void> Function() action) async {
    try {
      await action();
    } catch (e, s) {
      onError(e, s);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    /// 미리 정의된 예외를 던진 경우
    ///
    if (error is CustomException) {
      emit(OnException(customException: error));
    } else {
      /// 런타임 예외 등 Unhandled Exception
      ///
      throw error;
    }

    super.onError(error, stackTrace);
  }
}
