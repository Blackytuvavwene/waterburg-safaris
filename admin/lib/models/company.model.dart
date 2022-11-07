// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'company.model.g.dart';

@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
)
class Company {
  String? companyId;
  CompanyDetails? companyDetails;
  List<CompanyStaff>? companyStaff;
  List<Gallery>? companyGallery;
  DateTime? createdAt;
  DateTime? updatedAt;

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
  String? imageUrl;
  String? imageTitle;
  String? imageDescription;

  Gallery({
    this.imageUrl,
    this.imageTitle,
    this.imageDescription,
  });

  factory Gallery.fromJson(Map<String, dynamic> json) =>
      _$GalleryFromJson(json);

  Map<String, dynamic> toJson() => _$GalleryToJson(this);

  Gallery copyWith({
    String? imageUrl,
    String? imageTitle,
    String? imageDescription,
  }) {
    return Gallery(
      imageUrl: imageUrl ?? this.imageUrl,
      imageTitle: imageTitle ?? this.imageTitle,
      imageDescription: imageDescription ?? this.imageDescription,
    );
  }
}

@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
)
class CompanyStaff {
  String? imageUrl;
  String? fullName;
  String? email;
  List<String>? phoneNos;
  String? jobTitle;
  String? jobDescription;
  String? title;

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
  String? companyName;
  String? companyAddress;
  String? registrationNumber;
  String? vatNo;
  String? companyLogoUrl;
  String? seoDescription;
  String? overview;
  List<String>? cellPhoneNos;
  String? email;
  String? telNo;
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
