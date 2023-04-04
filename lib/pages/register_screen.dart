import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:storitter/generated/assets.dart';
import 'package:storitter/widgets/password_field.dart';
import 'package:storitter/widgets/storitter_text_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 240,
                  width: double.maxFinite,
                  child: Image.asset(
                    Assets.imagesRegister,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Register",
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
                const StoritterTextField(
                  label: "Name",
                  icon: Icons.account_box,
                ),
                const SizedBox(
                  height: 16,
                ),
                const StoritterTextField(
                  label: "Email",
                  icon: Icons.email,
                ),
                const SizedBox(
                  height: 16,
                ),
                const PasswordField(),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    autofocus: true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Register",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
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
                          "Already have an account?",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontSize: 16),
                        ),
                        TextButton(
                          onPressed: () {
                            context.go("/login");
                          },
                          child: Text(
                            "Login",
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
