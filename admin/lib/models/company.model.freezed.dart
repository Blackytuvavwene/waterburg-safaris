// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Company _$CompanyFromJson(Map<String, dynamic> json) {
  return _Company.fromJson(json);
}

/// @nodoc
mixin _$Company {
  String? get companyId => throw _privateConstructorUsedError;
  CompanyDetails? get companyDetails => throw _privateConstructorUsedError;
  List<CompanyStaff>? get companyStaff => throw _privateConstructorUsedError;
  List<Gallery>? get companyGallery => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String? get slug => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompanyCopyWith<Company> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyCopyWith<$Res> {
  factory $CompanyCopyWith(Company value, $Res Function(Company) then) =
      _$CompanyCopyWithImpl<$Res, Company>;
  @useResult
  $Res call(
      {String? companyId,
      CompanyDetails? companyDetails,
      List<CompanyStaff>? companyStaff,
      List<Gallery>? companyGallery,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? slug});

  $CompanyDetailsCopyWith<$Res>? get companyDetails;
}

/// @nodoc
class _$CompanyCopyWithImpl<$Res, $Val extends Company>
    implements $CompanyCopyWith<$Res> {
  _$CompanyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? companyId = freezed,
    Object? companyDetails = freezed,
    Object? companyStaff = freezed,
    Object? companyGallery = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? slug = freezed,
  }) {
    return _then(_value.copyWith(
      companyId: freezed == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String?,
      companyDetails: freezed == companyDetails
          ? _value.companyDetails
          : companyDetails // ignore: cast_nullable_to_non_nullable
              as CompanyDetails?,
      companyStaff: freezed == companyStaff
          ? _value.companyStaff
          : companyStaff // ignore: cast_nullable_to_non_nullable
              as List<CompanyStaff>?,
      companyGallery: freezed == companyGallery
          ? _value.companyGallery
          : companyGallery // ignore: cast_nullable_to_non_nullable
              as List<Gallery>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CompanyDetailsCopyWith<$Res>? get companyDetails {
    if (_value.companyDetails == null) {
      return null;
    }

    return $CompanyDetailsCopyWith<$Res>(_value.companyDetails!, (value) {
      return _then(_value.copyWith(companyDetails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CompanyCopyWith<$Res> implements $CompanyCopyWith<$Res> {
  factory _$$_CompanyCopyWith(
          _$_Company value, $Res Function(_$_Company) then) =
      __$$_CompanyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? companyId,
      CompanyDetails? companyDetails,
      List<CompanyStaff>? companyStaff,
      List<Gallery>? companyGallery,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? slug});

  @override
  $CompanyDetailsCopyWith<$Res>? get companyDetails;
}

/// @nodoc
class __$$_CompanyCopyWithImpl<$Res>
    extends _$CompanyCopyWithImpl<$Res, _$_Company>
    implements _$$_CompanyCopyWith<$Res> {
  __$$_CompanyCopyWithImpl(_$_Company _value, $Res Function(_$_Company) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? companyId = freezed,
    Object? companyDetails = freezed,
    Object? companyStaff = freezed,
    Object? companyGallery = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? slug = freezed,
  }) {
    return _then(_$_Company(
      companyId: freezed == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String?,
      companyDetails: freezed == companyDetails
          ? _value.companyDetails
          : companyDetails // ignore: cast_nullable_to_non_nullable
              as CompanyDetails?,
      companyStaff: freezed == companyStaff
          ? _value._companyStaff
          : companyStaff // ignore: cast_nullable_to_non_nullable
              as List<CompanyStaff>?,
      companyGallery: freezed == companyGallery
          ? _value._companyGallery
          : companyGallery // ignore: cast_nullable_to_non_nullable
              as List<Gallery>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true, anyMap: true)
class _$_Company with DiagnosticableTreeMixin implements _Company {
  _$_Company(
      {this.companyId,
      this.companyDetails,
      final List<CompanyStaff>? companyStaff,
      final List<Gallery>? companyGallery,
      this.createdAt,
      this.updatedAt,
      this.slug})
      : _companyStaff = companyStaff,
        _companyGallery = companyGallery;

  factory _$_Company.fromJson(Map<String, dynamic> json) =>
      _$$_CompanyFromJson(json);

  @override
  final String? companyId;
  @override
  final CompanyDetails? companyDetails;
  final List<CompanyStaff>? _companyStaff;
  @override
  List<CompanyStaff>? get companyStaff {
    final value = _companyStaff;
    if (value == null) return null;
    if (_companyStaff is EqualUnmodifiableListView) return _companyStaff;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Gallery>? _companyGallery;
  @override
  List<Gallery>? get companyGallery {
    final value = _companyGallery;
    if (value == null) return null;
    if (_companyGallery is EqualUnmodifiableListView) return _companyGallery;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? slug;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Company(companyId: $companyId, companyDetails: $companyDetails, companyStaff: $companyStaff, companyGallery: $companyGallery, createdAt: $createdAt, updatedAt: $updatedAt, slug: $slug)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Company'))
      ..add(DiagnosticsProperty('companyId', companyId))
      ..add(DiagnosticsProperty('companyDetails', companyDetails))
      ..add(DiagnosticsProperty('companyStaff', companyStaff))
      ..add(DiagnosticsProperty('companyGallery', companyGallery))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('slug', slug));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Company &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.companyDetails, companyDetails) ||
                other.companyDetails == companyDetails) &&
            const DeepCollectionEquality()
                .equals(other._companyStaff, _companyStaff) &&
            const DeepCollectionEquality()
                .equals(other._companyGallery, _companyGallery) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.slug, slug) || other.slug == slug));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      companyId,
      companyDetails,
      const DeepCollectionEquality().hash(_companyStaff),
      const DeepCollectionEquality().hash(_companyGallery),
      createdAt,
      updatedAt,
      slug);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CompanyCopyWith<_$_Company> get copyWith =>
      __$$_CompanyCopyWithImpl<_$_Company>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CompanyToJson(
      this,
    );
  }
}

abstract class _Company implements Company {
  factory _Company(
      {final String? companyId,
      final CompanyDetails? companyDetails,
      final List<CompanyStaff>? companyStaff,
      final List<Gallery>? companyGallery,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final String? slug}) = _$_Company;

  factory _Company.fromJson(Map<String, dynamic> json) = _$_Company.fromJson;

  @override
  String? get companyId;
  @override
  CompanyDetails? get companyDetails;
  @override
  List<CompanyStaff>? get companyStaff;
  @override
  List<Gallery>? get companyGallery;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  String? get slug;
  @override
  @JsonKey(ignore: true)
  _$$_CompanyCopyWith<_$_Company> get copyWith =>
      throw _privateConstructorUsedError;
}

Gallery _$GalleryFromJson(Map<String, dynamic> json) {
  return _Gallery.fromJson(json);
}

/// @nodoc
mixin _$Gallery {
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get imageTitle => throw _privateConstructorUsedError;
  String? get imageDescription => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GalleryCopyWith<Gallery> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GalleryCopyWith<$Res> {
  factory $GalleryCopyWith(Gallery value, $Res Function(Gallery) then) =
      _$GalleryCopyWithImpl<$Res, Gallery>;
  @useResult
  $Res call({String? imageUrl, String? imageTitle, String? imageDescription});
}

/// @nodoc
class _$GalleryCopyWithImpl<$Res, $Val extends Gallery>
    implements $GalleryCopyWith<$Res> {
  _$GalleryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUrl = freezed,
    Object? imageTitle = freezed,
    Object? imageDescription = freezed,
  }) {
    return _then(_value.copyWith(
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      imageTitle: freezed == imageTitle
          ? _value.imageTitle
          : imageTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      imageDescription: freezed == imageDescription
          ? _value.imageDescription
          : imageDescription // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GalleryCopyWith<$Res> implements $GalleryCopyWith<$Res> {
  factory _$$_GalleryCopyWith(
          _$_Gallery value, $Res Function(_$_Gallery) then) =
      __$$_GalleryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? imageUrl, String? imageTitle, String? imageDescription});
}

/// @nodoc
class __$$_GalleryCopyWithImpl<$Res>
    extends _$GalleryCopyWithImpl<$Res, _$_Gallery>
    implements _$$_GalleryCopyWith<$Res> {
  __$$_GalleryCopyWithImpl(_$_Gallery _value, $Res Function(_$_Gallery) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUrl = freezed,
    Object? imageTitle = freezed,
    Object? imageDescription = freezed,
  }) {
    return _then(_$_Gallery(
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      imageTitle: freezed == imageTitle
          ? _value.imageTitle
          : imageTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      imageDescription: freezed == imageDescription
          ? _value.imageDescription
          : imageDescription // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true, anyMap: true)
class _$_Gallery with DiagnosticableTreeMixin implements _Gallery {
  _$_Gallery({this.imageUrl, this.imageTitle, this.imageDescription});

  factory _$_Gallery.fromJson(Map<String, dynamic> json) =>
      _$$_GalleryFromJson(json);

  @override
  final String? imageUrl;
  @override
  final String? imageTitle;
  @override
  final String? imageDescription;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Gallery(imageUrl: $imageUrl, imageTitle: $imageTitle, imageDescription: $imageDescription)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Gallery'))
      ..add(DiagnosticsProperty('imageUrl', imageUrl))
      ..add(DiagnosticsProperty('imageTitle', imageTitle))
      ..add(DiagnosticsProperty('imageDescription', imageDescription));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Gallery &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.imageTitle, imageTitle) ||
                other.imageTitle == imageTitle) &&
            (identical(other.imageDescription, imageDescription) ||
                other.imageDescription == imageDescription));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, imageUrl, imageTitle, imageDescription);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GalleryCopyWith<_$_Gallery> get copyWith =>
      __$$_GalleryCopyWithImpl<_$_Gallery>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GalleryToJson(
      this,
    );
  }
}

