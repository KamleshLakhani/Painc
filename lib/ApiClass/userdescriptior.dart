class PainquallityUser {
  bool status;
  Data data;

  PainquallityUser({this.status, this.data});

  PainquallityUser.fromJson(Map<String, dynamic> json) {
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
  List<Painquallity> painquallity;

  Data({this.painquallity});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['Painquallity'] != null) {
      painquallity = new List<Painquallity>();
      json['Painquallity'].forEach((v) {
        painquallity.add(new Painquallity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.painquallity != null) {
      data['Painquallity'] = this.painquallity.map((v) => v.toJson()).toList();
    }
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

  Painquallity(
      {this.id,
        this.tsId,
        this.descriptorId,
        this.createdAt,
        this.updatedAt,
        this.descriptor});

  Painquallity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tsId = json['tsId'];
    descriptorId = json['descriptor_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    descriptor = json['descriptor'] != null
        ? new Descriptor.fromJson(json['descriptor'])
        : null;
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
