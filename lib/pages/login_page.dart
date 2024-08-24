import 'package:flutter/material.dart';
import 'package:student_registration/components/my_button.dart';
import 'package:student_registration/global_methods.dart';
import 'package:student_registration/services/authentication.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  bool _obscureText = true;
  bool _loading = false;

  final _key = GlobalKey<FormState>();

  Future<void> login() async {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();

      try {
        setState(() {
          _loading = true;
        });

        await Authentication().login(
          email: emailController.text.trim(),
          password: passwordController.text,
        );

        if (mounted) {
          setState(() {
            _loading = false;
          });
          Navigator.pushNamed(context, "/profilePage");
        }
      } catch (e) {
        if (mounted) {
          showSnackBar(context, e.toString());
        }
      } finally {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _loading ? const LinearProgressIndicator() : null,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Icon(
                  Icons.lock_rounded,
                  size: 100,
                ),
                const SizedBox(height: 20),
                Form(
                  key: _key,
                  child: Column(
                    children: [
                      // todo: Email field
                      TextFormField(
                        controller: emailController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Email is required";
                          }
                          return null;
                        },
                      ),
                      // todo: Password field
                      TextFormField(
                        controller: passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(
                            _obscureText
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded,
                          ),
                        )),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Password is required";
                          } else if (value.characters.length < 6) {
                            return "Password length cannot be less than 6";
                          }
                          return null;
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                // todo: forgot password
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/forgotPassword");
                      },
                      child: Text(
                        "forgot password",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),

                // todo: Login Button
                MyButton(
                  label: "Login",
                  onPressed: login,
                ),
              ],
            ),
            // todo: Not having an account
            Row(
              children: [
                const Text("Not having an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/signup");
                  },
                  child: Text(
                    "Signup",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
