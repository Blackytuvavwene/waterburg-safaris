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
    // copy state data first
    final stateCopy = state;
    // new local state
    final LocalCompanyStaffModel? newStaff = stateCopy?.copyWith.call(
      staffDetails: stateCopy.staffDetails?.copyWith.call(
        fullName: name,
      ),
    );
    print('new state name: ${newStaff?.staffDetails?.fullName}');
    state = newStaff;
    print(
        'state update name: ${state?.staffDetails?.fullName}, passed value: $name');
  }

  // update company staff email
  void updateCompanyStaffEmail(String? email) {
    state = state?.copyWith(
      staffDetails: state?.staffDetails?.copyWith.call(
        email: email,
      ),
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
    state = state?.copyWith(
      staffDetails: state?.staffDetails?.copyWith(
        phoneNos: phoneNos,
      ),
    );
  }

  // update company staff job title
  void updateCompanyStaffJobTitle(String? jobTitle) {
    state = state?.copyWith(
      staffDetails: state?.staffDetails?.copyWith(
        jobTitle: jobTitle,
      ),
    );
  }

  // update job description
  void updateJobDescription(String? jobDescription) {
    state = state?.copyWith(
      staffDetails: state?.staffDetails?.copyWith(
        jobDescription: jobDescription,
      ),
    );
  }

  // update designation title
  void updateTittle(String? title) {
    state = state?.copyWith(
      staffDetails: state?.staffDetails?.copyWith(
        title: title,
      ),
    );
  }

  // update image title
  void updateImageTitle(String? imageTitle) {
    state = state?.copyWith(
      image: state?.image?.copyWith(
        imageDetails: state?.image?.imageDetails?.copyWith(
          imageTitle: imageTitle,
        ),
      ),
    );
  }

  // update image description
  void updateImageDescription(String? imageDescription) {
    state = state?.copyWith(
      image: state?.image?.copyWith(
        imageDetails: state?.image?.imageDetails?.copyWith(
          imageDescription: imageDescription,
        ),
      ),
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
    required LocalCompanyStaffModel? newCompanyStaff,
  }) {
    state = [
      ...state.map(
        (element) => element == companyStaff ? newCompanyStaff : element,
      ),
    ];
  }
}

// multiple company staff local management controller provider
final multipleCompanyStaffLocalControllerProvider =
    StateNotifierProvider.autoDispose<
        MultipleCompanyStaffLocalControllerNotifier,
        List<LocalCompanyStaffModel?>>(
  (ref) => MultipleCompanyStaffLocalControllerNotifier(),
);

// local company staff model
class LocalCompanyStaffModel {
  ImageHelperModel? image;
  CompanyStaff? staffDetails;

  LocalCompanyStaffModel({
    this.image,
    this.staffDetails,
  });

  LocalCompanyStaffModel copyWith({
    ImageHelperModel? image,
    CompanyStaff? staffDetails,
  }) {
    return LocalCompanyStaffModel(
      image: image ?? this.image,
      staffDetails: staffDetails ?? this.staffDetails,
    );
  }

  @override
  bool operator ==(covariant LocalCompanyStaffModel other) {
    if (identical(this, other)) return true;

    return other.image == image && other.staffDetails == staffDetails;
  }

  @override
  int get hashCode => image.hashCode ^ staffDetails.hashCode;
}
