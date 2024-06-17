class PainIntensityAndMQsReport {
  bool status;
  List<Data> data;
  List<PainIntensity> painIntensity;

  PainIntensityAndMQsReport({this.status, this.data, this.painIntensity});

  PainIntensityAndMQsReport.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    if (json['painIntensity'] != null) {
      painIntensity = new List<PainIntensity>();
      json['painIntensity'].forEach((v) {
        painIntensity.add(new PainIntensity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.painIntensity != null) {
      data['painIntensity'] =
          this.painIntensity.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String date;
  var scrore;

  Data({this.date, this.scrore});

  Data.fromJson(Map<String, dynamic> json) {
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
