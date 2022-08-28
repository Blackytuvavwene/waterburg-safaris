import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

class SignUpPage extends HookConsumerWidget {
  const SignUpPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppLayout(
      mobile: _MobileSignUpScreen(),
      //TODO: implement tablet and desktop welcome screen
      tablet: _TabletSignUpScreen(),
      desktop: _DesktopSignUpScreen(),
    );
  }
}

// mobile welcome screen
class _MobileSignUpScreen extends HookConsumerWidget {
  const _MobileSignUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SizedBox(
          child: ListView(
            padding: EdgeInsets.all(
              6.w,
            ),
            children: [
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: Text(
                  'Waterburg Safaris Admin',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(),
                      TextFormField(),
                      TextFormField(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              ElevatedButton(
                  onPressed: () {}, child: const Text('Create account')),
            ],
          ),
        ),
      ),
    );
  }
}

// tablet welcome screen
class _TabletSignUpScreen extends HookConsumerWidget {
  const _TabletSignUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 100.h,
                maxWidth: 50.w,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Waterburg Safaris Admin',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(),
                        TextFormField(),
                        TextFormField(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// desktop welcome screen
class _DesktopSignUpScreen extends HookConsumerWidget {
  const _DesktopSignUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 26.w),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 100.h,
                maxWidth: 40.w,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Waterburg Safaris Admin',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(),
                        TextFormField(),
                        TextFormField(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
