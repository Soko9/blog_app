import "../../../../core/theme/app_palette.dart";
import "../../../../core/utils/helpers.dart";
import "../../../../core/shared/widgets/loader.dart";
import "../bloc/auth_bloc.dart";
import "signin_screen.dart";
import "../../../../core/shared/widgets/input_field.dart";
import "../../../../core/shared/widgets/gradient_button.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static route() => MaterialPageRoute(
        builder: (_) => const SignupScreen(),
      );

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        maintainBottomViewPadding: true,
        minimum: const EdgeInsets.all(16.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showErrorDialog(
                context: context,
                message: state.message,
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }
            return Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Sign Up.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      InputField(
                        controller: _nameController,
                        hint: "Name",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "name is missing";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12.0),
                      InputField(
                        controller: _emailController,
                        hint: "Email",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "email is missing";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12.0),
                      InputField(
                        controller: _passwordController,
                        hint: "Password",
                        isObscure: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "password is missing";
                          }
                          if (value.length < 6) {
                            return "password must be at least 6 characters";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32.0),
                      GradientButton(
                        label: "sign up",
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  AuthSignUpUserEvent(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                    name: _nameController.text.trim(),
                                  ),
                                );
                            _emailController.clear();
                            _passwordController.clear();
                            _nameController.clear();
                          }
                        },
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(width: 8.0),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                SigninScreen.route(),
                              );
                            },
                            child: Text(
                              "sign in",
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: AppPalette.pink,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
