class CurrentUser {
  bool status;
  Data data;

  CurrentUser({this.status, this.data});

  CurrentUser.  fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String firstName;
  String lastName;
  String surname;
  String gender;
  String dob;
  String address;
  String postcode;
  String email;
  String profileImage;
  var fresh_login;
  Data(
      {this.id,
        this.firstName,
        this.lastName,
        this.surname,
        this.gender,
        this.dob,
        this.address,
        this.postcode,
        this.email,
        this.fresh_login,
        this.profileImage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    surname = json['surname'];
    gender = json['gender'];
    dob = json['dob'];
    address = json['address'];
    postcode = json['postcode'];
    email = json['email'];
    profileImage = json['profile_image'];
    fresh_login = json['fresh_login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['surname'] = this.surname;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['address'] = this.address;
    data['postcode'] = this.postcode;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    data['fresh_login'] = this.fresh_login;
    return data;
  }
}