abstract class _Gallery implements Gallery {
  factory _Gallery(
      {final String? imageUrl,
      final String? imageTitle,
      final String? imageDescription}) = _$_Gallery;

  factory _Gallery.fromJson(Map<String, dynamic> json) = _$_Gallery.fromJson;

  @override
  String? get imageUrl;
  @override
  String? get imageTitle;
  @override
  String? get imageDescription;
  @override
  @JsonKey(ignore: true)
  _$$_GalleryCopyWith<_$_Gallery> get copyWith =>
      throw _privateConstructorUsedError;
}

CompanyStaff _$CompanyStaffFromJson(Map<String, dynamic> json) {
  return _CompanyStaff.fromJson(json);
}

/// @nodoc
mixin _$CompanyStaff {
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get fullName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  List<String>? get phoneNos => throw _privateConstructorUsedError;
  String? get jobTitle => throw _privateConstructorUsedError;
  String? get jobDescription => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get slug => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompanyStaffCopyWith<CompanyStaff> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyStaffCopyWith<$Res> {
  factory $CompanyStaffCopyWith(
          CompanyStaff value, $Res Function(CompanyStaff) then) =
      _$CompanyStaffCopyWithImpl<$Res, CompanyStaff>;
  @useResult
  $Res call(
      {String? imageUrl,
      String? fullName,
      String? email,
      List<String>? phoneNos,
      String? jobTitle,
      String? jobDescription,
      String? title,
      String? slug});
}

/// @nodoc
class _$CompanyStaffCopyWithImpl<$Res, $Val extends CompanyStaff>
    implements $CompanyStaffCopyWith<$Res> {
  _$CompanyStaffCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUrl = freezed,
    Object? fullName = freezed,
    Object? email = freezed,
    Object? phoneNos = freezed,
    Object? jobTitle = freezed,
    Object? jobDescription = freezed,
    Object? title = freezed,
    Object? slug = freezed,
  }) {
    return _then(_value.copyWith(
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNos: freezed == phoneNos
          ? _value.phoneNos
          : phoneNos // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      jobTitle: freezed == jobTitle
          ? _value.jobTitle
          : jobTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      jobDescription: freezed == jobDescription
          ? _value.jobDescription
          : jobDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CompanyStaffCopyWith<$Res>
    implements $CompanyStaffCopyWith<$Res> {
  factory _$$_CompanyStaffCopyWith(
          _$_CompanyStaff value, $Res Function(_$_CompanyStaff) then) =
      __$$_CompanyStaffCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? imageUrl,
      String? fullName,
      String? email,
      List<String>? phoneNos,
      String? jobTitle,
      String? jobDescription,
      String? title,
      String? slug});
}

/// @nodoc
class __$$_CompanyStaffCopyWithImpl<$Res>
    extends _$CompanyStaffCopyWithImpl<$Res, _$_CompanyStaff>
    implements _$$_CompanyStaffCopyWith<$Res> {
  __$$_CompanyStaffCopyWithImpl(
      _$_CompanyStaff _value, $Res Function(_$_CompanyStaff) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUrl = freezed,
    Object? fullName = freezed,
    Object? email = freezed,
    Object? phoneNos = freezed,
    Object? jobTitle = freezed,
    Object? jobDescription = freezed,
    Object? title = freezed,
    Object? slug = freezed,
  }) {
    return _then(_$_CompanyStaff(
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNos: freezed == phoneNos
          ? _value._phoneNos
          : phoneNos // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      jobTitle: freezed == jobTitle
          ? _value.jobTitle
          : jobTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      jobDescription: freezed == jobDescription
          ? _value.jobDescription
          : jobDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true, anyMap: true)
class _$_CompanyStaff with DiagnosticableTreeMixin implements _CompanyStaff {
  _$_CompanyStaff(
      {this.imageUrl,
      this.fullName,
      this.email,
      final List<String>? phoneNos,
      this.jobTitle,
      this.jobDescription,
      this.title,
      this.slug})
      : _phoneNos = phoneNos;

  factory _$_CompanyStaff.fromJson(Map<String, dynamic> json) =>
      _$$_CompanyStaffFromJson(json);

  @override
  final String? imageUrl;
  @override
  final String? fullName;
  @override
  final String? email;
  final List<String>? _phoneNos;
  @override
  List<String>? get phoneNos {
    final value = _phoneNos;
    if (value == null) return null;
    if (_phoneNos is EqualUnmodifiableListView) return _phoneNos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? jobTitle;
  @override
  final String? jobDescription;
  @override
  final String? title;
  @override
  final String? slug;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CompanyStaff(imageUrl: $imageUrl, fullName: $fullName, email: $email, phoneNos: $phoneNos, jobTitle: $jobTitle, jobDescription: $jobDescription, title: $title, slug: $slug)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CompanyStaff'))
      ..add(DiagnosticsProperty('imageUrl', imageUrl))
      ..add(DiagnosticsProperty('fullName', fullName))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('phoneNos', phoneNos))
      ..add(DiagnosticsProperty('jobTitle', jobTitle))
      ..add(DiagnosticsProperty('jobDescription', jobDescription))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('slug', slug));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CompanyStaff &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            const DeepCollectionEquality().equals(other._phoneNos, _phoneNos) &&
            (identical(other.jobTitle, jobTitle) ||
                other.jobTitle == jobTitle) &&
            (identical(other.jobDescription, jobDescription) ||
                other.jobDescription == jobDescription) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.slug, slug) || other.slug == slug));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      imageUrl,
      fullName,
      email,
      const DeepCollectionEquality().hash(_phoneNos),
      jobTitle,
      jobDescription,
      title,
      slug);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CompanyStaffCopyWith<_$_CompanyStaff> get copyWith =>
      __$$_CompanyStaffCopyWithImpl<_$_CompanyStaff>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CompanyStaffToJson(
      this,
    );
  }
}

