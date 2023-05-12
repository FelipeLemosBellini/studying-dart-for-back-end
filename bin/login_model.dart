import 'dart:convert';

class LoginModel {
  final String email;
  final String password;

  LoginModel({
    required this.password,
    required this.email,
  });

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      email: map['email'].toString(),
      password: map['password'].toString(),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}
