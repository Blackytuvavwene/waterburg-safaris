// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activities.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Activity _$$_ActivityFromJson(Map<String, dynamic> json) => _$_Activity(
      activityId: json['activityId'] as String?,
      activityName: json['activityName'] as String?,
      seoDescription: json['seoDescription'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      packages: (json['packages'] as List<dynamic>?)
          ?.map((e) => Package.fromJson(e as Map<String, dynamic>))
          .toList(),
      activityGallery: (json['activityGallery'] as List<dynamic>?)
          ?.map((e) => Gallery.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      overview: json['overview'] as String?,
    );

Map<String, dynamic> _$$_ActivityToJson(_$_Activity instance) =>
    <String, dynamic>{
      'activityId': instance.activityId,
      'activityName': instance.activityName,
      'seoDescription': instance.seoDescription,
      'tags': instance.tags,
      'packages': instance.packages,
      'activityGallery': instance.activityGallery,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'overview': instance.overview,
    };

_$_Package _$$_PackageFromJson(Map<String, dynamic> json) => _$_Package(
      packageId: json['packageId'] as String?,
      packageName: json['packageName'] as String?,
      keywords: (json['keywords'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      lastPrice: (json['lastPrice'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble(),
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
      coupon: json['coupon'] as String?,
      packageOffers: (json['packageOffers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_PackageToJson(_$_Package instance) =>
    <String, dynamic>{
      'packageId': instance.packageId,
      'packageName': instance.packageName,
      'keywords': instance.keywords,
      'description': instance.description,
      'price': instance.price,
      'lastPrice': instance.lastPrice,
      'rating': instance.rating,
      'discountPercentage': instance.discountPercentage,
      'coupon': instance.coupon,
      'packageOffers': instance.packageOffers,
    };
