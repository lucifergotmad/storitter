import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:storitter/data/api/requests/login_request.dart';
import 'package:storitter/data/result_state.dart';
import 'package:storitter/generated/assets.dart';
import 'package:storitter/provider/login_provider.dart';
import 'package:storitter/widgets/password_field.dart';
import 'package:storitter/widgets/storitter_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 300,
                  width: double.maxFinite,
                  child: Image.asset(
                    Assets.imagesLogin,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Login",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(color: Colors.black87),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Ready to share your story?",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.black38),
                ),
                const SizedBox(
                  height: 32,
                ),
                Consumer<LoginProvider>(
                  builder: (context, provider, _) {
                    return Form(
                      autovalidateMode: AutovalidateMode.always,
                      key: _formKey,
                      child: Column(
                        children: [
                          StoritterTextField.email(
                            controller: _emailController,
                            label: "Email",
                            icon: Icons.email,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          PasswordField(
                            controller: _passwordController,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                final LoginRequest request = LoginRequest(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );

                                provider.loginUser(request);
                              },
                              autofocus: true,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  "Login",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Didn't have an account?",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontSize: 16),
                        ),
                        TextButton(
                          onPressed: () {
                            context.go("/register");
                          },
                          child: Text(
                            "Register",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.blue),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
