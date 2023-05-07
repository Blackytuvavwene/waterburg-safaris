// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Company _$$_CompanyFromJson(Map json) => _$_Company(
      companyId: json['companyId'] as String?,
      companyDetails: json['companyDetails'] == null
          ? null
          : CompanyDetails.fromJson(
              Map<String, dynamic>.from(json['companyDetails'] as Map)),
      companyStaff: (json['companyStaff'] as List<dynamic>?)
          ?.map(
              (e) => CompanyStaff.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      companyGallery: (json['companyGallery'] as List<dynamic>?)
          ?.map((e) => Gallery.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      slug: json['slug'] as String?,
    );

Map<String, dynamic> _$$_CompanyToJson(_$_Company instance) =>
    <String, dynamic>{
      'companyId': instance.companyId,
      'companyDetails': instance.companyDetails?.toJson(),
      'companyStaff': instance.companyStaff?.map((e) => e.toJson()).toList(),
      'companyGallery':
          instance.companyGallery?.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'slug': instance.slug,
    };

_$_Gallery _$$_GalleryFromJson(Map json) => _$_Gallery(
      imageUrl: json['imageUrl'] as String?,
      imageTitle: json['imageTitle'] as String?,
      imageDescription: json['imageDescription'] as String?,
    );

Map<String, dynamic> _$$_GalleryToJson(_$_Gallery instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'imageTitle': instance.imageTitle,
      'imageDescription': instance.imageDescription,
    };

_$_CompanyStaff _$$_CompanyStaffFromJson(Map json) => _$_CompanyStaff(
      imageUrl: json['imageUrl'] as String?,
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      phoneNos: (json['phoneNos'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      jobTitle: json['jobTitle'] as String?,
      jobDescription: json['jobDescription'] as String?,
      title: json['title'] as String?,
      slug: json['slug'] as String?,
    );

Map<String, dynamic> _$$_CompanyStaffToJson(_$_CompanyStaff instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'fullName': instance.fullName,
      'email': instance.email,
      'phoneNos': instance.phoneNos,
      'jobTitle': instance.jobTitle,
      'jobDescription': instance.jobDescription,
      'title': instance.title,
      'slug': instance.slug,
    };

_$_CompanyDetails _$$_CompanyDetailsFromJson(Map json) => _$_CompanyDetails(
      companyName: json['companyName'] as String?,
      companyAddress: json['companyAddress'] as String?,
      registrationNumber: json['registrationNumber'] as String?,
      vatNo: json['vatNo'] as String?,
      companyLogoUrl: json['companyLogoUrl'] as String?,
      seoDescription: json['seoDescription'] as String?,
      overview: json['overview'] as String?,
      cellPhoneNos: (json['cellPhoneNos'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      email: json['email'] as String?,
      telNo: json['telNo'] as String?,
    );

Map<String, dynamic> _$$_CompanyDetailsToJson(_$_CompanyDetails instance) =>
    <String, dynamic>{
      'companyName': instance.companyName,
      'companyAddress': instance.companyAddress,
      'registrationNumber': instance.registrationNumber,
      'vatNo': instance.vatNo,
      'companyLogoUrl': instance.companyLogoUrl,
      'seoDescription': instance.seoDescription,
      'overview': instance.overview,
      'cellPhoneNos': instance.cellPhoneNos,
      'email': instance.email,
      'telNo': instance.telNo,
    };
