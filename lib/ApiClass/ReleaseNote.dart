class ReleaseNote {
  String message;
  ReleaseNotes releaseNotes;

  ReleaseNote({this.message, this.releaseNotes});

  ReleaseNote.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    releaseNotes = json['releaseNotes'] != null
        ? new ReleaseNotes.fromJson(json['releaseNotes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.releaseNotes != null) {
      data['releaseNotes'] = this.releaseNotes.toJson();
    }
    return data;
  }
}

class ReleaseNotes {
  int id;
  String releaseVersion;
  String description;
  String createdAt;
  String updatedAt;

  ReleaseNotes(
      {this.id,
        this.releaseVersion,
        this.description,
        this.createdAt,
        this.updatedAt});

  ReleaseNotes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    releaseVersion = json['release_version'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['release_version'] = this.releaseVersion;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
