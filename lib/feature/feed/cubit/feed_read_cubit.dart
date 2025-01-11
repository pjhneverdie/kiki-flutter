import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:kiki/common/model/simple_data_state.dart';
import 'package:kiki/feature/feed/model/feed_template_model.dart';
import 'package:kiki/feature/feed/service/feed_crud_service.dart';

@lazySingleton
class FeedReadCubit extends Cubit<SimpleDataState<List<FeedTemplateModel>>> {
  final FeedCRUDService _feedCrudService;

  FeedReadCubit(this._feedCrudService) : super(Init());

  Future<void> getAllFeeds() async {
    emit(OnLoading());

    List<FeedTemplateModel> models = await _feedCrudService.readAllFeeds();

    emit(Data(models));
  }
}
