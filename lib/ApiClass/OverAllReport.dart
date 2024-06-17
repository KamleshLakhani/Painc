class OverAllReport {
  bool status;
  List<Data> data;

  OverAllReport({this.status, this.data});

  OverAllReport.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String date;
  var painIntensity;
  var helthThermometer;
  var medication;
  var generalActivity;
  var enjoymentLife;

  Data(
      {this.date,
        this.painIntensity,
        this.helthThermometer,
        this.medication,
        this.generalActivity,
        this.enjoymentLife});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    painIntensity = json['pain_intensity'];
    helthThermometer = json['helth_thermometer'];
    medication = json['medication'];
    generalActivity = json['general_activity'];
    enjoymentLife = json['enjoyment_life'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['pain_intensity'] = this.painIntensity;
    data['helth_thermometer'] = this.helthThermometer;
    data['medication'] = this.medication;
    data['general_activity'] = this.generalActivity;
    data['enjoyment_life'] = this.enjoymentLife;
    return data;
  }
}

/*
class OverAllReport {
  bool status;
  Data data;

  OverAllReport({this.status, this.data});

  OverAllReport.fromJson(Map<String, dynamic> json) {
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
  List<PainIntensity> painIntensity;
  List<QualityOfLifeReport> qualityOfLifeReport;
  List<Medication> medication;
  List<EnjoymentOfLife> enjoymentOfLife;

  Data(
      {this.painIntensity,
        this.qualityOfLifeReport,
        this.medication,
        this.enjoymentOfLife});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['painIntensity'] != null) {
      painIntensity = new List<PainIntensity>();
      json['painIntensity'].forEach((v) {
        painIntensity.add(new PainIntensity.fromJson(v));
      });
    }
    if (json['qualityOfLifeReport'] != null) {
      qualityOfLifeReport = new List<QualityOfLifeReport>();
      json['qualityOfLifeReport'].forEach((v) {
        qualityOfLifeReport.add(new QualityOfLifeReport.fromJson(v));
      });
    }
    if (json['medication'] != null) {
      medication = new List<Medication>();
      json['medication'].forEach((v) {
        medication.add(new Medication.fromJson(v));
      });
    }
    if (json['enjoymentOfLife'] != null) {
      enjoymentOfLife = new List<EnjoymentOfLife>();
      json['enjoymentOfLife'].forEach((v) {
        enjoymentOfLife.add(new EnjoymentOfLife.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.painIntensity != null) {
      data['painIntensity'] =
          this.painIntensity.map((v) => v.toJson()).toList();
    }
    if (this.qualityOfLifeReport != null) {
      data['qualityOfLifeReport'] =
          this.qualityOfLifeReport.map((v) => v.toJson()).toList();
    }
    if (this.medication != null) {
      data['medication'] = this.medication.map((v) => v.toJson()).toList();
    }
    if (this.enjoymentOfLife != null) {
      data['enjoymentOfLife'] =
          this.enjoymentOfLife.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PainIntensity {
  String date;
  var painIntensity;

  PainIntensity({this.date, this.painIntensity});

  PainIntensity.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    painIntensity = json['pain_intensity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['pain_intensity'] = this.painIntensity;
    return data;
  }
}

class QualityOfLifeReport {
  String date;
  var helthThermometer;

  QualityOfLifeReport({this.date, this.helthThermometer});

  QualityOfLifeReport.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    helthThermometer = json['helth_thermometer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['helth_thermometer'] = this.helthThermometer;
    return data;
  }
}

class Medication {
  String date;
  var scrore;

  Medication({this.date, this.scrore});

  Medication.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    scrore = json['scrore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['scrore'] = this.scrore;
    return data;
  }
}

class EnjoymentOfLife {
  String date;
  var generalActivity;
  var enjoymentLife;

  EnjoymentOfLife({this.date, this.generalActivity, this.enjoymentLife});

  EnjoymentOfLife.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    generalActivity = json['general_activity'];
    enjoymentLife = json['enjoyment_life'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['general_activity'] = this.generalActivity;
    data['enjoyment_life'] = this.enjoymentLife;
    return data;
  }
}*/
