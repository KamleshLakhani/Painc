// To parse this JSON data, do
//
//     final registrationModel = registrationModelFromJson(jsonString);

import 'dart:convert';

RegistrationModel registrationModelFromJson(String str) => RegistrationModel.fromJson(json.decode(str));

String registrationModelToJson(RegistrationModel data) => json.encode(data.toJson());

class RegistrationModel {
  RegistrationModel({
    this.firstName,
    this.lastName,
    this.surname,
    this.email,
    this.gender,
    this.dob,
    this.address,
    this.postcode,
    this.password,
    this.passwordConfirmation,
  });

  String firstName;
  String lastName;
  String surname;
  String email;
  String gender;
  DateTime dob;
  String address;
  String postcode;
  String password;
  String passwordConfirmation;

  factory RegistrationModel.fromJson(Map<String, dynamic> json) => RegistrationModel(
    firstName: json["first_name"],
    lastName: json["last_name"],
    surname: json["surname"],
    email: json["email"],
    gender: json["gender"],
    dob: DateTime.parse(json["dob"]),
    address: json["address"],
    postcode: json["postcode"],
    password: json["password"],
    passwordConfirmation: json["password_confirmation"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "surname": surname,
    "email": email,
    "gender": gender,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "address": address,
    "postcode": postcode,
    "password": password,
    "password_confirmation": passwordConfirmation,
  };
}
class RegSuccess {
  bool status;
  String message;
  String info;

  RegSuccess({this.status, this.message, this.info});

  RegSuccess.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    info = json['info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['info'] = this.info;
    return data;
  }
}

