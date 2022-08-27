// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activities.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map json) => Activity(
      activityId: json['activityId'] as String?,
      activityName: json['activityName'] as String?,
      seoDescription: json['seoDescription'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      packages: (json['packages'] as List<dynamic>?)
          ?.map((e) => Package.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      activityGallery: (json['activityGallery'] as List<dynamic>?)
          ?.map((e) => Gallery.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'activityId': instance.activityId,
      'activityName': instance.activityName,
      'seoDescription': instance.seoDescription,
      'tags': instance.tags,
      'packages': instance.packages?.map((e) => e.toJson()).toList(),
      'activityGallery':
          instance.activityGallery?.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

Package _$PackageFromJson(Map json) => Package(
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
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$PackageToJson(Package instance) => <String, dynamic>{
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
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
