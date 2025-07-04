// lib/models/user_model.dart
class UserModel {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String religion;
  final String community;
  final String occupation;
  final String location;
  final String bio;
  final String imageUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.religion,
    required this.community,
    required this.occupation,
    required this.location,
    required this.bio,
    required this.imageUrl,
  });

  // Factory constructor to create a UserModel from a JSON map (e.g., from a backend API)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      age: json['age'] as int,
      gender: json['gender'] as String,
      religion: json['religion'] as String,
      community: json['community'] as String,
      occupation: json['occupation'] as String,
      location: json['location'] as String,
      bio: json['bio'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  // Method to convert a UserModel to a JSON map (e.g., for sending to a backend API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'gender': gender,
      'religion': religion,
      'community': community,
      'occupation': occupation,
      'location': location,
      'bio': bio,
      'imageUrl': imageUrl,
    };
  }
}