abstract class _CompanyStaff implements CompanyStaff {
  factory _CompanyStaff(
      {final String? imageUrl,
      final String? fullName,
      final String? email,
      final List<String>? phoneNos,
      final String? jobTitle,
      final String? jobDescription,
      final String? title,
      final String? slug}) = _$_CompanyStaff;

  factory _CompanyStaff.fromJson(Map<String, dynamic> json) =
      _$_CompanyStaff.fromJson;

  @override
  String? get imageUrl;
  @override
  String? get fullName;
  @override
  String? get email;
  @override
  List<String>? get phoneNos;
  @override
  String? get jobTitle;
  @override
  String? get jobDescription;
  @override
  String? get title;
  @override
  String? get slug;
  @override
  @JsonKey(ignore: true)
  _$$_CompanyStaffCopyWith<_$_CompanyStaff> get copyWith =>
      throw _privateConstructorUsedError;
}

CompanyDetails _$CompanyDetailsFromJson(Map<String, dynamic> json) {
  return _CompanyDetails.fromJson(json);
}

/// @nodoc
mixin _$CompanyDetails {
  String? get companyName => throw _privateConstructorUsedError;
  String? get companyAddress => throw _privateConstructorUsedError;
  String? get registrationNumber => throw _privateConstructorUsedError;
  String? get vatNo => throw _privateConstructorUsedError;
  String? get companyLogoUrl => throw _privateConstructorUsedError;
  String? get seoDescription => throw _privateConstructorUsedError;
  String? get overview => throw _privateConstructorUsedError;
  List<String>? get cellPhoneNos => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get telNo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompanyDetailsCopyWith<CompanyDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyDetailsCopyWith<$Res> {
  factory $CompanyDetailsCopyWith(
          CompanyDetails value, $Res Function(CompanyDetails) then) =
      _$CompanyDetailsCopyWithImpl<$Res, CompanyDetails>;
  @useResult
  $Res call(
      {String? companyName,
      String? companyAddress,
      String? registrationNumber,
      String? vatNo,
      String? companyLogoUrl,
      String? seoDescription,
      String? overview,
      List<String>? cellPhoneNos,
      String? email,
      String? telNo});
}

/// @nodoc
class _$CompanyDetailsCopyWithImpl<$Res, $Val extends CompanyDetails>
    implements $CompanyDetailsCopyWith<$Res> {
  _$CompanyDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? companyName = freezed,
    Object? companyAddress = freezed,
    Object? registrationNumber = freezed,
    Object? vatNo = freezed,
    Object? companyLogoUrl = freezed,
    Object? seoDescription = freezed,
    Object? overview = freezed,
    Object? cellPhoneNos = freezed,
    Object? email = freezed,
    Object? telNo = freezed,
  }) {
    return _then(_value.copyWith(
      companyName: freezed == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String?,
      companyAddress: freezed == companyAddress
          ? _value.companyAddress
          : companyAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      registrationNumber: freezed == registrationNumber
          ? _value.registrationNumber
          : registrationNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      vatNo: freezed == vatNo
          ? _value.vatNo
          : vatNo // ignore: cast_nullable_to_non_nullable
              as String?,
      companyLogoUrl: freezed == companyLogoUrl
          ? _value.companyLogoUrl
          : companyLogoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      seoDescription: freezed == seoDescription
          ? _value.seoDescription
          : seoDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      cellPhoneNos: freezed == cellPhoneNos
          ? _value.cellPhoneNos
          : cellPhoneNos // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      telNo: freezed == telNo
          ? _value.telNo
          : telNo // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CompanyDetailsCopyWith<$Res>
    implements $CompanyDetailsCopyWith<$Res> {
  factory _$$_CompanyDetailsCopyWith(
          _$_CompanyDetails value, $Res Function(_$_CompanyDetails) then) =
      __$$_CompanyDetailsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? companyName,
      String? companyAddress,
      String? registrationNumber,
      String? vatNo,
      String? companyLogoUrl,
      String? seoDescription,
      String? overview,
      List<String>? cellPhoneNos,
      String? email,
      String? telNo});
}

/// @nodoc
class __$$_CompanyDetailsCopyWithImpl<$Res>
    extends _$CompanyDetailsCopyWithImpl<$Res, _$_CompanyDetails>
    implements _$$_CompanyDetailsCopyWith<$Res> {
  __$$_CompanyDetailsCopyWithImpl(
      _$_CompanyDetails _value, $Res Function(_$_CompanyDetails) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? companyName = freezed,
    Object? companyAddress = freezed,
    Object? registrationNumber = freezed,
    Object? vatNo = freezed,
    Object? companyLogoUrl = freezed,
    Object? seoDescription = freezed,
    Object? overview = freezed,
    Object? cellPhoneNos = freezed,
    Object? email = freezed,
    Object? telNo = freezed,
  }) {
    return _then(_$_CompanyDetails(
      companyName: freezed == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String?,
      companyAddress: freezed == companyAddress
          ? _value.companyAddress
          : companyAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      registrationNumber: freezed == registrationNumber
          ? _value.registrationNumber
          : registrationNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      vatNo: freezed == vatNo
          ? _value.vatNo
          : vatNo // ignore: cast_nullable_to_non_nullable
              as String?,
      companyLogoUrl: freezed == companyLogoUrl
          ? _value.companyLogoUrl
          : companyLogoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      seoDescription: freezed == seoDescription
          ? _value.seoDescription
          : seoDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      cellPhoneNos: freezed == cellPhoneNos
          ? _value._cellPhoneNos
          : cellPhoneNos // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      telNo: freezed == telNo
          ? _value.telNo
          : telNo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true, anyMap: true)
class _$_CompanyDetails
    with DiagnosticableTreeMixin
    implements _CompanyDetails {
  _$_CompanyDetails(
      {this.companyName,
      this.companyAddress,
      this.registrationNumber,
      this.vatNo,
      this.companyLogoUrl,
      this.seoDescription,
      this.overview,
      final List<String>? cellPhoneNos,
      this.email,
      this.telNo})
      : _cellPhoneNos = cellPhoneNos;

  factory _$_CompanyDetails.fromJson(Map<String, dynamic> json) =>
      _$$_CompanyDetailsFromJson(json);

  @override
  final String? companyName;
  @override
  final String? companyAddress;
  @override
  final String? registrationNumber;
  @override
  final String? vatNo;
  @override
  final String? companyLogoUrl;
  @override
  final String? seoDescription;
  @override
  final String? overview;
  final List<String>? _cellPhoneNos;
  @override
  List<String>? get cellPhoneNos {
    final value = _cellPhoneNos;
    if (value == null) return null;
    if (_cellPhoneNos is EqualUnmodifiableListView) return _cellPhoneNos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? email;
  @override
  final String? telNo;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CompanyDetails(companyName: $companyName, companyAddress: $companyAddress, registrationNumber: $registrationNumber, vatNo: $vatNo, companyLogoUrl: $companyLogoUrl, seoDescription: $seoDescription, overview: $overview, cellPhoneNos: $cellPhoneNos, email: $email, telNo: $telNo)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CompanyDetails'))
      ..add(DiagnosticsProperty('companyName', companyName))
      ..add(DiagnosticsProperty('companyAddress', companyAddress))
      ..add(DiagnosticsProperty('registrationNumber', registrationNumber))
      ..add(DiagnosticsProperty('vatNo', vatNo))
      ..add(DiagnosticsProperty('companyLogoUrl', companyLogoUrl))
      ..add(DiagnosticsProperty('seoDescription', seoDescription))
      ..add(DiagnosticsProperty('overview', overview))
      ..add(DiagnosticsProperty('cellPhoneNos', cellPhoneNos))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('telNo', telNo));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CompanyDetails &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.companyAddress, companyAddress) ||
                other.companyAddress == companyAddress) &&
            (identical(other.registrationNumber, registrationNumber) ||
                other.registrationNumber == registrationNumber) &&
            (identical(other.vatNo, vatNo) || other.vatNo == vatNo) &&
            (identical(other.companyLogoUrl, companyLogoUrl) ||
                other.companyLogoUrl == companyLogoUrl) &&
            (identical(other.seoDescription, seoDescription) ||
                other.seoDescription == seoDescription) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            const DeepCollectionEquality()
                .equals(other._cellPhoneNos, _cellPhoneNos) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.telNo, telNo) || other.telNo == telNo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      companyName,
      companyAddress,
      registrationNumber,
      vatNo,
      companyLogoUrl,
      seoDescription,
      overview,
      const DeepCollectionEquality().hash(_cellPhoneNos),
      email,
      telNo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CompanyDetailsCopyWith<_$_CompanyDetails> get copyWith =>
      __$$_CompanyDetailsCopyWithImpl<_$_CompanyDetails>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CompanyDetailsToJson(
      this,
    );
  }
}

