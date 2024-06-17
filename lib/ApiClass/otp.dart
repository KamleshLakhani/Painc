class InvalidOtp {
  bool status;
  String message;
  Error error;

  InvalidOtp({this.status, this.message, this.error});

  InvalidOtp.fromJson(Map<String, dynamic> json) {
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
  List<dynamic> email;
  List<dynamic> otp;
  List<dynamic> password;

  Error({this.email, this.otp, this.password});

  Error.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    otp = json['otp'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['otp'] = this.otp;
    data['password'] = this.password;
    return data;
  }
}

class ValidOtp {
  bool status;
  String message;

  ValidOtp({this.status, this.message});

  ValidOtp.fromJson(Map<String, dynamic> json) {
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

