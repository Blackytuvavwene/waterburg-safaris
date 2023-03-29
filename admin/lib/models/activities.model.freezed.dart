// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activities.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Activity _$ActivityFromJson(Map<String, dynamic> json) {
  return _Activity.fromJson(json);
}

/// @nodoc
mixin _$Activity {
  String? get activityId => throw _privateConstructorUsedError;
  String? get activityName => throw _privateConstructorUsedError;
  String? get seoDescription => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  List<Package>? get packages => throw _privateConstructorUsedError;
  List<Gallery>? get activityGallery => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String? get overview => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ActivityCopyWith<Activity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityCopyWith<$Res> {
  factory $ActivityCopyWith(Activity value, $Res Function(Activity) then) =
      _$ActivityCopyWithImpl<$Res, Activity>;
  @useResult
  $Res call(
      {String? activityId,
      String? activityName,
      String? seoDescription,
      List<String>? tags,
      List<Package>? packages,
      List<Gallery>? activityGallery,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? overview});
}

/// @nodoc
class _$ActivityCopyWithImpl<$Res, $Val extends Activity>
    implements $ActivityCopyWith<$Res> {
  _$ActivityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activityId = freezed,
    Object? activityName = freezed,
    Object? seoDescription = freezed,
    Object? tags = freezed,
    Object? packages = freezed,
    Object? activityGallery = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? overview = freezed,
  }) {
    return _then(_value.copyWith(
      activityId: freezed == activityId
          ? _value.activityId
          : activityId // ignore: cast_nullable_to_non_nullable
              as String?,
      activityName: freezed == activityName
          ? _value.activityName
          : activityName // ignore: cast_nullable_to_non_nullable
              as String?,
      seoDescription: freezed == seoDescription
          ? _value.seoDescription
          : seoDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      packages: freezed == packages
          ? _value.packages
          : packages // ignore: cast_nullable_to_non_nullable
              as List<Package>?,
      activityGallery: freezed == activityGallery
          ? _value.activityGallery
          : activityGallery // ignore: cast_nullable_to_non_nullable
              as List<Gallery>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ActivityCopyWith<$Res> implements $ActivityCopyWith<$Res> {
  factory _$$_ActivityCopyWith(
          _$_Activity value, $Res Function(_$_Activity) then) =
      __$$_ActivityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? activityId,
      String? activityName,
      String? seoDescription,
      List<String>? tags,
      List<Package>? packages,
      List<Gallery>? activityGallery,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? overview});
}

/// @nodoc
class __$$_ActivityCopyWithImpl<$Res>
    extends _$ActivityCopyWithImpl<$Res, _$_Activity>
    implements _$$_ActivityCopyWith<$Res> {
  __$$_ActivityCopyWithImpl(
      _$_Activity _value, $Res Function(_$_Activity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activityId = freezed,
    Object? activityName = freezed,
    Object? seoDescription = freezed,
    Object? tags = freezed,
    Object? packages = freezed,
    Object? activityGallery = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? overview = freezed,
  }) {
    return _then(_$_Activity(
      activityId: freezed == activityId
          ? _value.activityId
          : activityId // ignore: cast_nullable_to_non_nullable
              as String?,
      activityName: freezed == activityName
          ? _value.activityName
          : activityName // ignore: cast_nullable_to_non_nullable
              as String?,
      seoDescription: freezed == seoDescription
          ? _value.seoDescription
          : seoDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      packages: freezed == packages
          ? _value._packages
          : packages // ignore: cast_nullable_to_non_nullable
              as List<Package>?,
      activityGallery: freezed == activityGallery
          ? _value._activityGallery
          : activityGallery // ignore: cast_nullable_to_non_nullable
              as List<Gallery>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true, anyMap: true)
class _$_Activity with DiagnosticableTreeMixin implements _Activity {
  _$_Activity(
      {this.activityId,
      this.activityName,
      this.seoDescription,
      final List<String>? tags,
      final List<Package>? packages,
      final List<Gallery>? activityGallery,
      this.createdAt,
      this.updatedAt,
      this.overview})
      : _tags = tags,
        _packages = packages,
        _activityGallery = activityGallery;

  factory _$_Activity.fromJson(Map<String, dynamic> json) =>
      _$$_ActivityFromJson(json);

  @override
  final String? activityId;
  @override
  final String? activityName;
  @override
  final String? seoDescription;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Package>? _packages;
  @override
  List<Package>? get packages {
    final value = _packages;
    if (value == null) return null;
    if (_packages is EqualUnmodifiableListView) return _packages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Gallery>? _activityGallery;
  @override
  List<Gallery>? get activityGallery {
    final value = _activityGallery;
    if (value == null) return null;
    if (_activityGallery is EqualUnmodifiableListView) return _activityGallery;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? overview;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Activity(activityId: $activityId, activityName: $activityName, seoDescription: $seoDescription, tags: $tags, packages: $packages, activityGallery: $activityGallery, createdAt: $createdAt, updatedAt: $updatedAt, overview: $overview)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Activity'))
      ..add(DiagnosticsProperty('activityId', activityId))
      ..add(DiagnosticsProperty('activityName', activityName))
      ..add(DiagnosticsProperty('seoDescription', seoDescription))
      ..add(DiagnosticsProperty('tags', tags))
      ..add(DiagnosticsProperty('packages', packages))
      ..add(DiagnosticsProperty('activityGallery', activityGallery))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('overview', overview));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Activity &&
            (identical(other.activityId, activityId) ||
                other.activityId == activityId) &&
            (identical(other.activityName, activityName) ||
                other.activityName == activityName) &&
            (identical(other.seoDescription, seoDescription) ||
                other.seoDescription == seoDescription) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality().equals(other._packages, _packages) &&
            const DeepCollectionEquality()
                .equals(other._activityGallery, _activityGallery) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.overview, overview) ||
                other.overview == overview));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      activityId,
      activityName,
      seoDescription,
      const DeepCollectionEquality().hash(_tags),
      const DeepCollectionEquality().hash(_packages),
      const DeepCollectionEquality().hash(_activityGallery),
      createdAt,
      updatedAt,
      overview);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ActivityCopyWith<_$_Activity> get copyWith =>
      __$$_ActivityCopyWithImpl<_$_Activity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ActivityToJson(
      this,
    );
  }
}

