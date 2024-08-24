import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel {
  StudentModel({
    required this.id,
    required this.name,
    required this.level,
    required this.program,
    required this.coursesRegistered,
    required this.coursesNotRegistered,
    required this.timestamp,
  });

  final String id;
  final String name;
  final String level;
  final String program;
  final List coursesRegistered;
  final List coursesNotRegistered;
  final Timestamp timestamp;

  factory StudentModel.fromFirestore(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>?;

    return StudentModel(
        id: data?["id"],
        name: data?["name"],
        level: data?["level"],
        program: data?["program"],
        coursesRegistered: data?["coursesRegistered"],
        coursesNotRegistered: data?["coursesNotRegistered"],
        timestamp: data?["timestamp"]);
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "level": level,
        "program": program,
        "coursesRegistered": coursesRegistered,
        "coursesNotRegistered": coursesNotRegistered,
        "timestamp": timestamp,
      };
}
