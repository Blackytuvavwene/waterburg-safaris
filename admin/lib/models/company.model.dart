// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'company.model.g.dart';

@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
)
class Company {
  final String? companyId;
  final CompanyDetails? companyDetails;
  final List<CompanyStaff>? companyStaff;
  final List<Gallery>? companyGallery;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Company({
    this.companyId,
    this.companyDetails,
    this.companyStaff,
    this.companyGallery,
    this.createdAt,
    this.updatedAt,
  });

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}

@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
)
class Gallery {
  final String? imageUrl;
  final String? imageTitle;
  final String? imageDescription;

  Gallery({this.imageUrl, this.imageTitle, this.imageDescription});

  factory Gallery.fromJson(Map<String, dynamic> json) =>
      _$GalleryFromJson(json);

  Map<String, dynamic> toJson() => _$GalleryToJson(this);
}

@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
)
class CompanyStaff {
  final String? imageUrl;
  final String? fullName;
  final String? email;
  final List<String>? phoneNos;
  final String? jobTitle;
  final String? jobDescription;
  final String? title;

  CompanyStaff({
    this.imageUrl,
    this.fullName,
    this.email,
    this.phoneNos,
    this.jobTitle,
    this.jobDescription,
    this.title,
  });

  factory CompanyStaff.fromJson(Map<String, dynamic> json) =>
      _$CompanyStaffFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyStaffToJson(this);
}

@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
)
class CompanyDetails {
  final String? companyName;
  final String? companyAddress;
  final String? registrationNumber;
  final String? vatNo;
  final String? companyLogoUrl;
  final String? seoDescription;
  final String? overview;
  final List<String>? cellPhoneNos;
  final String? email;
  final String? telNo;
  CompanyDetails({
    this.companyName,
    this.companyAddress,
    this.registrationNumber,
    this.vatNo,
    this.companyLogoUrl,
    this.seoDescription,
    this.overview,
    this.cellPhoneNos,
    this.email,
    this.telNo,
  });

  factory CompanyDetails.fromJson(Map<String, dynamic> json) =>
      _$CompanyDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyDetailsToJson(this);
}
