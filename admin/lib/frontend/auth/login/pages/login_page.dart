import 'package:admin/lib.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

final _formKey = GlobalKey<FormState>();

class LoginPage extends HookConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<User?>>(loginStateProvider, (previousState, state) {
      state.when(
        data: (data) {
          return EasyLoading.showSuccess('Successfully logged in!...');
        },
        error: (error, stackTrace) {
          return EasyLoading.showError(state.error.toString());
        },
        loading: () {
          return EasyLoading.show(status: 'Loading...');
        },
      );
    });

    // text controllers
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    // access sign up providers
    final AsyncValue<void> loginState = ref.watch(signUpStateProvider);
    final isLoading = loginState is AsyncLoading<void>;

    void _login(String email, String password) {
      if (_formKey.currentState!.validate()) {
        ref
            .read(loginStateProvider.notifier)
            .login(email: email, password: password);
      }
    }

    return AppLayout(
      mobile: _MobileLoginScreen(
        passwordController: passwordController,
        emailController: emailController,
        isLoading: isLoading,
        login: _login,
      ),
      //TODO: implement tablet and desktop welcome screen
      tablet: _TabletLoginScreen(
        passwordController: passwordController,
        emailController: emailController,
        isLoading: isLoading,
        login: _login,
      ),
      desktop: _DesktopLoginScreen(
        passwordController: passwordController,
        emailController: emailController,
        isLoading: isLoading,
        login: _login,
      ),
    );
  }
}

// mobile welcome screen
class _MobileLoginScreen extends HookConsumerWidget {
  const _MobileLoginScreen({
    Key? key,
    required this.emailController,
    required this.passwordController,
    this.login,
    this.isLoading,
  }) : super(key: key);
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function? login;
  final bool? isLoading;
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
                height: 4.h,
              ),
              const Center(
                child: DText(
                  text: 'Waterburg Safaris Admin',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              SvgPicture.asset(
                'assets/images/enter.svg',
                height: 26.h,
              ),
              SizedBox(
                height: 4.h,
              ),
              Center(
                child: Form(
                  onChanged: () {
                    _formKey.currentState?.validate();
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 1.h,
                        ),
                        child: const DText(
                          text: 'Email',
                        ),
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context).colorScheme.surface,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 1.h,
                        ),
                        child: const DText(
                          text: 'Password',
                        ),
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context).colorScheme.surface,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      CustomElevatedButton(
                        onPressed: () {
                          login!(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                        },
                        text: 'Login',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// tablet welcome screen
class _TabletLoginScreen extends HookConsumerWidget {
  const _TabletLoginScreen({
    Key? key,
    required this.emailController,
    required this.passwordController,
    this.login,
    this.isLoading,
  }) : super(key: key);
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function? login;
  final bool? isLoading;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(18.w),
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
                  SizedBox(
                    height: 4.h,
                  ),
                  const Center(
                    child: DText(
                      text: 'Waterburg Safaris Admin',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  SvgPicture.asset(
                    'assets/images/enter.svg',
                    height: 26.h,
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  Flexible(
                    flex: 8,
                    child: Center(
                      child: Form(
                        onChanged: () {
                          _formKey.currentState?.validate();
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: 1.h,
                              ),
                              child: const DText(
                                text: 'Email',
                              ),
                            ),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surfaceVariant,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: 1.h,
                              ),
                              child: const DText(
                                text: 'Password',
                              ),
                            ),
                            TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surfaceVariant,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Flexible(
                              flex: 2,
                              child: CustomElevatedButton(
                                onPressed: () {
                                  login!(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                  );
                                },
                                text: 'Login',
                              ),
                            ),
                          ],
                        ),
                      ),
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
class _DesktopLoginScreen extends HookConsumerWidget {
  const _DesktopLoginScreen({
    Key? key,
    required this.emailController,
    required this.passwordController,
    this.login,
    this.isLoading,
  }) : super(key: key);
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function? login;
  final bool? isLoading;
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
                maxWidth: 30.w,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 4.h,
                  ),
                  const Center(
                    child: DText(
                      text: 'Waterburg Safaris Admin',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  SvgPicture.asset(
                    'assets/images/enter.svg',
                    height: 26.h,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Center(
                    child: Form(
                      onChanged: () {
                        _formKey.currentState?.validate();
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 1.h,
                            ),
                            child: const DText(
                              text: 'Email',
                            ),
                          ),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceVariant,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 1.h,
                            ),
                            child: const DText(
                              text: 'Password',
                            ),
                          ),
                          TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceVariant,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          CustomElevatedButton(
                            onPressed: () {
                              login!(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );
                            },
                            text: 'Login',
                          ),
                        ],
                      ),
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
