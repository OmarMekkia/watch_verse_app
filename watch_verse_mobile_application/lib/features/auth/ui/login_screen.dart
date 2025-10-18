import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_verse/core/helpers/spacing.dart';
import 'package:watch_verse/core/routing/app_routes.dart';
import 'package:watch_verse/core/widgets/custom_elevated_button.dart';
import 'package:watch_verse/core/widgets/custom_text_button.dart';
import 'package:watch_verse/core/widgets/custom_text_form_field.dart';
import 'package:watch_verse/features/auth/data/models/user_login_request.dart';
import 'package:watch_verse/features/auth/logic/auth_cubit.dart';
import 'package:watch_verse/features/auth/ui/widgets/error_dialog.dart';

class LoginScreen extends StatefulWidget {
  final AuthCubit authCubit;
  const LoginScreen({super.key, required this.authCubit});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 2. Wrap the UI in a BlocListener to handle state changes.
    return BlocListener<AuthCubit, AuthState>(
      bloc: widget.authCubit,
      listener: (context, state) {
        state.when(
          unauthenticated: () {},
          authenticating: () => Center(child: CircularProgressIndicator()),
          authenticated: () {
            // Navigate to home screen on successful login
            if (mounted) {
              context.go(AppRoutes.navigationBarScreen);
            }
          },
          refreshing: () {},
          error: (message) {
            // Show an error dialog on failure
            errorDialog(context, message);
          },
        );
      },
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            verticalSpacing(90),
            const Text(
              "Welcome Back",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            verticalSpacing(10),
            const Text(
              "Login to your account",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            verticalSpacing(150),
            // 3. Wrap your text fields in a Form widget.
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    isObscureText: false,
                    controller: emailController,
                    text: "Email",
                    // 4. Add validator functions for proper error handling.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  verticalSpacing(30),
                  CustomTextFormField(
                    controller: passwordController,
                    text: "Password",
                    isObscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            verticalSpacing(70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              // 5. Simplify the onPressed callback.
              child: CustomElevatedButton(
                text: "Login",
                onPressed: () {
                  // It now only validates and dispatches the event.
                  if (_formKey.currentState!.validate()) {
                    widget.authCubit.logIn(
                      UserLoginRequest(
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                CustomTextButton(
                  text: "Sign Up",
                  onPressed: () {
                    context.go(AppRoutes.signUpScreen);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
