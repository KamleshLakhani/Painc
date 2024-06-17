class UpdateSucc {
  bool status;
  String message;

  UpdateSucc({this.status, this.message});

  UpdateSucc.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
class UpdateFail {
  bool status;
  String message;
  Error error;

  UpdateFail({this.status, this.message, this.error});

  UpdateFail.fromJson(Map<String, dynamic> json) {
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
  List<String> firstName;
  List<dynamic> lastName;
  List<String> surname;
  List<dynamic> gender;
  List<String> dob;
  List<dynamic> address;
  List<String> postcode;

  Error(
      {this.firstName,
        this.lastName,
        this.surname,
        this.gender,
        this.dob,
        this.address,
        this.postcode});

  Error.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    surname = json['surname'];
    gender = json['gender'];
    dob = json['dob'];
    address = json['address'];
    postcode = json['postcode'];
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
    return data;
  }
}