abstract class _Activity implements Activity {
  factory _Activity(
      {final String? activityId,
      final String? activityName,
      final String? seoDescription,
      final List<String>? tags,
      final List<Package>? packages,
      final List<Gallery>? activityGallery,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final String? overview}) = _$_Activity;

  factory _Activity.fromJson(Map<String, dynamic> json) = _$_Activity.fromJson;

  @override
  String? get activityId;
  @override
  String? get activityName;
  @override
  String? get seoDescription;
  @override
  List<String>? get tags;
  @override
  List<Package>? get packages;
  @override
  List<Gallery>? get activityGallery;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  String? get overview;
  @override
  @JsonKey(ignore: true)
  _$$_ActivityCopyWith<_$_Activity> get copyWith =>
      throw _privateConstructorUsedError;
}

Package _$PackageFromJson(Map<String, dynamic> json) {
  return _Package.fromJson(json);
}

/// @nodoc
mixin _$Package {
  String? get packageId => throw _privateConstructorUsedError;
  String? get packageName => throw _privateConstructorUsedError;
  List<String>? get keywords => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  double? get price => throw _privateConstructorUsedError;
  double? get lastPrice => throw _privateConstructorUsedError;
  double? get rating => throw _privateConstructorUsedError;
  double? get discountPercentage => throw _privateConstructorUsedError;
  String? get coupon => throw _privateConstructorUsedError;
  List<String>? get packageOffers => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PackageCopyWith<Package> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PackageCopyWith<$Res> {
  factory $PackageCopyWith(Package value, $Res Function(Package) then) =
      _$PackageCopyWithImpl<$Res, Package>;
  @useResult
  $Res call(
      {String? packageId,
      String? packageName,
      List<String>? keywords,
      String? description,
      double? price,
      double? lastPrice,
      double? rating,
      double? discountPercentage,
      String? coupon,
      List<String>? packageOffers});
}

/// @nodoc
class _$PackageCopyWithImpl<$Res, $Val extends Package>
    implements $PackageCopyWith<$Res> {
  _$PackageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? packageId = freezed,
    Object? packageName = freezed,
    Object? keywords = freezed,
    Object? description = freezed,
    Object? price = freezed,
    Object? lastPrice = freezed,
    Object? rating = freezed,
    Object? discountPercentage = freezed,
    Object? coupon = freezed,
    Object? packageOffers = freezed,
  }) {
    return _then(_value.copyWith(
      packageId: freezed == packageId
          ? _value.packageId
          : packageId // ignore: cast_nullable_to_non_nullable
              as String?,
      packageName: freezed == packageName
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String?,
      keywords: freezed == keywords
          ? _value.keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      lastPrice: freezed == lastPrice
          ? _value.lastPrice
          : lastPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      discountPercentage: freezed == discountPercentage
          ? _value.discountPercentage
          : discountPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
      coupon: freezed == coupon
          ? _value.coupon
          : coupon // ignore: cast_nullable_to_non_nullable
              as String?,
      packageOffers: freezed == packageOffers
          ? _value.packageOffers
          : packageOffers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PackageCopyWith<$Res> implements $PackageCopyWith<$Res> {
  factory _$$_PackageCopyWith(
          _$_Package value, $Res Function(_$_Package) then) =
      __$$_PackageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? packageId,
      String? packageName,
      List<String>? keywords,
      String? description,
      double? price,
      double? lastPrice,
      double? rating,
      double? discountPercentage,
      String? coupon,
      List<String>? packageOffers});
}

/// @nodoc
class __$$_PackageCopyWithImpl<$Res>
    extends _$PackageCopyWithImpl<$Res, _$_Package>
    implements _$$_PackageCopyWith<$Res> {
  __$$_PackageCopyWithImpl(_$_Package _value, $Res Function(_$_Package) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? packageId = freezed,
    Object? packageName = freezed,
    Object? keywords = freezed,
    Object? description = freezed,
    Object? price = freezed,
    Object? lastPrice = freezed,
    Object? rating = freezed,
    Object? discountPercentage = freezed,
    Object? coupon = freezed,
    Object? packageOffers = freezed,
  }) {
    return _then(_$_Package(
      packageId: freezed == packageId
          ? _value.packageId
          : packageId // ignore: cast_nullable_to_non_nullable
              as String?,
      packageName: freezed == packageName
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String?,
      keywords: freezed == keywords
          ? _value._keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      lastPrice: freezed == lastPrice
          ? _value.lastPrice
          : lastPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      discountPercentage: freezed == discountPercentage
          ? _value.discountPercentage
          : discountPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
      coupon: freezed == coupon
          ? _value.coupon
          : coupon // ignore: cast_nullable_to_non_nullable
              as String?,
      packageOffers: freezed == packageOffers
          ? _value._packageOffers
          : packageOffers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true, anyMap: true)
class _$_Package with DiagnosticableTreeMixin implements _Package {
  _$_Package(
      {this.packageId,
      this.packageName,
      final List<String>? keywords,
      this.description,
      this.price,
      this.lastPrice,
      this.rating,
      this.discountPercentage,
      this.coupon,
      final List<String>? packageOffers})
      : _keywords = keywords,
        _packageOffers = packageOffers;

  factory _$_Package.fromJson(Map<String, dynamic> json) =>
      _$$_PackageFromJson(json);

  @override
  final String? packageId;
  @override
  final String? packageName;
  final List<String>? _keywords;
  @override
  List<String>? get keywords {
    final value = _keywords;
    if (value == null) return null;
    if (_keywords is EqualUnmodifiableListView) return _keywords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? description;
  @override
  final double? price;
  @override
  final double? lastPrice;
  @override
  final double? rating;
  @override
  final double? discountPercentage;
  @override
  final String? coupon;
  final List<String>? _packageOffers;
  @override
  List<String>? get packageOffers {
    final value = _packageOffers;
    if (value == null) return null;
    if (_packageOffers is EqualUnmodifiableListView) return _packageOffers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Package(packageId: $packageId, packageName: $packageName, keywords: $keywords, description: $description, price: $price, lastPrice: $lastPrice, rating: $rating, discountPercentage: $discountPercentage, coupon: $coupon, packageOffers: $packageOffers)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Package'))
      ..add(DiagnosticsProperty('packageId', packageId))
      ..add(DiagnosticsProperty('packageName', packageName))
      ..add(DiagnosticsProperty('keywords', keywords))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('price', price))
      ..add(DiagnosticsProperty('lastPrice', lastPrice))
      ..add(DiagnosticsProperty('rating', rating))
      ..add(DiagnosticsProperty('discountPercentage', discountPercentage))
      ..add(DiagnosticsProperty('coupon', coupon))
      ..add(DiagnosticsProperty('packageOffers', packageOffers));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Package &&
            (identical(other.packageId, packageId) ||
                other.packageId == packageId) &&
            (identical(other.packageName, packageName) ||
                other.packageName == packageName) &&
            const DeepCollectionEquality().equals(other._keywords, _keywords) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.lastPrice, lastPrice) ||
                other.lastPrice == lastPrice) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.discountPercentage, discountPercentage) ||
                other.discountPercentage == discountPercentage) &&
            (identical(other.coupon, coupon) || other.coupon == coupon) &&
            const DeepCollectionEquality()
                .equals(other._packageOffers, _packageOffers));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      packageId,
      packageName,
      const DeepCollectionEquality().hash(_keywords),
      description,
      price,
      lastPrice,
      rating,
      discountPercentage,
      coupon,
      const DeepCollectionEquality().hash(_packageOffers));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PackageCopyWith<_$_Package> get copyWith =>
      __$$_PackageCopyWithImpl<_$_Package>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PackageToJson(
      this,
    );
  }
}

