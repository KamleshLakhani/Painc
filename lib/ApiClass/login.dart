class LoginModel {
  bool status;
  String message;
  User user;
  String token;

  LoginModel({this.status, this.message, this.user, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  int id;
  String firstName;
  String patientId;
  String lastName;
  String surname;
  String gender;
  String dob;
  String address;
  String postcode;
  String email;
  String profileImage;
  String device_id;
  var fresh_login;

  User(
      {this.id,
        this.firstName,
        this.patientId,
        this.lastName,
        this.surname,
        this.gender,
        this.dob,
        this.address,
        this.postcode,
        this.email,
        this.fresh_login,
        this.device_id,
        this.profileImage});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    patientId = json['patient_id'];
    lastName = json['last_name'];
    surname = json['surname'];
    gender = json['gender'];
    dob = json['dob'];
    address = json['address'];
    postcode = json['postcode'];
    email = json['email'];
    profileImage = json['profile_image'];
    device_id = json['device_id'];
    fresh_login = json['fresh_login'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['patient_id'] = this.patientId;
    data['last_name'] = this.lastName;
    data['surname'] = this.surname;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['address'] = this.address;
    data['postcode'] = this.postcode;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    data['device_id'] = this.device_id;
    data['fresh_login'] = this.fresh_login;
    return data;
  }
}
