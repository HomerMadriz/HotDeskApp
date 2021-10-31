import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? profilePicture;
  final String? email;
  final String? userId;

  const User({
    this.firstName,
    this.lastName,
    this.profilePicture,
    this.email,
    this.userId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json['firstName'] as String?,
        lastName: json['lastName'] as String?,
        profilePicture: json['profilePicture'] as String?,
        email: json['email'] as String?,
        userId: json['userId'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'profilePicture': profilePicture,
        'email': email,
        'userId': userId,
      };

  @override
  List<Object?> get props {
    return [
      firstName,
      lastName,
      profilePicture,
      email,
      userId,
    ];
  }
}
