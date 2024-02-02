class ManageCandidatesModel {
  final int id;
  final String name;
  final String semester;
  final int? post_id;
  final String department;
  final String usn;
  final int phone_number;
  final String email;
  final int election_id;

  ManageCandidatesModel({
    required this.id,
    required this.name,
    required this.semester,
    required this.post_id,
    required this.department,
    required this.usn,
    required this.phone_number,
    required this.email,
    required this.election_id,
  });

  // Add this method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'semester': semester,
      'post_id': post_id,
      'department': department,
      'usn': usn,
      'phone_number': phone_number,
      'email': email,
      'election_id': election_id,
    };
  }

  // Add this factory method to create an instance from JSON
  factory ManageCandidatesModel.fromJson(Map<String, dynamic> json) {
    return ManageCandidatesModel(
      id: json['id'],
      name: json['name'],
      semester: json['semester'],
      post_id: json['post_id'],
      department: json['department'],
      usn: json['usn'],
      phone_number: json['phone_number'],
      email: json['email'],
      election_id: json['election_id'],
    );
  }
}
