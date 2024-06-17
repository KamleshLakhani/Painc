class GetMedicine {
  bool status;
  List<Medication> medication;
  var medicationScore;

  GetMedicine({this.status, this.medication, this.medicationScore});

  GetMedicine.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['medication'] != null) {
      medication = new List<Medication>();
      json['medication'].forEach((v) {
        medication.add(new Medication.fromJson(v));
      });
    }
    medicationScore = json['medicationScore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.medication != null) {
      data['medication'] = this.medication.map((v) => v.toJson()).toList();
    }
    data['medicationScore'] = this.medicationScore;
    return data;
  }
}

class Medication {
  int id;
  int tsId;
  int medicineId;
  String doses;
  int tabletsPerDay;
  String createdAt;
  String updatedAt;
  Medicine medicine;

  Medication(
      {this.id,
        this.tsId,
        this.medicineId,
        this.doses,
        this.tabletsPerDay,
        this.createdAt,
        this.updatedAt,
        this.medicine});

  Medication.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tsId = json['tsId'];
    medicineId = json['medicine_id'];
    doses = json['doses'];
    tabletsPerDay = json['tablets_per_day'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    medicine = json['medicine'] != null
        ? new Medicine.fromJson(json['medicine'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tsId'] = this.tsId;
    data['medicine_id'] = this.medicineId;
    data['doses'] = this.doses;
    data['tablets_per_day'] = this.tabletsPerDay;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.medicine != null) {
      data['medicine'] = this.medicine.toJson();
    }
    return data;
  }
}

class Medicine {
  int id;
  String drug;
  var cdw;
  var maxdose;
  String drugType;
  String units;
  String score;
  String createdAt;
  String updatedAt;

  Medicine(
      {this.id,
        this.drug,
        this.cdw,
        this.maxdose,
        this.drugType,
        this.units,
        this.score,
        this.createdAt,
        this.updatedAt});

  Medicine.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    drug = json['drug'];
    cdw = json['cdw'];
    maxdose = json['maxdose'];
    drugType = json['drug_type'];
    units = json['units'];
    score = json['score'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['drug'] = this.drug;
    data['cdw'] = this.cdw;
    data['maxdose'] = this.maxdose;
    data['drug_type'] = this.drugType;
    data['units'] = this.units;
    data['score'] = this.score;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
