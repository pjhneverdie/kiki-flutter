library save_feed_screen;

import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:kiki/app/config/theme/app_colors.dart';
import 'package:kiki/app/di/get_it_instance.dart';
import 'package:kiki/common/model/simple_data_state.dart';
import 'package:kiki/common/util/screen_util_util.dart';
import 'package:kiki/common/util/toast_util.dart';
import 'package:kiki/common/util/use_color_mode.dart';
import 'package:kiki/feature/feed/cubit/feed_cud_cubit.dart';
import 'package:kiki/feature/feed/dto/feed_template_dto.dart';
import 'package:kiki/feature/feed/model/feed_template_model.dart';

part 'package:kiki/feature/feed/view/save_feed_view/component/app_bar.dart';

part 'package:kiki/feature/feed/view/save_feed_view/component/dialog_action.dart';

part 'package:kiki/feature/feed/view/save_feed_view/component/dialog_content.dart';

part 'package:kiki/feature/feed/view/save_feed_view/component/edit_icon.dart';

part 'package:kiki/feature/feed/view/save_feed_view/component/mobile_web_url_form_field.dart';

part 'package:kiki/feature/feed/view/save_feed_view/component/image_form_field.dart';

part 'package:kiki/feature/feed/view/save_feed_view/component/image_title_form_field.dart';

part 'package:kiki/feature/feed/view/save_feed_view/component/button_title_form_field.dart';

part 'package:kiki/feature/feed/view/save_feed_view/component/guide.dart';

class SaveFeedScreen extends StatefulWidget {
  static const String PATH = "feed/save";
  static const String FULL_PATH = "/home/feed/save";

  final FeedTemplateModel? _feedTemplateModel;

  const SaveFeedScreen({
    super.key,
    required FeedTemplateModel? feedTemplateModel,
  }) : _feedTemplateModel = feedTemplateModel;

  @override
  State<SaveFeedScreen> createState() => _SaveFeedScreenState();
}

class _SaveFeedScreenState extends State<SaveFeedScreen> {
  final FeedCUDCubit _feedCudCubit = getIt<FeedCUDCubit>();

  final GlobalKey<FormState> _imageTitleFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _buttonTitleFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _mobileWebUrlFormKey = GlobalKey<FormState>();

  File? _imageFile;
  late final String? _imageUrl = widget._feedTemplateModel?.imageUrl;

  final String _imageTitleHint = "배고픈 키키의 메시지";
  final String _buttonTitleHint = "간식 달라냥!";
  final String _mobileWebUrlHint = "https://qr.kakaopay.com/고유코드";

  late String? _imageTitle = widget._feedTemplateModel?.imageTitle;
  late String? _buttonTitle = widget._feedTemplateModel?.buttonTitle;
  late String? _mobileWebUrl = widget._feedTemplateModel?.mobileWebUrl;

  late final TextEditingController _imageTitleController =
      TextEditingController()..text = _imageTitle ?? "";
  late final TextEditingController _buttonTitleController =
      TextEditingController()..text = _buttonTitle ?? "";
  late final TextEditingController _mobileWebUrlController =
      TextEditingController()..text = _mobileWebUrl ?? "";

  Future<void> _saveFeed() async {
    if (widget._feedTemplateModel != null && _imageFile == null) {
      final FeedTemplateModel feedTemplateModel = FeedTemplateModel(
        imageUrl: _imageUrl!.trim(),
        imageTitle: _imageTitle!.trim(),
        buttonTitle: _buttonTitle!.trim(),
        mobileWebUrl: _mobileWebUrl!.trim(),
      );

      await _feedCudCubit.updateFeed(feedTemplateModel);

      if (mounted) {
        context.pop();
      }

      return;
    } else if (widget._feedTemplateModel != null && _imageFile != null) {
      final bool isSuccess = await _feedCudCubit.updateImageOnly(
        originImageUrl: _imageUrl!.trim(),
        feedTemplateDTO: FeedTemplateDTO(
          imageFile: _imageFile!,
          imageTitle: _imageTitle!.trim(),
          buttonTitle: _buttonTitle!.trim(),
          mobileWebUrl: _mobileWebUrl!.trim(),
        ),
      );

      if (mounted && isSuccess) {
        context.pop();
      }

      return;
    }

    if (_imageFile == null ||
        _imageTitle == null ||
        _buttonTitle == null ||
        _mobileWebUrl == null) return;

    final bool isSuccess = await _feedCudCubit.saveFeed(
      feedTemplateDTO: FeedTemplateDTO(
        imageFile: _imageFile!,
        imageTitle: _imageTitle!.trim(),
        buttonTitle: _buttonTitle!.trim(),
        mobileWebUrl: _mobileWebUrl!.trim(),
      ),
    );

    if (mounted && isSuccess) {
      context.pop();
    }
  }

  Future<void> _removeFeed() async {
    if (widget._feedTemplateModel != null) {
      await _feedCudCubit.removeFeed(
          imageUrl: widget._feedTemplateModel!.imageUrl);

      if (mounted) {
        context.pop();
      }
    }
  }

