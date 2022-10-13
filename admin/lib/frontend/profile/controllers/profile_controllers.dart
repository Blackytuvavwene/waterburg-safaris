import 'package:admin/lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompanyNotifier extends StateNotifier<Company> {
  CompanyNotifier() : super(Company());
}

class CurrentUserNotifier extends StateNotifier<UserModel> {
  CurrentUserNotifier() : super(UserModel());
}
