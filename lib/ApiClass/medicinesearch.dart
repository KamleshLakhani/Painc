class SearchMedicine {
  bool status;
  String message;
  List<Data> data;

  SearchMedicine({this.status, this.message, this.data});

  SearchMedicine.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
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
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String drug;
  var cdw;
  var maxdose;
  String drugType;
  List<dynamic> units;
  List<dynamic> score;

  Data(
      {this.id,
        this.drug,
        this.cdw,
        this.maxdose,
        this.drugType,
        this.units,
        this.score});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    drug = json['drug'];
    cdw = json['cdw'];
    maxdose = json['maxdose'];
    drugType = json['drug_type'];
    units = json['units'];
    score = json['score'];
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
    return data;
  }
}
