import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/routes/routes.dart';
import 'package:todo_app/features/Authentication/logic/cubit/cubit/sign_up_cubit.dart';
import 'package:todo_app/features/Authentication/presentation/widgets/customButton_widget.dart';
import 'package:todo_app/features/Authentication/presentation/widgets/custom_textfiled_widget.dart';
import 'package:todo_app/features/Authentication/presentation/widgets/header_wwidget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const AuthHeader(
                  title: 'Sign Up',
                  subtitle: 'Create an account to get started',
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  hintText: 'Full Name',
                  icon: Icons.person_outline,
                  controller: nameController,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: 'Email',
                  icon: Icons.email_outlined,
                  controller: emailController,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: 'Password',
                  icon: Icons.lock_outline_rounded,
                  obscureText: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: 'Confirm Password',
                  icon: Icons.lock_outline_rounded,
                  obscureText: true,
                  controller: confirmPasswordController,
                ),
                const SizedBox(height: 24),
                BlocConsumer<SignUpCubit, SignUpState>(
                  listener: (context, state) {
                    if (state is SignUpsuccess) {
                      Navigator.popAndPushNamed(
                        context,
                        Routes.homeScreen,
                        arguments: state.user,
                      );
                    } else if (state is SignUpFailure) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                      text: state is SignUploading ? 'Loading...' : 'Sign Up',
                      onPressed: state is SignUploading
                          ? null
                          : () {
                              context.read<SignUpCubit>().signUp(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                confirmPassword: confirmPasswordController.text,
                              );
                            },
                    );
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(context, Routes.loginScreen);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xFF007AFF),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