abstract class _CompanyDetails implements CompanyDetails {
  factory _CompanyDetails(
      {final String? companyName,
      final String? companyAddress,
      final String? registrationNumber,
      final String? vatNo,
      final String? companyLogoUrl,
      final String? seoDescription,
      final String? overview,
      final List<String>? cellPhoneNos,
      final String? email,
      final String? telNo}) = _$_CompanyDetails;

  factory _CompanyDetails.fromJson(Map<String, dynamic> json) =
      _$_CompanyDetails.fromJson;

  @override
  String? get companyName;
  @override
  String? get companyAddress;
  @override
  String? get registrationNumber;
  @override
  String? get vatNo;
  @override
  String? get companyLogoUrl;
  @override
  String? get seoDescription;
  @override
  String? get overview;
  @override
  List<String>? get cellPhoneNos;
  @override
  String? get email;
  @override
  String? get telNo;
  @override
  @JsonKey(ignore: true)
  _$$_CompanyDetailsCopyWith<_$_CompanyDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$LocalCompanyStaffModel {
  ImageHelperModel? get image => throw _privateConstructorUsedError;
  CompanyStaff? get staffDetails => throw _privateConstructorUsedError;
  bool? get isEditing => throw _privateConstructorUsedError;
  int? get index => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LocalCompanyStaffModelCopyWith<LocalCompanyStaffModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalCompanyStaffModelCopyWith<$Res> {
  factory $LocalCompanyStaffModelCopyWith(LocalCompanyStaffModel value,
          $Res Function(LocalCompanyStaffModel) then) =
      _$LocalCompanyStaffModelCopyWithImpl<$Res, LocalCompanyStaffModel>;
  @useResult
  $Res call(
      {ImageHelperModel? image,
      CompanyStaff? staffDetails,
      bool? isEditing,
      int? index});

  $ImageHelperModelCopyWith<$Res>? get image;
  $CompanyStaffCopyWith<$Res>? get staffDetails;
}

/// @nodoc
class _$LocalCompanyStaffModelCopyWithImpl<$Res,
        $Val extends LocalCompanyStaffModel>
    implements $LocalCompanyStaffModelCopyWith<$Res> {
  _$LocalCompanyStaffModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = freezed,
    Object? staffDetails = freezed,
    Object? isEditing = freezed,
    Object? index = freezed,
  }) {
    return _then(_value.copyWith(
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as ImageHelperModel?,
      staffDetails: freezed == staffDetails
          ? _value.staffDetails
          : staffDetails // ignore: cast_nullable_to_non_nullable
              as CompanyStaff?,
      isEditing: freezed == isEditing
          ? _value.isEditing
          : isEditing // ignore: cast_nullable_to_non_nullable
              as bool?,
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ImageHelperModelCopyWith<$Res>? get image {
    if (_value.image == null) {
      return null;
    }

    return $ImageHelperModelCopyWith<$Res>(_value.image!, (value) {
      return _then(_value.copyWith(image: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CompanyStaffCopyWith<$Res>? get staffDetails {
    if (_value.staffDetails == null) {
      return null;
    }

    return $CompanyStaffCopyWith<$Res>(_value.staffDetails!, (value) {
      return _then(_value.copyWith(staffDetails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_LocalCompanyStaffModelCopyWith<$Res>
    implements $LocalCompanyStaffModelCopyWith<$Res> {
  factory _$$_LocalCompanyStaffModelCopyWith(_$_LocalCompanyStaffModel value,
          $Res Function(_$_LocalCompanyStaffModel) then) =
      __$$_LocalCompanyStaffModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ImageHelperModel? image,
      CompanyStaff? staffDetails,
      bool? isEditing,
      int? index});

  @override
  $ImageHelperModelCopyWith<$Res>? get image;
  @override
  $CompanyStaffCopyWith<$Res>? get staffDetails;
}

/// @nodoc
class __$$_LocalCompanyStaffModelCopyWithImpl<$Res>
    extends _$LocalCompanyStaffModelCopyWithImpl<$Res,
        _$_LocalCompanyStaffModel>
    implements _$$_LocalCompanyStaffModelCopyWith<$Res> {
  __$$_LocalCompanyStaffModelCopyWithImpl(_$_LocalCompanyStaffModel _value,
      $Res Function(_$_LocalCompanyStaffModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = freezed,
    Object? staffDetails = freezed,
    Object? isEditing = freezed,
    Object? index = freezed,
  }) {
    return _then(_$_LocalCompanyStaffModel(
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as ImageHelperModel?,
      staffDetails: freezed == staffDetails
          ? _value.staffDetails
          : staffDetails // ignore: cast_nullable_to_non_nullable
              as CompanyStaff?,
      isEditing: freezed == isEditing
          ? _value.isEditing
          : isEditing // ignore: cast_nullable_to_non_nullable
              as bool?,
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_LocalCompanyStaffModel
    with DiagnosticableTreeMixin
    implements _LocalCompanyStaffModel {
  _$_LocalCompanyStaffModel(
      {this.image, this.staffDetails, this.isEditing, this.index});

  @override
  final ImageHelperModel? image;
  @override
  final CompanyStaff? staffDetails;
  @override
  final bool? isEditing;
  @override
  final int? index;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LocalCompanyStaffModel(image: $image, staffDetails: $staffDetails, isEditing: $isEditing, index: $index)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LocalCompanyStaffModel'))
      ..add(DiagnosticsProperty('image', image))
      ..add(DiagnosticsProperty('staffDetails', staffDetails))
      ..add(DiagnosticsProperty('isEditing', isEditing))
      ..add(DiagnosticsProperty('index', index));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LocalCompanyStaffModel &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.staffDetails, staffDetails) ||
                other.staffDetails == staffDetails) &&
            (identical(other.isEditing, isEditing) ||
                other.isEditing == isEditing) &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, image, staffDetails, isEditing, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LocalCompanyStaffModelCopyWith<_$_LocalCompanyStaffModel> get copyWith =>
      __$$_LocalCompanyStaffModelCopyWithImpl<_$_LocalCompanyStaffModel>(
          this, _$identity);
}

abstract class _LocalCompanyStaffModel implements LocalCompanyStaffModel {
  factory _LocalCompanyStaffModel(
      {final ImageHelperModel? image,
      final CompanyStaff? staffDetails,
      final bool? isEditing,
      final int? index}) = _$_LocalCompanyStaffModel;

  @override
  ImageHelperModel? get image;
  @override
  CompanyStaff? get staffDetails;
  @override
  bool? get isEditing;
  @override
  int? get index;
  @override
  @JsonKey(ignore: true)
  _$$_LocalCompanyStaffModelCopyWith<_$_LocalCompanyStaffModel> get copyWith =>
      throw _privateConstructorUsedError;
}

VideoAndGalleryModel _$VideoAndGalleryModelFromJson(Map<String, dynamic> json) {
  return _VideoAndGalleryModel.fromJson(json);
}

/// @nodoc
mixin _$VideoAndGalleryModel {
  List<Gallery>? get image => throw _privateConstructorUsedError;
  List<VideoDTOModel>? get video => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VideoAndGalleryModelCopyWith<VideoAndGalleryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoAndGalleryModelCopyWith<$Res> {
  factory $VideoAndGalleryModelCopyWith(VideoAndGalleryModel value,
          $Res Function(VideoAndGalleryModel) then) =
      _$VideoAndGalleryModelCopyWithImpl<$Res, VideoAndGalleryModel>;
  @useResult
  $Res call({List<Gallery>? image, List<VideoDTOModel>? video});
}

/// @nodoc
class _$VideoAndGalleryModelCopyWithImpl<$Res,
        $Val extends VideoAndGalleryModel>
    implements $VideoAndGalleryModelCopyWith<$Res> {
  _$VideoAndGalleryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = freezed,
    Object? video = freezed,
  }) {
    return _then(_value.copyWith(
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as List<Gallery>?,
      video: freezed == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as List<VideoDTOModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_VideoAndGalleryModelCopyWith<$Res>
    implements $VideoAndGalleryModelCopyWith<$Res> {
  factory _$$_VideoAndGalleryModelCopyWith(_$_VideoAndGalleryModel value,
          $Res Function(_$_VideoAndGalleryModel) then) =
      __$$_VideoAndGalleryModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Gallery>? image, List<VideoDTOModel>? video});
}

/// @nodoc
class __$$_VideoAndGalleryModelCopyWithImpl<$Res>
    extends _$VideoAndGalleryModelCopyWithImpl<$Res, _$_VideoAndGalleryModel>
    implements _$$_VideoAndGalleryModelCopyWith<$Res> {
  __$$_VideoAndGalleryModelCopyWithImpl(_$_VideoAndGalleryModel _value,
      $Res Function(_$_VideoAndGalleryModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = freezed,
    Object? video = freezed,
  }) {
    return _then(_$_VideoAndGalleryModel(
      image: freezed == image
          ? _value._image
          : image // ignore: cast_nullable_to_non_nullable
              as List<Gallery>?,
      video: freezed == video
          ? _value._video
          : video // ignore: cast_nullable_to_non_nullable
              as List<VideoDTOModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_VideoAndGalleryModel
    with DiagnosticableTreeMixin
    implements _VideoAndGalleryModel {
  _$_VideoAndGalleryModel(
      {final List<Gallery>? image, final List<VideoDTOModel>? video})
      : _image = image,
        _video = video;

  factory _$_VideoAndGalleryModel.fromJson(Map<String, dynamic> json) =>
      _$$_VideoAndGalleryModelFromJson(json);

  final List<Gallery>? _image;
  @override
  List<Gallery>? get image {
    final value = _image;
    if (value == null) return null;
    if (_image is EqualUnmodifiableListView) return _image;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<VideoDTOModel>? _video;
  @override
  List<VideoDTOModel>? get video {
    final value = _video;
    if (value == null) return null;
    if (_video is EqualUnmodifiableListView) return _video;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'VideoAndGalleryModel(image: $image, video: $video)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'VideoAndGalleryModel'))
      ..add(DiagnosticsProperty('image', image))
      ..add(DiagnosticsProperty('video', video));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VideoAndGalleryModel &&
            const DeepCollectionEquality().equals(other._image, _image) &&
            const DeepCollectionEquality().equals(other._video, _video));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_image),
      const DeepCollectionEquality().hash(_video));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_VideoAndGalleryModelCopyWith<_$_VideoAndGalleryModel> get copyWith =>
      __$$_VideoAndGalleryModelCopyWithImpl<_$_VideoAndGalleryModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VideoAndGalleryModelToJson(
      this,
    );
  }
}

abstract class _VideoAndGalleryModel implements VideoAndGalleryModel {
  factory _VideoAndGalleryModel(
      {final List<Gallery>? image,
      final List<VideoDTOModel>? video}) = _$_VideoAndGalleryModel;

  factory _VideoAndGalleryModel.fromJson(Map<String, dynamic> json) =
      _$_VideoAndGalleryModel.fromJson;

  @override
  List<Gallery>? get image;
  @override
  List<VideoDTOModel>? get video;
  @override
  @JsonKey(ignore: true)
  _$$_VideoAndGalleryModelCopyWith<_$_VideoAndGalleryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

VideoDTOModel _$VideoDTOModelFromJson(Map<String, dynamic> json) {
  return _VideoDTOModel.fromJson(json);
}

/// @nodoc
mixin _$VideoDTOModel {
  String? get videoUrl => throw _privateConstructorUsedError;
  String? get videoDescription => throw _privateConstructorUsedError;
  bool? get isEditing => throw _privateConstructorUsedError;
  int? get index => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VideoDTOModelCopyWith<VideoDTOModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoDTOModelCopyWith<$Res> {
  factory $VideoDTOModelCopyWith(
          VideoDTOModel value, $Res Function(VideoDTOModel) then) =
      _$VideoDTOModelCopyWithImpl<$Res, VideoDTOModel>;
  @useResult
  $Res call(
      {String? videoUrl,
      String? videoDescription,
      bool? isEditing,
      int? index,
      String? id});
}

/// @nodoc
class _$VideoDTOModelCopyWithImpl<$Res, $Val extends VideoDTOModel>
    implements $VideoDTOModelCopyWith<$Res> {
  _$VideoDTOModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoUrl = freezed,
    Object? videoDescription = freezed,
    Object? isEditing = freezed,
    Object? index = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      videoUrl: freezed == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      videoDescription: freezed == videoDescription
          ? _value.videoDescription
          : videoDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      isEditing: freezed == isEditing
          ? _value.isEditing
          : isEditing // ignore: cast_nullable_to_non_nullable
              as bool?,
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_VideoDTOModelCopyWith<$Res>
    implements $VideoDTOModelCopyWith<$Res> {
  factory _$$_VideoDTOModelCopyWith(
          _$_VideoDTOModel value, $Res Function(_$_VideoDTOModel) then) =
      __$$_VideoDTOModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? videoUrl,
      String? videoDescription,
      bool? isEditing,
      int? index,
      String? id});
}

/// @nodoc
class __$$_VideoDTOModelCopyWithImpl<$Res>
    extends _$VideoDTOModelCopyWithImpl<$Res, _$_VideoDTOModel>
    implements _$$_VideoDTOModelCopyWith<$Res> {
  __$$_VideoDTOModelCopyWithImpl(
      _$_VideoDTOModel _value, $Res Function(_$_VideoDTOModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoUrl = freezed,
    Object? videoDescription = freezed,
    Object? isEditing = freezed,
    Object? index = freezed,
    Object? id = freezed,
  }) {
    return _then(_$_VideoDTOModel(
      videoUrl: freezed == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      videoDescription: freezed == videoDescription
          ? _value.videoDescription
          : videoDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      isEditing: freezed == isEditing
          ? _value.isEditing
          : isEditing // ignore: cast_nullable_to_non_nullable
              as bool?,
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_VideoDTOModel with DiagnosticableTreeMixin implements _VideoDTOModel {
  _$_VideoDTOModel(
      {this.videoUrl,
      this.videoDescription,
      this.isEditing,
      this.index,
      this.id});

  factory _$_VideoDTOModel.fromJson(Map<String, dynamic> json) =>
      _$$_VideoDTOModelFromJson(json);

  @override
  final String? videoUrl;
  @override
  final String? videoDescription;
  @override
  final bool? isEditing;
  @override
  final int? index;
  @override
  final String? id;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'VideoDTOModel(videoUrl: $videoUrl, videoDescription: $videoDescription, isEditing: $isEditing, index: $index, id: $id)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'VideoDTOModel'))
      ..add(DiagnosticsProperty('videoUrl', videoUrl))
      ..add(DiagnosticsProperty('videoDescription', videoDescription))
      ..add(DiagnosticsProperty('isEditing', isEditing))
      ..add(DiagnosticsProperty('index', index))
      ..add(DiagnosticsProperty('id', id));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VideoDTOModel &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.videoDescription, videoDescription) ||
                other.videoDescription == videoDescription) &&
            (identical(other.isEditing, isEditing) ||
                other.isEditing == isEditing) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, videoUrl, videoDescription, isEditing, index, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_VideoDTOModelCopyWith<_$_VideoDTOModel> get copyWith =>
      __$$_VideoDTOModelCopyWithImpl<_$_VideoDTOModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VideoDTOModelToJson(
      this,
    );
  }
}

abstract class _VideoDTOModel implements VideoDTOModel {
  factory _VideoDTOModel(
      {final String? videoUrl,
      final String? videoDescription,
      final bool? isEditing,
      final int? index,
      final String? id}) = _$_VideoDTOModel;

  factory _VideoDTOModel.fromJson(Map<String, dynamic> json) =
      _$_VideoDTOModel.fromJson;

  @override
  String? get videoUrl;
  @override
  String? get videoDescription;
  @override
  bool? get isEditing;
  @override
  int? get index;
  @override
  String? get id;
  @override
  @JsonKey(ignore: true)
  _$$_VideoDTOModelCopyWith<_$_VideoDTOModel> get copyWith =>
      throw _privateConstructorUsedError;
}

GalleryDTOModel _$GalleryDTOModelFromJson(Map<String, dynamic> json) {
  return _GalleryDTOModel.fromJson(json);
}

/// @nodoc
mixin _$GalleryDTOModel {
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get imageTitle => throw _privateConstructorUsedError;
  String? get imageDescription => throw _privateConstructorUsedError;
  bool? get isEditing => throw _privateConstructorUsedError;
  int? get index => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GalleryDTOModelCopyWith<GalleryDTOModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GalleryDTOModelCopyWith<$Res> {
  factory $GalleryDTOModelCopyWith(
          GalleryDTOModel value, $Res Function(GalleryDTOModel) then) =
      _$GalleryDTOModelCopyWithImpl<$Res, GalleryDTOModel>;
  @useResult
  $Res call(
      {String? imageUrl,
      String? imageTitle,
      String? imageDescription,
      bool? isEditing,
      int? index,
      String? id});
}

/// @nodoc
class _$GalleryDTOModelCopyWithImpl<$Res, $Val extends GalleryDTOModel>
    implements $GalleryDTOModelCopyWith<$Res> {
  _$GalleryDTOModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUrl = freezed,
    Object? imageTitle = freezed,
    Object? imageDescription = freezed,
    Object? isEditing = freezed,
    Object? index = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      imageTitle: freezed == imageTitle
          ? _value.imageTitle
          : imageTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      imageDescription: freezed == imageDescription
          ? _value.imageDescription
          : imageDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      isEditing: freezed == isEditing
          ? _value.isEditing
          : isEditing // ignore: cast_nullable_to_non_nullable
              as bool?,
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GalleryDTOModelCopyWith<$Res>
    implements $GalleryDTOModelCopyWith<$Res> {
  factory _$$_GalleryDTOModelCopyWith(
          _$_GalleryDTOModel value, $Res Function(_$_GalleryDTOModel) then) =
      __$$_GalleryDTOModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? imageUrl,
      String? imageTitle,
      String? imageDescription,
      bool? isEditing,
      int? index,
      String? id});
}

/// @nodoc
class __$$_GalleryDTOModelCopyWithImpl<$Res>
    extends _$GalleryDTOModelCopyWithImpl<$Res, _$_GalleryDTOModel>
    implements _$$_GalleryDTOModelCopyWith<$Res> {
  __$$_GalleryDTOModelCopyWithImpl(
      _$_GalleryDTOModel _value, $Res Function(_$_GalleryDTOModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUrl = freezed,
    Object? imageTitle = freezed,
    Object? imageDescription = freezed,
    Object? isEditing = freezed,
    Object? index = freezed,
    Object? id = freezed,
  }) {
    return _then(_$_GalleryDTOModel(
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      imageTitle: freezed == imageTitle
          ? _value.imageTitle
          : imageTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      imageDescription: freezed == imageDescription
          ? _value.imageDescription
          : imageDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      isEditing: freezed == isEditing
          ? _value.isEditing
          : isEditing // ignore: cast_nullable_to_non_nullable
              as bool?,
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GalleryDTOModel
    with DiagnosticableTreeMixin
    implements _GalleryDTOModel {
  _$_GalleryDTOModel(
      {this.imageUrl,
      this.imageTitle,
      this.imageDescription,
      this.isEditing,
      this.index,
      this.id});

  factory _$_GalleryDTOModel.fromJson(Map<String, dynamic> json) =>
      _$$_GalleryDTOModelFromJson(json);

  @override
  final String? imageUrl;
  @override
  final String? imageTitle;
  @override
  final String? imageDescription;
  @override
  final bool? isEditing;
  @override
  final int? index;
  @override
  final String? id;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GalleryDTOModel(imageUrl: $imageUrl, imageTitle: $imageTitle, imageDescription: $imageDescription, isEditing: $isEditing, index: $index, id: $id)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GalleryDTOModel'))
      ..add(DiagnosticsProperty('imageUrl', imageUrl))
      ..add(DiagnosticsProperty('imageTitle', imageTitle))
      ..add(DiagnosticsProperty('imageDescription', imageDescription))
      ..add(DiagnosticsProperty('isEditing', isEditing))
      ..add(DiagnosticsProperty('index', index))
      ..add(DiagnosticsProperty('id', id));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GalleryDTOModel &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.imageTitle, imageTitle) ||
                other.imageTitle == imageTitle) &&
            (identical(other.imageDescription, imageDescription) ||
                other.imageDescription == imageDescription) &&
            (identical(other.isEditing, isEditing) ||
                other.isEditing == isEditing) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, imageUrl, imageTitle,
      imageDescription, isEditing, index, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GalleryDTOModelCopyWith<_$_GalleryDTOModel> get copyWith =>
      __$$_GalleryDTOModelCopyWithImpl<_$_GalleryDTOModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GalleryDTOModelToJson(
      this,
    );
  }
}

abstract class _GalleryDTOModel implements GalleryDTOModel {
  factory _GalleryDTOModel(
      {final String? imageUrl,
      final String? imageTitle,
      final String? imageDescription,
      final bool? isEditing,
      final int? index,
      final String? id}) = _$_GalleryDTOModel;

  factory _GalleryDTOModel.fromJson(Map<String, dynamic> json) =
      _$_GalleryDTOModel.fromJson;

  @override
  String? get imageUrl;
  @override
  String? get imageTitle;
  @override
  String? get imageDescription;
  @override
  bool? get isEditing;
  @override
  int? get index;
  @override
  String? get id;
  @override
  @JsonKey(ignore: true)
  _$$_GalleryDTOModelCopyWith<_$_GalleryDTOModel> get copyWith =>
      throw _privateConstructorUsedError;
}
