import 'dart:ffi';

import 'package:injectable/injectable.dart';

import 'package:kiki/common/exception/controller_advice.dart';
import 'package:kiki/common/model/simple_data_state.dart';
import 'package:kiki/feature/feed/dto/feed_template_dto.dart';
import 'package:kiki/feature/feed/model/feed_template_model.dart';
import 'package:kiki/feature/feed/service/feed_crud_service.dart';

@lazySingleton
class FeedCUDCubit extends ControllerAdvice<Void> {
  final FeedCRUDService _feedCrudService;

  FeedCUDCubit(this._feedCrudService);

  Future<bool> saveFeed({
    required FeedTemplateDTO feedTemplateDTO,
  }) async {
    late bool isSuccess = false;

    emit(OnLoading());

    await catchCustomException(() async {
      await _feedCrudService.saveFeed(feedTemplateDTO: feedTemplateDTO);

      isSuccess = true;
      emit(Data(null));
    });

    return isSuccess;
  }

  Future<bool> updateImageOnly({
    required FeedTemplateDTO feedTemplateDTO,
    required String originImageUrl,
  }) async {
    late bool isSuccess = false;

    emit(OnLoading());

    await catchCustomException(() async {
      await _feedCrudService.removeFeed(originImageUrl);

      await _feedCrudService.saveFeed(feedTemplateDTO: feedTemplateDTO);

      isSuccess = true;
      emit(Data(null));
    });

    return isSuccess;
  }

  Future<void> updateFeed(FeedTemplateModel feedTemplateModel) async {
    emit(OnLoading());

    await _feedCrudService.updateFeed(feedTemplateModel);

    emit(Data(null));
  }

  Future<void> removeFeed({required String imageUrl}) async {
    emit(OnLoading());

    await _feedCrudService.removeFeed(imageUrl);

    emit(Data(null));
  }
}
