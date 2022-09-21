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
  final String? overview;
  Activity({
    this.activityId,
    this.activityName,
    this.seoDescription,
    this.tags,
    this.packages,
    this.activityGallery,
    this.createdAt,
    this.updatedAt,
    this.overview,
  });

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);

  Activity copyWith({
    String? activityId,
    String? activityName,
    String? seoDescription,
    List<String>? tags,
    List<Package>? packages,
    List<Gallery>? activityGallery,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? overview,
  }) {
    return Activity(
      activityId: activityId ?? this.activityId,
      activityName: activityName ?? this.activityName,
      seoDescription: seoDescription ?? this.seoDescription,
      tags: tags ?? this.tags,
      packages: packages ?? this.packages,
      activityGallery: activityGallery ?? this.activityGallery,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      overview: overview ?? this.overview,
    );
  }
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
  });

  factory Package.fromJson(Map<String, dynamic> json) =>
      _$PackageFromJson(json);

  Map<String, dynamic> toJson() => _$PackageToJson(this);
}