  Future<void> _showFormField(
    BuildContext context, {
    required GlobalKey<FormState> formKey,
    required TextEditingController controller,
    required int? maxLength,
    required String hintText,
    required String? Function(String?)? validator,
    required void Function()? onActionTap,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          backgroundColor: useColorMode(
            context,
            context.colors.strongWhite,
            context.colors.weakBlack,
          ),
          content: _DialogContent(
            formKey: formKey,
            controller: controller,
            maxLength: maxLength,
            hintText: hintText,
            validator: validator,
          ),
          actions: [
            _FeedFormAction(
              onActionTap: onActionTap,
            ),
          ],
        );
      },
    );
  }

  String? _imageTitleValidator(String? value) {
    return value == null || value.trim().isEmpty ? "본문을 입력해 주세요." : null;
  }

  String? _buttonTitleValidator(String? value) {
    return value == null || value.trim().isEmpty ? "버튼 문구를 입력해 주세요." : null;
  }

  String? _mobileWebUrlValidator(String? value) {
    return value == null || value.trim().isEmpty ? "송금 링크를 입력해 주세요." : null;
  }

  Future<void> _selectImage() async {
    XFile? xFile =
        await getIt<ImagePicker>().pickImage(source: ImageSource.gallery);

    if (xFile != null) {
      setState(() {
        _imageFile = File(xFile.path);
      });
    }
  }

  void _saveImageTitle() {
    if (_imageTitleFormKey.currentState!.validate()) {
      setState(() {
        _imageTitle = _imageTitleController.text;
      });

      context.pop();
    }
  }

  void _saveButtonTitle() {
    if (_buttonTitleFormKey.currentState!.validate()) {
      setState(() {
        _buttonTitle = _buttonTitleController.text;
      });

      context.pop();
    }
  }

  void _saveMobileWebUrl() {
    if (_mobileWebUrlFormKey.currentState!.validate()) {
      setState(() {
        _mobileWebUrl = _mobileWebUrlController.text;
      });

      context.pop();
    }
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    _imageTitleController.dispose();
    _buttonTitleController.dispose();
    _mobileWebUrlController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _feedCudCubit,
      listener: (context, state) {
        if (state is OnException) {
          ToastUtil.showAppDefaultToast(
            context,
            message: state.customException.exceptionCode.message,
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: useColorMode(
                context,
                context.colors.kakaoBlue,
                context.colors.strongBlack,
              ),
              body: Column(
                children: [
                  const _AppBar(),
                  Expanded(
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              _mobileWebUrlController.text =
                                  _mobileWebUrl ?? "";

                              await _showFormField(
                                context,
                                formKey: _mobileWebUrlFormKey,
                                controller: _mobileWebUrlController,
                                maxLength: null,
                                hintText: _mobileWebUrl ?? _mobileWebUrlHint,
                                validator: _mobileWebUrlValidator,
                                onActionTap: _saveMobileWebUrl,
                              );
                            },
                            child: _MobileWebUrlFormField(
                              mobileWebUrl: _mobileWebUrl ?? _mobileWebUrlHint,
                            ),
                          ),
                          SizedBox(
                            height: 15.0.autoSizeH,
                          ),
                          Container(
                            width: 250.0.autoSizeSP,
                            height: 380.0.autoSizeSP,
                            decoration: BoxDecoration(
                              color: useColorMode(
                                context,
                                context.colors.blueGray,
                                context.colors.weakBlack,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () async => await _selectImage(),
                                  child: _ImageFormField(
                                    imageUrl: _imageUrl,
                                    imageFile: _imageFile,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: 250.0.autoSizeSP,
                                    decoration: BoxDecoration(
                                      color: context.colors.strongWhite,
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 15.0.autoSizeH,
                                        ),
                                        SizedBox(
                                          width: 220.0.autoSizeW,
                                          child: GestureDetector(
                                            onTap: () async {
                                              _imageTitleController.text =
                                                  _imageTitle ?? "";

                                              await _showFormField(
                                                context,
                                                formKey: _imageTitleFormKey,
                                                controller:
                                                    _imageTitleController,
                                                maxLength: 11,
                                                hintText: _imageTitle ??
                                                    _imageTitleHint,
                                                validator: _imageTitleValidator,
                                                onActionTap: _saveImageTitle,
                                              );
                                            },
                                            child: _ImageTitleFormField(
                                              imageTitle: _imageTitle ??
                                                  _imageTitleHint,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15.0.autoSizeH,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            _buttonTitleController.text =
                                                _buttonTitle ?? "";

                                            await _showFormField(
                                              context,
                                              formKey: _buttonTitleFormKey,
                                              controller:
                                                  _buttonTitleController,
                                              maxLength: 11,
                                              hintText: _buttonTitle ??
                                                  _buttonTitleHint,
                                              validator: _buttonTitleValidator,
                                              onActionTap: _saveButtonTitle,
                                            );
                                          },
                                          child: _ButtonTitleForm(
                                            buttonTitle: _buttonTitle ??
                                                _buttonTitleHint,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _Guide(
                    onSaveButtonTap: () async => await _saveFeed(),
                    onRemoveButtonTap: () async => await _removeFeed(),
                  ),
                ],
              ),
            ),
            state is OnLoading
                ? Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10.0,
                        sigmaY: 10.0,
                      ),
                      child: Container(
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ),
                  )
                : const SizedBox(),
            if (state is OnLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else
              const SizedBox(),
          ],
        );
      },
    );
  }
}
