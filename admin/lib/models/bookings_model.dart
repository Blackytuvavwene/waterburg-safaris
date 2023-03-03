// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';

// include freezed part
part 'bookings_model.freezed.dart';
part 'bookings_model.g.dart';

@Freezed()
class BookingModel with _$BookingModel {
  factory BookingModel({
    final String? bookingCode,
    final CustomerDetails? customerDetails,
    final ActivityDetails? activityDetails,
    final DateTime? departureDate,
    final DateTime? arrivalDate,
    final bool? paid,
    final double? amountPaid,
  }) = _BookingModel;

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);
}

@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
)
class ActivityDetails {
  String? activityId;
  String? activityName;
  BookedPackage? bookedPackage;

  ActivityDetails({
    this.activityId,
    this.activityName,
    this.bookedPackage,
  });

  ActivityDetails copyWith({
    String? activityId,
    String? activityName,
    BookedPackage? bookedPackage,
  }) {
    return ActivityDetails(
      activityId: activityId ?? this.activityId,
      activityName: activityName ?? this.activityName,
      bookedPackage: bookedPackage ?? this.bookedPackage,
    );
  }

  factory ActivityDetails.fromJson(Map<String, dynamic> json) =>
      _$ActivityDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityDetailsToJson(this);
}

@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
)
class BookedPackage {
  String? packageId;
  String? packageName;

  BookedPackage({
    this.packageId,
    this.packageName,
  });

  factory BookedPackage.fromJson(Map<String, dynamic> json) =>
      _$BookedPackageFromJson(json);

  Map<String, dynamic> toJson() => _$BookedPackageToJson(this);
}

@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
)
class CustomerDetails {
  String? fullNames;
  String? email;
  CreditCardModel? creditCardDetails;

  CustomerDetails({
    this.fullNames,
    this.email,
    this.creditCardDetails,
  });

  factory CustomerDetails.fromJson(Map<String, dynamic> json) =>
      _$CustomerDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerDetailsToJson(this);
}

@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
)
class CreditCardModel {
  String? cardNumber;
  String? cardHolderNames;
  @ExpiryDateConverter()
  DateTime? expiryDate;
  String? cvv;

  CreditCardModel({
    this.cardNumber,
    this.cardHolderNames,
    this.expiryDate,
    this.cvv,
  });

  factory CreditCardModel.fromJson(Map<String, dynamic> json) =>
      _$CreditCardModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreditCardModelToJson(this);
}

class ExpiryDateConverter implements JsonConverter<DateTime, String> {
  const ExpiryDateConverter();

  @override
  DateTime fromJson(String json) {
    // yyyy-mm to DateTime
    final parts = json.split('-');
    return DateTime(
      int.parse(parts[0]),
      int.parse(
        parts[1],
      ),
    );
  }

  @override
  String toJson(DateTime object) {
    return object.toIso8601String();
  }
}
