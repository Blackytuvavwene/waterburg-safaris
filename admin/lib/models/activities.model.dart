// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:admin/models/company.model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activities.model.g.dart';

@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
)
class Activity {
  final String? activityId;
  final String? activityName;
  final String? seoDescription;
  final List<String>? tags;
  final List<Package>? packages;
  final List<Gallery>? activityGallery;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  Activity({
    this.activityId,
    this.activityName,
    this.seoDescription,
    this.tags,
    this.packages,
    this.activityGallery,
    this.createdAt,
    this.updatedAt,
  });

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}

@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
)
class Package {
  final String? packageId;
  final String? packageName;
  final List<String>? keywords;
  final String? description;
  final double? price;
  final double? lastPrice;
  final double? rating;
  final double? discountPercentage;
  final String? coupon;
  final List<String>? packageOffers;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  Package({
    this.packageId,
    this.packageName,
    this.keywords,
    this.description,
    this.price,
    this.lastPrice,
    this.rating,
    this.discountPercentage,
    this.coupon,
    this.packageOffers,
    this.createdAt,
    this.updatedAt,
  });

  factory Package.fromJson(Map<String, dynamic> json) =>
      _$PackageFromJson(json);

  Map<String, dynamic> toJson() => _$PackageToJson(this);
}
