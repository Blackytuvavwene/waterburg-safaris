// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// include freezed part
part 'company.model.freezed.dart';
part 'company.model.g.dart';

@Freezed()
class Company with _$Company {
  factory Company({
    final String? companyId,
    final CompanyDetails? companyDetails,
    final List<CompanyStaff>? companyStaff,
    final List<Gallery>? companyGallery,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _Company;

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);
}

@Freezed()
class Gallery with _$Gallery {
  factory Gallery({
    final String? imageUrl,
    final String? imageTitle,
    final String? imageDescription,
  }) = _Gallery;

  factory Gallery.fromJson(Map<String, dynamic> json) =>
      _$GalleryFromJson(json);
}

@Freezed()
class CompanyStaff with _$CompanyStaff {
  factory CompanyStaff({
    final String? imageUrl,
    final String? fullName,
    final String? email,
    final List<String>? phoneNos,
    final String? jobTitle,
    final String? jobDescription,
    final String? title,
  }) = _CompanyStaff;

  factory CompanyStaff.fromJson(Map<String, dynamic> json) =>
      _$CompanyStaffFromJson(json);
}

@Freezed()
class CompanyDetails with _$CompanyDetails {
  factory CompanyDetails({
    final String? companyName,
    final String? companyAddress,
    final String? registrationNumber,
    final String? vatNo,
    final String? companyLogoUrl,
    final String? seoDescription,
    final String? overview,
    final List<String>? cellPhoneNos,
    final String? email,
    final String? telNo,
  }) = _CompanyDetails;

  factory CompanyDetails.fromJson(Map<String, dynamic> json) =>
      _$CompanyDetailsFromJson(json);
}

class AddressAndContact {
  final String? address;
  final String? telNo;
  final String? email;
  final List<String>? cellPhoneNos;

  AddressAndContact({
    this.address,
    this.telNo,
    this.cellPhoneNos,
    this.email,
  });

  AddressAndContact copyWith({
    final String? address,
    final String? telNo,
    final String? email,
    final List<String>? cellPhoneNos,
  }) {
    return AddressAndContact(
      address: address ?? this.address,
      telNo: telNo ?? this.telNo,
      email: email ?? this.email,
      cellPhoneNos: cellPhoneNos ?? this.cellPhoneNos,
    );
  }
}

// edit staff route arguments
class EditStaffRouteArguments {
  final CompanyStaff? staff;
  final String? companyId;

  EditStaffRouteArguments({
    this.staff,
    this.companyId,
  });
}
