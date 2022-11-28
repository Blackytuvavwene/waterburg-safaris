import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

class WelcomePage extends HookConsumerWidget {
  const WelcomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppLayout(
      mobile: _MobileWelcomeScreen(),
      //TODO: implement tablet and desktop welcome screen
      tablet: _TabletWelcomeScreen(),
      desktop: _DesktopWelcomeScreen(),
    );
  }
}

// mobile welcome screen
class _MobileWelcomeScreen extends HookConsumerWidget {
  const _MobileWelcomeScreen({Key? key}) : super(key: key);
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
                height: 6.h,
              ),
              const Center(
                child: DText(
                  text: 'Waterburg Safaris Admin',
                ),
              ),
              SvgPicture.asset(
                'assets/images/welcome.svg',
                height: 54.h,
              ),
              SizedBox(
                height: 6.h,
              ),
              CustomElevatedButton(
                onPressed: () {
                  ref.read(appStatusProvider.notifier).toggleFirstOpen();
                  context.pushNamed('signup');
                },
                text: 'Create account',
                height: 6.h,
              ),
              SizedBox(
                height: 4.h,
              ),
              CustomElevatedButton(
                onPressed: () {
                  ref.read(appStatusProvider.notifier).toggleFirstOpen();
                  context.pushNamed('login');
                },
                text: 'Login',
                height: 6.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// tablet welcome screen
class _TabletWelcomeScreen extends HookConsumerWidget {
  const _TabletWelcomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
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
                  const DText(
                    text: 'Waterburg Safaris Admin',
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  SvgPicture.asset(
                    'assets/images/welcome.svg',
                    height: 22.h,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  CustomElevatedButton(
                    onPressed: () {
                      ref.read(appStatusProvider.notifier).toggleFirstOpen();
                      context.pushNamed('signup');
                    },
                    text: 'Create account',
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  CustomElevatedButton(
                    onPressed: () {
                      ref.read(appStatusProvider.notifier).toggleFirstOpen();
                      context.pushNamed('login');
                    },
                    text: 'Login',
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
class _DesktopWelcomeScreen extends HookConsumerWidget {
  const _DesktopWelcomeScreen({Key? key}) : super(key: key);
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
                maxHeight: 80.h,
                maxWidth: 60.w,
              ),
              child: Center(
                child: SizedBox(
                  height: 100.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: SvgPicture.asset('assets/images/welcome.svg'),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Center(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const DText(
                                  text: 'Waterburg Safaris Admin',
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                CustomElevatedButton(
                                  onPressed: () {
                                    ref
                                        .read(appStatusProvider.notifier)
                                        .toggleFirstOpen();
                                    context.pushNamed('signup');
                                  },
                                  text: 'Create account',
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                CustomElevatedButton(
                                  onPressed: () {
                                    ref
                                        .read(appStatusProvider.notifier)
                                        .toggleFirstOpen();
                                    context.pushNamed('login');
                                  },
                                  text: 'Login',
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
