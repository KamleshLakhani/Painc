class PainIntensity {
  bool status;
  String message;

  PainIntensity({this.status, this.message});

  PainIntensity.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}class PainIntensityError {
  bool status;
  String message;
  Error error;

  PainIntensityError({this.status, this.message, this.error});

  PainIntensityError.fromJson(Map<String, dynamic> json) {
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
  List<String> painIntensity;

  Error({this.painIntensity});

  Error.fromJson(Map<String, dynamic> json) {
    painIntensity = json['pain_intensity'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pain_intensity'] = this.painIntensity;
    return data;
  }
}