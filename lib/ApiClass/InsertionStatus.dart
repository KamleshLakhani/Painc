class InsertionStatus {
  bool status;
  Data data;
  bool baseline_status;
  String date;
  InsertionStatus({this.data,this.status, this.date,this.baseline_status});

  InsertionStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    baseline_status = json['baseline_status'];
    date = json['date'];
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
  Painlocation painlocation;
  Painintensity painintensity;
  //Painquallity painquallity;
  List<Painquallity> painquallity;
  //Medication medication;
  List<Medication> medication;
  Treatments treatments;
  Paininterferences paininterferences;
  QOL qualityoflife;
  FurtherInformations furtherInformations;

  Data(
      {this.painlocation,
        this.painintensity,
        this.painquallity,
        this.medication,
        this.treatments,
        this.paininterferences,
        this.qualityoflife,
        this.furtherInformations});

  Data.fromJson(Map<String, dynamic> json) {
    painlocation = json['Painlocation'] != null
        ? new Painlocation.fromJson(json['Painlocation'])
        : null;
    painintensity = json['Painintensity'] != null
        ? new Painintensity.fromJson(json['Painintensity'])
        : null;
    if (json['Painquallity'] != null) {
      painquallity = new List<Painquallity>();
      json['Painquallity'].forEach((v) { painquallity.add(new Painquallity.fromJson(v)); });
    }
    if (json['Medication'] != null) {
      medication = new List<Medication>();
      json['Medication'].forEach((v) {medication.add(new Medication.fromJson(v));});
    }
    /*medication = json['Medication'] != null
        ? new Medication.fromJson(json['Medication'])
        : null;*/
    treatments = json['Treatments'] != null
        ? new Treatments.fromJson(json['Treatments'])
        : null;
    paininterferences = json['Paininterferences'] != null
        ? new Paininterferences.fromJson(json['Paininterferences'])
        : null;
    qualityoflife = json['QOL'] != null
        ? new QOL.fromJson(json['QOL'])
        : null;
    furtherInformations = json['further_informations'] != null
        ? new FurtherInformations.fromJson(json['further_informations'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.painlocation != null) {
      data['Painlocation'] = this.painlocation.toJson();
    }
    if (this.painintensity != null) {
      data['Painintensity'] = this.painintensity.toJson();
    }
    if (this.painquallity != null) {
      data['Painquallity'] = this.painquallity.map((v) => v.toJson()).toList();
    }
    if (this.medication != null) {
      data['Medication'] = this.medication.map((v) => v.toJson()).toList();
    }
    /*if (this.medication != null) {
      data['Medication'] = this.medication.toJson();
    }*/
    if (this.treatments != null) {
      data['Treatments'] = this.treatments.toJson();
    }
    if (this.paininterferences != null) {
      data['Paininterferences'] = this.paininterferences.toJson();
    }
    if (this.qualityoflife != null) {
      data['QOL'] = this.qualityoflife.toJson();
    }
    if (this.furtherInformations != null) {
      data['further_informations'] = this.furtherInformations.toJson();
    }
    return data;
  }
}

class Painlocation {
  int id;
  int tsId;
  String front;
  String back;
  String createdAt;
  String updatedAt;

  Painlocation(
      {this.id,
        this.tsId,
        this.front,
        this.back,
        this.createdAt,
        this.updatedAt});

  Painlocation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tsId = json['tsId'];
    front = json['front'];
    back = json['back'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tsId'] = this.tsId;
    data['front'] = this.front;
    data['back'] = this.back;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class Painintensity {
  int id;
  int tsId;
  var painIntensity;
  String createdAt;
  String updatedAt;

  Painintensity(
      {this.id, this.tsId, this.painIntensity, this.createdAt, this.updatedAt});

  Painintensity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tsId = json['tsId'];
    painIntensity = json['pain_intensity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tsId'] = this.tsId;
    data['pain_intensity'] = this.painIntensity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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

  Medication(
      {this.id,
        this.tsId,
        this.medicineId,
        this.doses,
        this.tabletsPerDay,
        this.createdAt,
        this.updatedAt});

  Medication.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tsId = json['tsId'];
    medicineId = json['medicine_id'];
    doses = json['doses'];
    tabletsPerDay = json['tablets_per_day'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return data;
  }
}
class Painquallity {
  int id;
  int tsId;
  int descriptorId;
  String createdAt;
  String updatedAt;
  Descriptor descriptor;

  Painquallity({this.id, this.tsId, this.descriptorId, this.createdAt, this.updatedAt, this.descriptor});

  Painquallity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tsId = json['tsId'];
    descriptorId = json['descriptor_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    descriptor = json['descriptor'] != null ? new Descriptor.fromJson(json['descriptor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tsId'] = this.tsId;
    data['descriptor_id'] = this.descriptorId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.descriptor != null) {
      data['descriptor'] = this.descriptor.toJson();
    }
    return data;
  }
}
class Descriptor {
  int id;
  String name;
  int status;
  String createdAt;
  String updatedAt;

  Descriptor({this.id, this.name, this.status, this.createdAt, this.updatedAt});

  Descriptor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class Treatments {
  int id;
  int tsId;
  int treatmentId;
  String createdAt;
  String updatedAt;

  Treatments(
      {this.id, this.tsId, this.treatmentId, this.createdAt, this.updatedAt});

  Treatments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tsId = json['tsId'];
    treatmentId = json['treatment_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tsId'] = this.tsId;
    data['treatment_id'] = this.treatmentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class Paininterferences {
  int id;
  int tsId;
  String generalActivity;
  String enjoymentLife;
  String createdAt;
  String updatedAt;

  Paininterferences(
      {this.id,
        this.tsId,
        this.generalActivity,
        this.enjoymentLife,
        this.createdAt,
        this.updatedAt});

  Paininterferences.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tsId = json['tsId'];
    generalActivity = json['general_activity'];
    enjoymentLife = json['enjoyment_life'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tsId'] = this.tsId;
    data['general_activity'] = this.generalActivity;
    data['enjoyment_life'] = this.enjoymentLife;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class QOL {
  int id;
  int tsId;
  String helth_thermometer;
  String createdAt;
  String updatedAt;

  QOL(
      {this.id, this.tsId, this.helth_thermometer, this.createdAt, this.updatedAt});

  QOL.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tsId = json['tsId'];
    helth_thermometer = json['helth_thermometer'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tsId'] = this.tsId;
    data['helth_thermometer'] = this.helth_thermometer;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class FurtherInformations {
  int id;
  String description;
  int tsId;
  String createdAt;
  String updatedAt;

  FurtherInformations(
      {this.id, this.description, this.tsId, this.createdAt, this.updatedAt});

  FurtherInformations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    tsId = json['tsId'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['tsId'] = this.tsId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
