class ModelSoalError {
  MetaData? metaData;

  ModelSoalError({this.metaData});

  ModelSoalError.fromJson(Map<String, dynamic> json) {
    metaData = json['metaData'] != null
        ? new MetaData.fromJson(json['metaData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.metaData != null) {
      data['metaData'] = this.metaData!.toJson();
    }
    return data;
  }
}

class MetaData {
  String? pesan;
  String? code;

  MetaData({this.pesan, this.code});

  MetaData.fromJson(Map<String, dynamic> json) {
    pesan = json['pesan'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pesan'] = this.pesan;
    data['code'] = this.code;
    return data;
  }
}
