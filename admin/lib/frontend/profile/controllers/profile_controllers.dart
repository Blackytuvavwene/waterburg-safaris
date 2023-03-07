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

// company firestore controller notifier
class CompanyFirestoreControllerNotifier
    extends StateNotifier<AsyncValue<Company>> {
  CompanyFirestoreControllerNotifier({
    this.companyDatabaseRepository,
  }) : super(
          AsyncValue.data(
            Company(),
          ),
        );

// get company database repository
  final CompanyDatabaseRepository? companyDatabaseRepository;

  // update company in firestore
  Future<AsyncValue<Company>> updateCompanyInFirestore({
    required Company? company,
  }) async {
    state = const AsyncValue.loading();

    return state = await AsyncValue.guard(() async {
      await FirestoreHelper.updateDataInDoc<Map<String, dynamic>>(
        docId: company!.companyId!,
        docPath: 'aboutCompany',
        data: company.toJson(),
        query: 'companyId',
      );

      return company;
    });
  }

  // delete gallery image from firestore
  Future<AsyncValue<Company>> deleteGalleryImageFromFirestore({
    required String? companyId,
    required Gallery? gallery,
  }) async {
    state = const AsyncValue.loading();

    return state = await AsyncValue.guard(() async {
      // delete image from firebase storage first
      await ImageHelpers.deleteImageFromFirebaseStorageByDownloadUrl(
        imageUrl: gallery!.imageUrl!,
      );

      // delete image from firestore
      await FirestoreHelper.deleteInDocList<Map<String, dynamic>>(
        docId: companyId!,
        docPath: 'aboutCompany',
        query: 'companyGallery',
        data: gallery.toJson(),
      );

      return Company();
    });
  }

  // delete staff from firestore
  Future<AsyncValue<Company>> deleteStaffFromFirestore({
    required String? companyId,
    required CompanyStaff? staff,
  }) async {
    state = const AsyncValue.loading();

    return state = await AsyncValue.guard(() async {
      // delete image from firebase storage first
      await ImageHelpers.deleteImageFromFirebaseStorageByDownloadUrl(
        imageUrl: staff!.imageUrl!,
      );

      // delete image from firestore
      await FirestoreHelper.deleteInDocList<Map<String, dynamic>>(
        docId: companyId!,
        docPath: 'aboutCompany',
        query: 'companyStaff',
        data: staff.toJson(),
      );

      return Company();
    });
  }

  // update company staff in firestore
  Future<AsyncValue<Company>> updateCompanyStaffInFirestore({
    required String? companyId,
    required CompanyStaff? newStaff,
    required CompanyStaff? oldStaff,
  }) async {
    state = const AsyncValue.loading();

    return state = await AsyncValue.guard(() async {
      // delete image from firebase storage first
      await ImageHelpers.deleteImageFromFirebaseStorageByDownloadUrl(
        imageUrl: oldStaff!.imageUrl!,
      );

      // delete image from firestore
      await FirestoreHelper.deleteAndUpdateInDocList(
        docId: companyId!,
        docPath: 'aboutCompany',
        data: oldStaff,
        newData: newStaff,
        query: 'companyStaff',
      );

      return Company();
    });
  }
}

// company firestore controller provider
final companyFirestoreControllerProvider = StateNotifierProvider<
    CompanyFirestoreControllerNotifier, AsyncValue<Company>>(
  (ref) => CompanyFirestoreControllerNotifier(),
);
