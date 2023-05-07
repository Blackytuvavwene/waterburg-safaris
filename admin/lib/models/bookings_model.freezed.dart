// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bookings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) {
  return _BookingModel.fromJson(json);
}

/// @nodoc
mixin _$BookingModel {
  String? get bookingCode => throw _privateConstructorUsedError;
  CustomerDetails? get customerDetails => throw _privateConstructorUsedError;
  ActivityDetails? get activityDetails => throw _privateConstructorUsedError;
  DateTime? get departureDate => throw _privateConstructorUsedError;
  DateTime? get arrivalDate => throw _privateConstructorUsedError;
  bool? get paid => throw _privateConstructorUsedError;
  double? get amountPaid => throw _privateConstructorUsedError;
  String? get slug => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BookingModelCopyWith<BookingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingModelCopyWith<$Res> {
  factory $BookingModelCopyWith(
          BookingModel value, $Res Function(BookingModel) then) =
      _$BookingModelCopyWithImpl<$Res, BookingModel>;
  @useResult
  $Res call(
      {String? bookingCode,
      CustomerDetails? customerDetails,
      ActivityDetails? activityDetails,
      DateTime? departureDate,
      DateTime? arrivalDate,
      bool? paid,
      double? amountPaid,
      String? slug});
}

/// @nodoc
class _$BookingModelCopyWithImpl<$Res, $Val extends BookingModel>
    implements $BookingModelCopyWith<$Res> {
  _$BookingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingCode = freezed,
    Object? customerDetails = freezed,
    Object? activityDetails = freezed,
    Object? departureDate = freezed,
    Object? arrivalDate = freezed,
    Object? paid = freezed,
    Object? amountPaid = freezed,
    Object? slug = freezed,
  }) {
    return _then(_value.copyWith(
      bookingCode: freezed == bookingCode
          ? _value.bookingCode
          : bookingCode // ignore: cast_nullable_to_non_nullable
              as String?,
      customerDetails: freezed == customerDetails
          ? _value.customerDetails
          : customerDetails // ignore: cast_nullable_to_non_nullable
              as CustomerDetails?,
      activityDetails: freezed == activityDetails
          ? _value.activityDetails
          : activityDetails // ignore: cast_nullable_to_non_nullable
              as ActivityDetails?,
      departureDate: freezed == departureDate
          ? _value.departureDate
          : departureDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      arrivalDate: freezed == arrivalDate
          ? _value.arrivalDate
          : arrivalDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      paid: freezed == paid
          ? _value.paid
          : paid // ignore: cast_nullable_to_non_nullable
              as bool?,
      amountPaid: freezed == amountPaid
          ? _value.amountPaid
          : amountPaid // ignore: cast_nullable_to_non_nullable
              as double?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BookingModelCopyWith<$Res>
    implements $BookingModelCopyWith<$Res> {
  factory _$$_BookingModelCopyWith(
          _$_BookingModel value, $Res Function(_$_BookingModel) then) =
      __$$_BookingModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? bookingCode,
      CustomerDetails? customerDetails,
      ActivityDetails? activityDetails,
      DateTime? departureDate,
      DateTime? arrivalDate,
      bool? paid,
      double? amountPaid,
      String? slug});
}

/// @nodoc
class __$$_BookingModelCopyWithImpl<$Res>
    extends _$BookingModelCopyWithImpl<$Res, _$_BookingModel>
    implements _$$_BookingModelCopyWith<$Res> {
  __$$_BookingModelCopyWithImpl(
      _$_BookingModel _value, $Res Function(_$_BookingModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bookingCode = freezed,
    Object? customerDetails = freezed,
    Object? activityDetails = freezed,
    Object? departureDate = freezed,
    Object? arrivalDate = freezed,
    Object? paid = freezed,
    Object? amountPaid = freezed,
    Object? slug = freezed,
  }) {
    return _then(_$_BookingModel(
      bookingCode: freezed == bookingCode
          ? _value.bookingCode
          : bookingCode // ignore: cast_nullable_to_non_nullable
              as String?,
      customerDetails: freezed == customerDetails
          ? _value.customerDetails
          : customerDetails // ignore: cast_nullable_to_non_nullable
              as CustomerDetails?,
      activityDetails: freezed == activityDetails
          ? _value.activityDetails
          : activityDetails // ignore: cast_nullable_to_non_nullable
              as ActivityDetails?,
      departureDate: freezed == departureDate
          ? _value.departureDate
          : departureDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      arrivalDate: freezed == arrivalDate
          ? _value.arrivalDate
          : arrivalDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      paid: freezed == paid
          ? _value.paid
          : paid // ignore: cast_nullable_to_non_nullable
              as bool?,
      amountPaid: freezed == amountPaid
          ? _value.amountPaid
          : amountPaid // ignore: cast_nullable_to_non_nullable
              as double?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BookingModel implements _BookingModel {
  _$_BookingModel(
      {this.bookingCode,
      this.customerDetails,
      this.activityDetails,
      this.departureDate,
      this.arrivalDate,
      this.paid,
      this.amountPaid,
      this.slug});

  factory _$_BookingModel.fromJson(Map<String, dynamic> json) =>
      _$$_BookingModelFromJson(json);

  @override
  final String? bookingCode;
  @override
  final CustomerDetails? customerDetails;
  @override
  final ActivityDetails? activityDetails;
  @override
  final DateTime? departureDate;
  @override
  final DateTime? arrivalDate;
  @override
  final bool? paid;
  @override
  final double? amountPaid;
  @override
  final String? slug;

  @override
  String toString() {
    return 'BookingModel(bookingCode: $bookingCode, customerDetails: $customerDetails, activityDetails: $activityDetails, departureDate: $departureDate, arrivalDate: $arrivalDate, paid: $paid, amountPaid: $amountPaid, slug: $slug)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BookingModel &&
            (identical(other.bookingCode, bookingCode) ||
                other.bookingCode == bookingCode) &&
            (identical(other.customerDetails, customerDetails) ||
                other.customerDetails == customerDetails) &&
            (identical(other.activityDetails, activityDetails) ||
                other.activityDetails == activityDetails) &&
            (identical(other.departureDate, departureDate) ||
                other.departureDate == departureDate) &&
            (identical(other.arrivalDate, arrivalDate) ||
                other.arrivalDate == arrivalDate) &&
            (identical(other.paid, paid) || other.paid == paid) &&
            (identical(other.amountPaid, amountPaid) ||
                other.amountPaid == amountPaid) &&
            (identical(other.slug, slug) || other.slug == slug));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, bookingCode, customerDetails,
      activityDetails, departureDate, arrivalDate, paid, amountPaid, slug);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BookingModelCopyWith<_$_BookingModel> get copyWith =>
      __$$_BookingModelCopyWithImpl<_$_BookingModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BookingModelToJson(
      this,
    );
  }
}

abstract class _BookingModel implements BookingModel {
  factory _BookingModel(
      {final String? bookingCode,
      final CustomerDetails? customerDetails,
      final ActivityDetails? activityDetails,
      final DateTime? departureDate,
      final DateTime? arrivalDate,
      final bool? paid,
      final double? amountPaid,
      final String? slug}) = _$_BookingModel;

  factory _BookingModel.fromJson(Map<String, dynamic> json) =
      _$_BookingModel.fromJson;

  @override
  String? get bookingCode;
  @override
  CustomerDetails? get customerDetails;
  @override
  ActivityDetails? get activityDetails;
  @override
  DateTime? get departureDate;
  @override
  DateTime? get arrivalDate;
  @override
  bool? get paid;
  @override
  double? get amountPaid;
  @override
  String? get slug;
  @override
  @JsonKey(ignore: true)
  _$$_BookingModelCopyWith<_$_BookingModel> get copyWith =>
      throw _privateConstructorUsedError;
}