abstract class _Package implements Package {
  factory _Package(
      {final String? packageId,
      final String? packageName,
      final List<String>? keywords,
      final String? description,
      final double? price,
      final double? lastPrice,
      final double? rating,
      final double? discountPercentage,
      final String? coupon,
      final List<String>? packageOffers}) = _$_Package;

  factory _Package.fromJson(Map<String, dynamic> json) = _$_Package.fromJson;

  @override
  String? get packageId;
  @override
  String? get packageName;
  @override
  List<String>? get keywords;
  @override
  String? get description;
  @override
  double? get price;
  @override
  double? get lastPrice;
  @override
  double? get rating;
  @override
  double? get discountPercentage;
  @override
  String? get coupon;
  @override
  List<String>? get packageOffers;
  @override
  @JsonKey(ignore: true)
  _$$_PackageCopyWith<_$_Package> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ImageHelperModel {
  XFile? get xFile => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;
  Uint8List? get bytes => throw _privateConstructorUsedError;
  ImageFile? get imageFile => throw _privateConstructorUsedError;
  Gallery? get imageDetails => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ImageHelperModelCopyWith<ImageHelperModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageHelperModelCopyWith<$Res> {
  factory $ImageHelperModelCopyWith(
          ImageHelperModel value, $Res Function(ImageHelperModel) then) =
      _$ImageHelperModelCopyWithImpl<$Res, ImageHelperModel>;
  @useResult
  $Res call(
      {XFile? xFile,
      String? name,
      String? path,
      Uint8List? bytes,
      ImageFile? imageFile,
      Gallery? imageDetails});

  $GalleryCopyWith<$Res>? get imageDetails;
}

/// @nodoc
class _$ImageHelperModelCopyWithImpl<$Res, $Val extends ImageHelperModel>
    implements $ImageHelperModelCopyWith<$Res> {
  _$ImageHelperModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? xFile = freezed,
    Object? name = freezed,
    Object? path = freezed,
    Object? bytes = freezed,
    Object? imageFile = freezed,
    Object? imageDetails = freezed,
  }) {
    return _then(_value.copyWith(
      xFile: freezed == xFile
          ? _value.xFile
          : xFile // ignore: cast_nullable_to_non_nullable
              as XFile?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      bytes: freezed == bytes
          ? _value.bytes
          : bytes // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      imageFile: freezed == imageFile
          ? _value.imageFile
          : imageFile // ignore: cast_nullable_to_non_nullable
              as ImageFile?,
      imageDetails: freezed == imageDetails
          ? _value.imageDetails
          : imageDetails // ignore: cast_nullable_to_non_nullable
              as Gallery?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GalleryCopyWith<$Res>? get imageDetails {
    if (_value.imageDetails == null) {
      return null;
    }

    return $GalleryCopyWith<$Res>(_value.imageDetails!, (value) {
      return _then(_value.copyWith(imageDetails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ImageHelperModelCopyWith<$Res>
    implements $ImageHelperModelCopyWith<$Res> {
  factory _$$_ImageHelperModelCopyWith(
          _$_ImageHelperModel value, $Res Function(_$_ImageHelperModel) then) =
      __$$_ImageHelperModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {XFile? xFile,
      String? name,
      String? path,
      Uint8List? bytes,
      ImageFile? imageFile,
      Gallery? imageDetails});

  @override
  $GalleryCopyWith<$Res>? get imageDetails;
}

/// @nodoc
class __$$_ImageHelperModelCopyWithImpl<$Res>
    extends _$ImageHelperModelCopyWithImpl<$Res, _$_ImageHelperModel>
    implements _$$_ImageHelperModelCopyWith<$Res> {
  __$$_ImageHelperModelCopyWithImpl(
      _$_ImageHelperModel _value, $Res Function(_$_ImageHelperModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? xFile = freezed,
    Object? name = freezed,
    Object? path = freezed,
    Object? bytes = freezed,
    Object? imageFile = freezed,
    Object? imageDetails = freezed,
  }) {
    return _then(_$_ImageHelperModel(
      xFile: freezed == xFile
          ? _value.xFile
          : xFile // ignore: cast_nullable_to_non_nullable
              as XFile?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      bytes: freezed == bytes
          ? _value.bytes
          : bytes // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      imageFile: freezed == imageFile
          ? _value.imageFile
          : imageFile // ignore: cast_nullable_to_non_nullable
              as ImageFile?,
      imageDetails: freezed == imageDetails
          ? _value.imageDetails
          : imageDetails // ignore: cast_nullable_to_non_nullable
              as Gallery?,
    ));
  }
}

/// @nodoc

class _$_ImageHelperModel
    with DiagnosticableTreeMixin
    implements _ImageHelperModel {
  _$_ImageHelperModel(
      {required this.xFile,
      required this.name,
      required this.path,
      required this.bytes,
      required this.imageFile,
      required this.imageDetails});

  @override
  final XFile? xFile;
  @override
  final String? name;
  @override
  final String? path;
  @override
  final Uint8List? bytes;
  @override
  final ImageFile? imageFile;
  @override
  final Gallery? imageDetails;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ImageHelperModel(xFile: $xFile, name: $name, path: $path, bytes: $bytes, imageFile: $imageFile, imageDetails: $imageDetails)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ImageHelperModel'))
      ..add(DiagnosticsProperty('xFile', xFile))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('path', path))
      ..add(DiagnosticsProperty('bytes', bytes))
      ..add(DiagnosticsProperty('imageFile', imageFile))
      ..add(DiagnosticsProperty('imageDetails', imageDetails));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ImageHelperModel &&
            (identical(other.xFile, xFile) || other.xFile == xFile) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.path, path) || other.path == path) &&
            const DeepCollectionEquality().equals(other.bytes, bytes) &&
            (identical(other.imageFile, imageFile) ||
                other.imageFile == imageFile) &&
            (identical(other.imageDetails, imageDetails) ||
                other.imageDetails == imageDetails));
  }

  @override
  int get hashCode => Object.hash(runtimeType, xFile, name, path,
      const DeepCollectionEquality().hash(bytes), imageFile, imageDetails);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ImageHelperModelCopyWith<_$_ImageHelperModel> get copyWith =>
      __$$_ImageHelperModelCopyWithImpl<_$_ImageHelperModel>(this, _$identity);
}

abstract class _ImageHelperModel implements ImageHelperModel {
  factory _ImageHelperModel(
      {required final XFile? xFile,
      required final String? name,
      required final String? path,
      required final Uint8List? bytes,
      required final ImageFile? imageFile,
      required final Gallery? imageDetails}) = _$_ImageHelperModel;

  @override
  XFile? get xFile;
  @override
  String? get name;
  @override
  String? get path;
  @override
  Uint8List? get bytes;
  @override
  ImageFile? get imageFile;
  @override
  Gallery? get imageDetails;
  @override
  @JsonKey(ignore: true)
  _$$_ImageHelperModelCopyWith<_$_ImageHelperModel> get copyWith =>
      throw _privateConstructorUsedError;
}
