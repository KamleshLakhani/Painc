// To parse this JSON data, do
//
//     final loginError = loginErrorFromJson(jsonString);

import 'dart:convert';

LoginError loginErrorFromJson(String str) => LoginError.fromJson(json.decode(str));

String loginErrorToJson(LoginError data) => json.encode(data.toJson());

class LoginError {
  LoginError({
    this.status,
    this.message,
  });

  bool status;
  String message;

  factory LoginError.fromJson(Map<String, dynamic> json) => LoginError(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
