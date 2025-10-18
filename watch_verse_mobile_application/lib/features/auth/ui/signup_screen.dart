import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_verse/core/helpers/spacing.dart';
import 'package:watch_verse/core/helpers/text_validations.dart';
import 'package:watch_verse/core/routing/app_routes.dart';
import 'package:watch_verse/core/widgets/custom_elevated_button.dart';
import 'package:watch_verse/core/widgets/custom_text_button.dart';
import 'package:watch_verse/core/widgets/custom_text_form_field.dart';
import 'package:watch_verse/features/auth/data/models/user_sign_up_request.dart';
import 'package:watch_verse/features/auth/logic/auth_cubit.dart';
import 'package:watch_verse/features/auth/ui/widgets/account_created_successfully_dialog.dart';
import 'package:watch_verse/features/auth/ui/widgets/error_dialog.dart';

class SignupScreen extends StatefulWidget {
  final AuthCubit authCubit;
  const SignupScreen({super.key, required this.authCubit});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. Place the BlocListener in the widget tree, wrapping your Scaffold.
    return BlocListener<AuthCubit, AuthState>(
      bloc: widget.authCubit, // Explicitly provide the cubit
      listener: (context, state) {
        state.whenOrNull(
          authenticating: () {
            print("🔄 Authentication in progress...");
            // Show loading indicator
          },
          authenticated: () {
            print("✅ Authentication successful!");
            // Show success dialog and navigate on successful authentication
            if (mounted) {
              accountCreatedSuccessfullyDialog(context, () {
                context.pop();
                context.go(AppRoutes.loginScreen);
              }, "Account Created Successfully ✅");
              // Navigate to login after success so the user can log in
            }
          },
          error: (message) {
            print("❌ Authentication error: $message");
            // Show an error dialog if something goes wrong
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
              "Create An Account", // Changed text to be more appropriate for a signup screen
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            verticalSpacing(10),
            const Text(
              "Sign up to get started",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            verticalSpacing(80),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: usernameController,
                    text: "Username",
                    validator: TextValidations.nameValidator,
                    isObscureText: false,
                  ),
                  verticalSpacing(30),
                  CustomTextFormField(
                    controller: emailController,
                    text: "Email",
                    validator: TextValidations.emailValidator,
                    isObscureText: false,
                  ),
                  verticalSpacing(30),
                  CustomTextFormField(
                    controller: passwordController,
                    text: "Password",
                    validator: TextValidations.passwordSignupValidator,
                    // It's good practice to obscure password fields
                    isObscureText: true,
                  ),
                  verticalSpacing(30),
                  CustomTextFormField(
                    controller: confirmPasswordController,
                    text: "Confirm Password",
                    validator: (value) => TextValidations(
                      passwordText: passwordController.text,
                    ).passwordConfirmationValidator(value),
                    isObscureText: true,
                  ),
                ],
              ),
            ),
            verticalSpacing(70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              // 2. The button's onPressed is now much simpler.
              child: CustomElevatedButton(
                text: "Sign Up",
                onPressed: () {
                  print("🔘 Signup button pressed");
                  // It only validates the form and triggers the signup event.
                  if (_formKey.currentState!.validate()) {
                    print("✅ Form validation passed");
                    final signupRequest = UserSignUpRequest(
                      username: usernameController.text,
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    print(
                      "📋 Signup request created: ${signupRequest.toJson()}",
                    );
                    widget.authCubit.signUp(signupRequest);
                  } else {
                    print("❌ Form validation failed");
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                CustomTextButton(
                  text: "Login",
                  onPressed: () => context.go(AppRoutes.loginScreen),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
