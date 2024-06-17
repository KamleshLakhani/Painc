class AddMedicineError {
  bool status;
  String message;
  Error error;

  AddMedicineError({this.status, this.message, this.error});

  AddMedicineError.fromJson(Map<String, dynamic> json) {
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
  List<String> medicineId;
  List<String> doses;

  Error({this.medicineId, this.doses});

  Error.fromJson(Map<String, dynamic> json) {
    medicineId = json['medicine_id'].cast<String>();
    doses = json['doses'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medicine_id'] = this.medicineId;
    data['doses'] = this.doses;
    return data;
  }
}
