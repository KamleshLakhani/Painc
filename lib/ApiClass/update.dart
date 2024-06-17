class Update {
  bool status;
  String message;
  Data data;

  Update({this.status, this.message, this.data});

  Update.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  User user;
  String token;

  Data({this.user, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  String lastName;
  String surname;
  String gender;
  String dob;
  String address;
  String postcode;
  String profileImage;

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.surname,
        this.gender,
        this.dob,
        this.address,
        this.postcode,
        this.profileImage,
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    surname = json['surname'];
    gender = json['gender'];
    dob = json['dob'];
    address = json['address'];
    postcode = json['postcode'];
    profileImage = json['profile_image'];
    //emailVerifiedAt = json['email_verified_at'];
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
    data['profile_image'] = this.profileImage;
    return data;
  }
}
