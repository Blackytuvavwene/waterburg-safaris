// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityDetails _$ActivityDetailsFromJson(Map json) => ActivityDetails(
      activityId: json['activityId'] as String?,
      activityName: json['activityName'] as String?,
      bookedPackage: json['bookedPackage'] == null
          ? null
          : BookedPackage.fromJson(
              Map<String, dynamic>.from(json['bookedPackage'] as Map)),
    );

Map<String, dynamic> _$ActivityDetailsToJson(ActivityDetails instance) =>
    <String, dynamic>{
      'activityId': instance.activityId,
      'activityName': instance.activityName,
      'bookedPackage': instance.bookedPackage?.toJson(),
    };

BookedPackage _$BookedPackageFromJson(Map json) => BookedPackage(
      packageId: json['packageId'] as String?,
      packageName: json['packageName'] as String?,
    );

Map<String, dynamic> _$BookedPackageToJson(BookedPackage instance) =>
    <String, dynamic>{
      'packageId': instance.packageId,
      'packageName': instance.packageName,
    };

CustomerDetails _$CustomerDetailsFromJson(Map json) => CustomerDetails(
      fullNames: json['fullNames'] as String?,
      email: json['email'] as String?,
      creditCardDetails: json['creditCardDetails'] == null
          ? null
          : CreditCardModel.fromJson(
              Map<String, dynamic>.from(json['creditCardDetails'] as Map)),
    );

Map<String, dynamic> _$CustomerDetailsToJson(CustomerDetails instance) =>
    <String, dynamic>{
      'fullNames': instance.fullNames,
      'email': instance.email,
      'creditCardDetails': instance.creditCardDetails?.toJson(),
    };

CreditCardModel _$CreditCardModelFromJson(Map json) => CreditCardModel(
      cardNumber: json['cardNumber'] as String?,
      cardHolderNames: json['cardHolderNames'] as String?,
      expiryDate: _$JsonConverterFromJson<String, DateTime>(
          json['expiryDate'], const ExpiryDateConverter().fromJson),
      cvv: json['cvv'] as String?,
    );

Map<String, dynamic> _$CreditCardModelToJson(CreditCardModel instance) =>
    <String, dynamic>{
      'cardNumber': instance.cardNumber,
      'cardHolderNames': instance.cardHolderNames,
      'expiryDate': _$JsonConverterToJson<String, DateTime>(
          instance.expiryDate, const ExpiryDateConverter().toJson),
      'cvv': instance.cvv,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

_$_BookingModel _$$_BookingModelFromJson(Map<String, dynamic> json) =>
    _$_BookingModel(
      bookingCode: json['bookingCode'] as String?,
      customerDetails: json['customerDetails'] == null
          ? null
          : CustomerDetails.fromJson(
              json['customerDetails'] as Map<String, dynamic>),
      activityDetails: json['activityDetails'] == null
          ? null
          : ActivityDetails.fromJson(
              json['activityDetails'] as Map<String, dynamic>),
      departureDate: json['departureDate'] == null
          ? null
          : DateTime.parse(json['departureDate'] as String),
      arrivalDate: json['arrivalDate'] == null
          ? null
          : DateTime.parse(json['arrivalDate'] as String),
      paid: json['paid'] as bool?,
      amountPaid: (json['amountPaid'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_BookingModelToJson(_$_BookingModel instance) =>
    <String, dynamic>{
      'bookingCode': instance.bookingCode,
      'customerDetails': instance.customerDetails,
      'activityDetails': instance.activityDetails,
      'departureDate': instance.departureDate?.toIso8601String(),
      'arrivalDate': instance.arrivalDate?.toIso8601String(),
      'paid': instance.paid,
      'amountPaid': instance.amountPaid,
    };
