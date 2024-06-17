class MainError {
  bool status;
  String message;
  Error error;

  MainError({this.status, this.message, this.error});

  MainError.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.error != null) {
      data['error'] = this.error.toJson();
    }
    return data;
  }
}

class Error {
  List<dynamic> firstName;
  List<dynamic> lastName;
  List<dynamic> surname;
  List<dynamic> gender;
  List<dynamic> dob;
  List<dynamic> address;
  List<dynamic> postcode;
  List<dynamic> email;
  List<dynamic> password;

  Error(
      {this.firstName,
        this.lastName,
        this.surname,
        this.gender,
        this.dob,
        this.address,
        this.postcode,
        this.email,
        this.password});

  Error.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    surname = json['surname'];
    gender = json['gender'];
    dob = json['dob'];
    address = json['address'];
    postcode = json['postcode'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['surname'] = this.surname;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['address'] = this.address;
    data['postcode'] = this.postcode;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}