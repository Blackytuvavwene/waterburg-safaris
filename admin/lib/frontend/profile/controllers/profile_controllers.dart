import 'package:admin/lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompanyNotifier extends StateNotifier<Company?> {
  CompanyNotifier({required this.company}) : super(company);
  final Company? company;

  void editCompanyDetails({
    required CompanyDetails? companyDetails,
  }) {
    state = state?.copyWith(
      companyDetails: companyDetails,
    );
  }

  void editCompanyStaff({
    required List<CompanyStaff>? companyStaff,
  }) {
    state = state?.copyWith(
      companyStaff: companyStaff,
    );
  }

  void editCompanyGallery({
    required List<Gallery>? companyGallery,
  }) {
    state = state?.copyWith(
      companyGallery: companyGallery,
    );
  }

  void deleteStaff({
    required CompanyStaff? staff,
  }) {
    state = state?.copyWith(
      companyStaff:
          state?.companyStaff?.where((element) => element != staff).toList(),
    );
  }

  void updateStaff({
    required CompanyStaff? newStaff,
    required CompanyStaff? oldStaff,
  }) {
    state = state?.copyWith(
      companyStaff: state?.companyStaff?.map((e) {
        if (e == oldStaff) {
          return newStaff!;
        } else {
          return e;
        }
      }).toList(),
    );
  }

  void addStaff({
    required CompanyStaff? staff,
  }) {
    state = state?.copyWith(
      companyStaff: state?.companyStaff?..add(staff!),
    );
  }

  void deleteGallery({
    required Gallery? gallery,
  }) {
    state = state?.copyWith(
      companyGallery: state?.companyGallery
          ?.where((element) => element != gallery)
          .toList(),
    );
  }

  void updateGallery({
    required Gallery? newGallery,
    required Gallery? oldGallery,
  }) {
    state = state?.copyWith(
      companyGallery: state?.companyGallery?.map((e) {
        if (e == oldGallery) {
          return newGallery!;
        } else {
          return e;
        }
      }).toList(),
    );
  }

  void addGallery({
    required Gallery? gallery,
  }) {
    state = state?.copyWith(
      companyGallery: state?.companyGallery?..add(gallery!),
    );
  }

  void updateCompany({
    required Company? company,
  }) {
    state = company;
  }

  void updateCompanyName({
    required String? companyName,
  }) {
    state = state?.copyWith(
      companyDetails: state?.companyDetails?.copyWith(
        companyName: companyName,
      ),
    );
  }

  void updateSEODescription({
    required String? companyDescription,
  }) {
    state = state?.copyWith(
      companyDetails: state?.companyDetails?.copyWith(
        seoDescription: companyDescription,
      ),
    );
  }
}

class CurrentUserNotifier extends StateNotifier<UserModel> {
  CurrentUserNotifier() : super(UserModel());
}
