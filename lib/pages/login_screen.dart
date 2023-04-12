import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:storitter/data/api/requests/login_request.dart';
import 'package:storitter/data/model/user.dart';
import 'package:storitter/data/result_state.dart';
import 'package:storitter/generated/assets.dart';
import 'package:storitter/provider/app_provider.dart';
import 'package:storitter/provider/login_provider.dart';
import 'package:storitter/shared/locale.dart';
import 'package:storitter/widgets/password_field.dart';
import 'package:storitter/widgets/storitter_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void clearForm() {
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider = Provider.of<AppProvider>(context);

    void loginHandler(User? result) {
      if (result != null) {
        appProvider
          ..saveToken(result.token)
          ..getToken();

        clearForm();

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.loginSuccess),
          ),
        );
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.loginFailed),
          ),
        );
      }
    }

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
                  AppLocalizations.of(context)!.login,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(color: Colors.black87),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  AppLocalizations.of(context)!.authSubTitle,
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
                            label: AppLocalizations.of(context)!.email,
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
                              onPressed: provider.state != ResultState.loading
                                  ? () async {
                                      final LoginRequest request = LoginRequest(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      );

                                      final User? result =
                                          await provider.loginUser(request);

                                      loginHandler(result);
                                    }
                                  : null,
                              autofocus: true,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  AppLocalizations.of(context)!.login,
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
                          AppLocalizations.of(context)!.loginFooter,
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
                            AppLocalizations.of(context)!.register,
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
