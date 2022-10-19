// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'bookings_model.g.dart';

@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
)
class BookingModel {
  String? bookingCode;
  CustomerDetails? customerDetails;
  ActivityDetails? activityDetails;
  DateTime? departureDate;
  DateTime? arrivalDate;
  bool? paid;
  double? amountPaid;

  BookingModel({
    this.bookingCode,
    this.customerDetails,
    this.activityDetails,
    this.departureDate,
    this.arrivalDate,
    this.paid,
    this.amountPaid,
  });

  BookingModel copyWith({
    String? bookingCode,
    CustomerDetails? customerDetails,
    ActivityDetails? activityDetails,
    DateTime? departureDate,
    DateTime? arrivalDate,
    bool? paid,
    double? amountPaid,
  }) {
    return BookingModel(
      bookingCode: bookingCode ?? this.bookingCode,
      customerDetails: customerDetails ?? this.customerDetails,
      activityDetails: activityDetails ?? this.activityDetails,
      departureDate: departureDate ?? this.departureDate,
      arrivalDate: arrivalDate ?? this.arrivalDate,
      paid: paid ?? this.paid,
      amountPaid: amountPaid ?? this.amountPaid,
    );
  }

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingModelToJson(this);
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

  BookedPackage copyWith({
    String? packageId,
    String? packageName,
  }) {
    return BookedPackage(
      packageId: packageId ?? this.packageId,
      packageName: packageName ?? this.packageName,
    );
  }

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

  CustomerDetails copyWith({
    String? fullNames,
    String? email,
    CreditCardModel? creditCardDetails,
  }) {
    return CustomerDetails(
      fullNames: fullNames ?? this.fullNames,
      email: email ?? this.email,
      creditCardDetails: creditCardDetails ?? this.creditCardDetails,
    );
  }

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

  CreditCardModel copyWith({
    String? cardNumber,
    String? cardHolderNames,
    DateTime? expiryDate,
    String? cvv,
  }) {
    return CreditCardModel(
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolderNames: cardHolderNames ?? this.cardHolderNames,
      expiryDate: expiryDate ?? this.expiryDate,
      cvv: cvv ?? this.cvv,
    );
  }

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
