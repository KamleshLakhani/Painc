class PainIntensityReport {
  bool status;
  List<Data> data;

  PainIntensityReport({this.status, this.data});

  PainIntensityReport.fromJson(Map<String, dynamic> json) {
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

  Data({this.date, this.painIntensity});

  Data.fromJson(Map<String, dynamic> json) {
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
