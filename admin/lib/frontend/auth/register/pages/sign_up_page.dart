// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:admin/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router_flow/go_router_flow.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

final _formKey = GlobalKey<FormState>();

class SignUpPage extends HookConsumerWidget {
  const SignUpPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(signUpStateProvider, (previousState, state) {
      if (state is AsyncLoading) {
        EasyLoading.show(status: 'Loading...');
      } else if (state is AsyncError) {
        EasyLoading.dismiss();
        EasyLoading.showError(state.error.toString());
      } else if (state is AsyncData) {
        EasyLoading.showSuccess('Successfully created account!');
        context.goNamed('home');
      }
    });

    // text controllers
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    // access sign up providers
    final AsyncValue<void> signUpState = ref.watch(signUpStateProvider);
    final isLoading = signUpState is AsyncLoading<void>;
    final addUserToFirestore = ref.watch(userDbRepositoryProvider);

    // register user and add to firestore
    void _register(String email, String password, String username) {
      if (_formKey.currentState!.validate()) {
        ref
            .read(signUpStateProvider.notifier)
            .signUp(email: email, password: password)
            .then((value) {
          final userData = value.value?.user;
          final newUser = UserModel(
            uid: userData?.uid,
            email: userData?.email,
            username: username,
            phoneNumber: '',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );
          addUserToFirestore.saveUserToFirestore(
            model: newUser,
          );
        });
      }
    }

    return AppLayout(
      mobile: _MobileSignUpScreen(
        nameController: nameController,
        emailController: emailController,
        passwordController: passwordController,
        signUp: _register,
        isLoading: isLoading,
      ),
      //TODO: implement tablet and desktop welcome screen
      tablet: _TabletSignUpScreen(
        nameController: nameController,
        emailController: emailController,
        passwordController: passwordController,
        signUp: _register,
        isLoading: isLoading,
      ),
      desktop: _DesktopSignUpScreen(
        nameController: nameController,
        emailController: emailController,
        passwordController: passwordController,
        signUp: _register,
        isLoading: isLoading,
      ),
    );
  }
}

// mobile welcome screen
class _MobileSignUpScreen extends HookConsumerWidget {
  const _MobileSignUpScreen({
    Key? key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    this.signUp,
    this.isLoading,
  }) : super(key: key);
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function? signUp;
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
                          text: 'Full names',
                        ),
                      ),
                      TextFormField(
                        controller: nameController,
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
                          signUp!(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                            nameController.text.trim(),
                          );
                        },
                        text: 'Create account',
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
class _TabletSignUpScreen extends HookConsumerWidget {
  const _TabletSignUpScreen({
    Key? key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    this.signUp,
    this.isLoading,
  }) : super(key: key);
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function? signUp;
  final bool? isLoading;
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
                              text: 'Full names',
                            ),
                          ),
                          TextFormField(
                            controller: nameController,
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
                              signUp!(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                                nameController.text.trim(),
                              );
                            },
                            text: 'Create account',
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

// desktop welcome screen
class _DesktopSignUpScreen extends HookConsumerWidget {
  const _DesktopSignUpScreen({
    Key? key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    this.signUp,
    this.isLoading,
  }) : super(key: key);
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function? signUp;
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
                maxWidth: 40.w,
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
                              text: 'Full names',
                            ),
                          ),
                          TextFormField(
                            controller: nameController,
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
                              signUp!(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                                nameController.text.trim(),
                              );
                            },
                            text: 'Create account',
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
