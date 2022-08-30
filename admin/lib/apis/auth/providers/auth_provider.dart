import 'package:admin/lib.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// auth repository provider
final authProvider = Provider(
  ((ref) => AuthRepository()),
);

enum AppAuthStatus {
  firstLoad,
  loaded,
  loggedIn,
  notLoggedIn,
}

// manage app status
class AppNotifier extends StateNotifier<AppAuthStatus> {
  AppNotifier() : super(AppAuthStatus.firstLoad);

  toggleFirstOpen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loaded', true);
    state = AppAuthStatus.loaded;
  }

  toggleLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedIn', true);
    state = AppAuthStatus.loggedIn;
  }

  getLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool('loggedIn');
    if (loggedIn == true) return AppAuthStatus.loggedIn;
    if (loggedIn == false) return AppAuthStatus.notLoggedIn;
  }

  Future<AppAuthStatus> getOpen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    AppAuthStatus open;
    final loaded = prefs.getBool('loaded');
    if (loaded == true) {
      return open = AppAuthStatus.loaded;
    } else {
      return open = AppAuthStatus.firstLoad;
    }
  }
}

// app status notifier provider
final appStatusProvider =
    StateNotifierProvider<AppNotifier, AppAuthStatus>((ref) {
  return AppNotifier();
});

final firstLoadProvider = FutureProvider<AppAuthStatus>((ref) async {
  return await ref.read(appStatusProvider.notifier).getOpen();
});

final loggedIn = FutureProvider.autoDispose<AppAuthStatus>(
  ((ref) => ref.read(appStatusProvider.notifier).getLoggedIn()),
);

final currentUserProvider = StreamProvider.autoDispose<User?>((ref) {
  return ref.watch(authProvider).isSignedIn();
});
