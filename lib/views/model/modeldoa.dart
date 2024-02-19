class ModelDoa {
  MetaData? metaData;
  List<ResponseDoa>? response;

  ModelDoa({this.metaData, this.response});

  ModelDoa.fromJson(Map<String, dynamic> json) {
    metaData = json['metaData'] != null
        ? new MetaData.fromJson(json['metaData'])
        : null;
    if (json['response'] != null) {
      response = <ResponseDoa>[];
      json['response'].forEach((v) {
        response!.add(ResponseDoa.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.metaData != null) {
      data['metaData'] = this.metaData!.toJson();
    }
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MetaData {
  String? message;
  String? code;

  MetaData({this.message, this.code});

  MetaData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}

class ResponseDoa {
  String? id;
  String? doa;
  String? ayat;
  String? latin;
  String? artinya;

  ResponseDoa({this.id, this.doa, this.ayat, this.latin, this.artinya});

  ResponseDoa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doa = json['doa'];
    ayat = json['ayat'];
    latin = json['latin'];
    artinya = json['artinya'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doa'] = this.doa;
    data['ayat'] = this.ayat;
    data['latin'] = this.latin;
    data['artinya'] = this.artinya;
    return data;
  }
}
