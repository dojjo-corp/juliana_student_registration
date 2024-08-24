import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_registration/components/my_button.dart';
import 'package:student_registration/global_methods.dart';
import 'package:student_registration/models/student_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.studentModel});

  final StudentModel studentModel;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final auth = FirebaseAuth.instance;

  Future<void> logout() async {
    try {
      await auth.signOut();
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/login",
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("My Profile"),
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout_rounded)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blueGrey[700],
              child: const Text("M.J."),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: const Text("Name"),
              subtitle: Text(
                widget.studentModel.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: const Text("Level"),
              subtitle: Text(
                widget.studentModel.level,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: const Text("Program"),
              subtitle: Text(
                widget.studentModel.program,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: const Text("Registration Status"),
              subtitle: Text(
                widget.studentModel.coursesRegistered.length == 5
                    ? "Complete"
                    : "Incomplete",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyButton(
        label: "Register Courses",
        onPressed: () {
          Navigator.pushNamed(context, "/registerCourses");
        },
      ),
    );
  }
}
