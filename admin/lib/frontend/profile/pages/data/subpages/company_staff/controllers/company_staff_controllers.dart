// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:admin/lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// create a company staff local management controller
class CompanyStaffLocalControllerNotifier
    extends StateNotifier<LocalCompanyStaffModel?> {
  CompanyStaffLocalControllerNotifier({
    this.imageHelperController,
    this.initialData,
  }) : super(
          initialData,
        );

  // get access to imagehelper controller
  final ImageHelperNotifier? imageHelperController;
  // get initial state data
  final LocalCompanyStaffModel? initialData;

  // set the company staff details
  void setCompanyStaffDetails(CompanyStaff? staffDetails) {
    state = state?.copyWith(
      staffDetails: staffDetails,
    );
  }

  // set the company staff image
  void setCompanyStaffImage(ImageHelperModel? image) {
    state = state?.copyWith(
      image: image,
    );
  }

  // update company staff name
  void updateCompanyStaffName(String? name) {
    state = state?.copyWith.staffDetails?.call(fullName: name);
  }

  // update company staff email
  void updateCompanyStaffEmail(String? email) {
    state = state?.copyWith.staffDetails?.call(
      email: email,
    );
  }

  // update company staff phone numbers
  void updateCompanyStaffPhoneNumbers(String? phoneNo) {
    final List<String> phoneNos = [
      ...state?.staffDetails?.phoneNos ?? [],
    ];
    // add the phone number to the list
    phoneNos.add(phoneNo!);

    // update the state
    state = state?.copyWith.staffDetails?.call(
      phoneNos: phoneNos,
    );
  }

  // update company staff job title
  void updateCompanyStaffJobTitle(String? jobTitle) {
    state = state?.copyWith.staffDetails?.call(
      jobTitle: jobTitle,
    );
  }

  // update job description
  void updateJobDescription(String? jobDescription) {
    state = state?.copyWith.staffDetails?.call(
      jobDescription: jobDescription,
    );
  }

  // update designation title
  void updateTittle(String? title) {
    state = state?.copyWith.staffDetails?.call(
      title: title,
    );
  }

  // update image title
  void updateImageTitle(String? imageTitle) {
    state = state?.copyWith.image?.imageDetails?.call(
      imageTitle: imageTitle,
    );
  }

  // update image description
  void updateImageDescription(String? imageDescription) {
    state = state?.copyWith.image?.imageDetails?.call(
      imageDescription: imageDescription,
    );
  }

  // delete phone no from list
  void deletePhoneNo(String? phoneNo) {
    state = state?.copyWith.staffDetails?.call(
      phoneNos: [
        ...state?.staffDetails?.phoneNos
                ?.where((element) => element != phoneNo) ??
            []
      ],
    );
  }
}

// create a company staff local management controller provider
final companyStaffLocalControllerProvider = StateNotifierProvider.family
    .autoDispose<CompanyStaffLocalControllerNotifier, LocalCompanyStaffModel?,
        LocalCompanyStaffModel?>(
  (ref, staffDetails) =>
      CompanyStaffLocalControllerNotifier(initialData: staffDetails),
);

// multiple company staff local management controller notifier
class MultipleCompanyStaffLocalControllerNotifier
    extends StateNotifier<List<LocalCompanyStaffModel?>> {
  MultipleCompanyStaffLocalControllerNotifier() : super([]);

  // add a new company staff
  void addCompanyStaff({
    required LocalCompanyStaffModel? companyStaff,
  }) {
    state = [
      ...state,
      companyStaff,
    ];
  }

  // remove a company staff
  void removeCompanyStaff({
    required LocalCompanyStaffModel? companyStaff,
  }) {
    state = [
      ...state.where((element) => element != companyStaff),
    ];
  }

  // update company staff
  void updateCompanyStaff({
    required LocalCompanyStaffModel? companyStaff,
    required int index,
    required LocalCompanyStaffModel? newCompanyStaff,
  }) {
    // get the company staff
    var staff = state[index];
    // update the company staff
    staff = staff?.copyWith(
      staffDetails: newCompanyStaff?.staffDetails,
      image: newCompanyStaff?.image,
    );

    // update the staff in list
    state[index] = staff;
    // update the state
    state = [...state];
  }

  // clear all company staff
  void clearCompanyStaff() {
    state = [];
  }
}

// multiple company staff local management controller provider
final multipleCompanyStaffLocalControllerProvider =
    StateNotifierProvider.autoDispose<
        MultipleCompanyStaffLocalControllerNotifier,
        List<LocalCompanyStaffModel?>>(
  (ref) => MultipleCompanyStaffLocalControllerNotifier(),
);
