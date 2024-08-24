import 'package:cloud_firestore/cloud_firestore.dart';

class CourseModel {
  CourseModel({
    required this.id,
    required this.name,
    required this.lecturer,
    required this.creditHours,
  });

  final String id;
  final String name;
  final String lecturer;
  final String creditHours;

  factory CourseModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();

    return CourseModel(
        id: data?["id"],
        name: data?["name"],
        lecturer: data?["lecturer"],
        creditHours: data?["creditHours"]);
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "lecturer": lecturer,
        "creditHours": creditHours,
      };
}
