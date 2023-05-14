import 'dart:convert';

class ResponseSuccessLoginModel {
  final String token;
  final String username;

  ResponseSuccessLoginModel({required this.token, required this.username});

  factory ResponseSuccessLoginModel.fromMap(Map<String, dynamic> map) {
    return ResponseSuccessLoginModel(
      token: map['token'].toString(),
      username: map['username'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'username': username,
    };
  }
}
