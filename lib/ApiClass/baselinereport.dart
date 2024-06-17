class BaseLineReport {
  Painlocation painlocation;
  List<String> painquality;
  Medication medication;
  List<Treatment> treatment;
  PainInterefernce painInterefernce;
  String qualityOfLife;
  String additionalInformation;

  BaseLineReport(
      {this.painlocation,
        this.painquality,
        this.medication,
        this.treatment,
        this.painInterefernce,
        this.qualityOfLife,
        this.additionalInformation});

  BaseLineReport.fromJson(Map<String, dynamic> json) {
    painlocation = json['Painlocation'] != null
        ? new Painlocation.fromJson(json['Painlocation'])
        : null;
    painquality = json['painquality'].cast<String>();
    medication = json['medication'] != null
        ? new Medication.fromJson(json['medication'])
        : null;
    if (json['treatment'] != null) {
      treatment = new List<Treatment>();
      json['treatment'].forEach((v) {
        treatment.add(new Treatment.fromJson(v));
      });
    }
    painInterefernce = json['pain_interefernce'] != null
        ? new PainInterefernce.fromJson(json['pain_interefernce'])
        : null;
    qualityOfLife = json['quality_of_life'];
    additionalInformation = json['additional_information'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.painlocation != null) {
      data['Painlocation'] = this.painlocation.toJson();
    }
    data['painquality'] = this.painquality;
    if (this.medication != null) {
      data['medication'] = this.medication.toJson();
    }
    if (this.treatment != null) {
      data['treatment'] = this.treatment.map((v) => v.toJson()).toList();
    }
    if (this.painInterefernce != null) {
      data['pain_interefernce'] = this.painInterefernce.toJson();
    }
    data['quality_of_life'] = this.qualityOfLife;
    data['additional_information'] = this.additionalInformation;
    return data;
  }
}

class Painlocation {
  String front;
  String back;

  Painlocation({this.front, this.back});

  Painlocation.fromJson(Map<String, dynamic> json) {
    front = json['front'];
    back = json['back'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['front'] = this.front;
    data['back'] = this.back;
    return data;
  }
}

class Medication {
  List<Drug> drug;
  double total;

  Medication({this.drug, this.total});

  Medication.fromJson(Map<String, dynamic> json) {
    if (json['drug'] != null) {
      drug = new List<Drug>();
      json['drug'].forEach((v) {
        drug.add(new Drug.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.drug != null) {
      data['drug'] = this.drug.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class Drug {
  int doses;
  int tabletsPerDay;
  String drug;

  Drug({this.doses, this.tabletsPerDay, this.drug});

  Drug.fromJson(Map<String, dynamic> json) {
    doses = json['doses'];
    tabletsPerDay = json['tablets_per_day'];
    drug = json['drug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doses'] = this.doses;
    data['tablets_per_day'] = this.tabletsPerDay;
    data['drug'] = this.drug;
    return data;
  }
}

class Treatment {
  String name;
  String icon;

  Treatment({this.name, this.icon});

  Treatment.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['icon'] = this.icon;
    return data;
  }
}

class PainInterefernce {
  String enjoymentOfLife;
  String generalActivity;

  PainInterefernce({this.enjoymentOfLife, this.generalActivity});

  PainInterefernce.fromJson(Map<String, dynamic> json) {
    enjoymentOfLife = json['enjoyment_of_life'];
    generalActivity = json['general_activity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enjoyment_of_life'] = this.enjoymentOfLife;
    data['general_activity'] = this.generalActivity;
    return data;
  }
}
