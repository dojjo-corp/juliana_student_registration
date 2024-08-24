import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _key = GlobalKey<FormState>();

  signup() async {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();

      try {} catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Text(
                  "Join Us",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // todo: Signup Button
                ElevatedButton(
                  onPressed: signup,
                  child: const Text("Singup"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
