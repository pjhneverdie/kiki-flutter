// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_template_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FeedTemplateModel _$FeedTemplateModelFromJson(Map<String, dynamic> json) {
  return _FeedTemplateModel.fromJson(json);
}

/// @nodoc
mixin _$FeedTemplateModel {
  String get imageUrl => throw _privateConstructorUsedError;
  String get imageTitle => throw _privateConstructorUsedError;
  String get buttonTitle => throw _privateConstructorUsedError;
  String get mobileWebUrl => throw _privateConstructorUsedError;

  /// Serializes this FeedTemplateModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeedTemplateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeedTemplateModelCopyWith<FeedTemplateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedTemplateModelCopyWith<$Res> {
  factory $FeedTemplateModelCopyWith(
          FeedTemplateModel value, $Res Function(FeedTemplateModel) then) =
      _$FeedTemplateModelCopyWithImpl<$Res, FeedTemplateModel>;
  @useResult
  $Res call(
      {String imageUrl,
      String imageTitle,
      String buttonTitle,
      String mobileWebUrl});
}

/// @nodoc
class _$FeedTemplateModelCopyWithImpl<$Res, $Val extends FeedTemplateModel>
    implements $FeedTemplateModelCopyWith<$Res> {
  _$FeedTemplateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeedTemplateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUrl = null,
    Object? imageTitle = null,
    Object? buttonTitle = null,
    Object? mobileWebUrl = null,
  }) {
    return _then(_value.copyWith(
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      imageTitle: null == imageTitle
          ? _value.imageTitle
          : imageTitle // ignore: cast_nullable_to_non_nullable
              as String,
      buttonTitle: null == buttonTitle
          ? _value.buttonTitle
          : buttonTitle // ignore: cast_nullable_to_non_nullable
              as String,
      mobileWebUrl: null == mobileWebUrl
          ? _value.mobileWebUrl
          : mobileWebUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeedTemplateModelImplCopyWith<$Res>
    implements $FeedTemplateModelCopyWith<$Res> {
  factory _$$FeedTemplateModelImplCopyWith(_$FeedTemplateModelImpl value,
          $Res Function(_$FeedTemplateModelImpl) then) =
      __$$FeedTemplateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String imageUrl,
      String imageTitle,
      String buttonTitle,
      String mobileWebUrl});
}

/// @nodoc
class __$$FeedTemplateModelImplCopyWithImpl<$Res>
    extends _$FeedTemplateModelCopyWithImpl<$Res, _$FeedTemplateModelImpl>
    implements _$$FeedTemplateModelImplCopyWith<$Res> {
  __$$FeedTemplateModelImplCopyWithImpl(_$FeedTemplateModelImpl _value,
      $Res Function(_$FeedTemplateModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of FeedTemplateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUrl = null,
    Object? imageTitle = null,
    Object? buttonTitle = null,
    Object? mobileWebUrl = null,
  }) {
    return _then(_$FeedTemplateModelImpl(
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      imageTitle: null == imageTitle
          ? _value.imageTitle
          : imageTitle // ignore: cast_nullable_to_non_nullable
              as String,
      buttonTitle: null == buttonTitle
          ? _value.buttonTitle
          : buttonTitle // ignore: cast_nullable_to_non_nullable
              as String,
      mobileWebUrl: null == mobileWebUrl
          ? _value.mobileWebUrl
          : mobileWebUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeedTemplateModelImpl implements _FeedTemplateModel {
  const _$FeedTemplateModelImpl(
      {required this.imageUrl,
      required this.imageTitle,
      required this.buttonTitle,
      required this.mobileWebUrl});

  factory _$FeedTemplateModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeedTemplateModelImplFromJson(json);

  @override
  final String imageUrl;
  @override
  final String imageTitle;
  @override
  final String buttonTitle;
  @override
  final String mobileWebUrl;

  @override
  String toString() {
    return 'FeedTemplateModel(imageUrl: $imageUrl, imageTitle: $imageTitle, buttonTitle: $buttonTitle, mobileWebUrl: $mobileWebUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedTemplateModelImpl &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.imageTitle, imageTitle) ||
                other.imageTitle == imageTitle) &&
            (identical(other.buttonTitle, buttonTitle) ||
                other.buttonTitle == buttonTitle) &&
            (identical(other.mobileWebUrl, mobileWebUrl) ||
                other.mobileWebUrl == mobileWebUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, imageUrl, imageTitle, buttonTitle, mobileWebUrl);

  /// Create a copy of FeedTemplateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedTemplateModelImplCopyWith<_$FeedTemplateModelImpl> get copyWith =>
      __$$FeedTemplateModelImplCopyWithImpl<_$FeedTemplateModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeedTemplateModelImplToJson(
      this,
    );
  }
}

abstract class _FeedTemplateModel implements FeedTemplateModel {
  const factory _FeedTemplateModel(
      {required final String imageUrl,
      required final String imageTitle,
      required final String buttonTitle,
      required final String mobileWebUrl}) = _$FeedTemplateModelImpl;

  factory _FeedTemplateModel.fromJson(Map<String, dynamic> json) =
      _$FeedTemplateModelImpl.fromJson;

  @override
  String get imageUrl;
  @override
  String get imageTitle;
  @override
  String get buttonTitle;
  @override
  String get mobileWebUrl;

  /// Create a copy of FeedTemplateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeedTemplateModelImplCopyWith<_$FeedTemplateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
