import 'package:admin/global/global.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WelcomePage extends HookConsumerWidget {
  const WelcomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppLayout(
      mobile: _MobileWelcomeScreen(),
      //TODO: implement tablet and desktop welcome screen
      tablet: _MobileWelcomeScreen(),
      desktop: _MobileWelcomeScreen(),
    );
  }
}

// mobile welcome screen
class _MobileWelcomeScreen extends HookConsumerWidget {
  const _MobileWelcomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
