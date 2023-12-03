import 'medicineApiController.dart';

class RequestPatient {
  final String name;
  final String phoneNumber;
  final String parentPhoneNumber;
  final String documents;
  final List<Medicine> medication;

  RequestPatient({
    required this.name,
    required this.phoneNumber,
    required this.parentPhoneNumber,
    required this.documents,
    required this.medication,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'parentPhoneNumber': parentPhoneNumber,
      'documents': documents,
      'medication': medication.map((med) => med.toJson()).toList(),
    };
  }
}
