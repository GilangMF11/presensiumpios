class ModelGetGelombang {
  MetaData? metaData;
  List<Response>? response;

  ModelGetGelombang({this.metaData, this.response});

  ModelGetGelombang.fromJson(Map<String, dynamic> json) {
    metaData = json['metaData'] != null
        ? new MetaData.fromJson(json['metaData'])
        : null;
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(new Response.fromJson(v));
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

class Response {
  String? uSERNAME;
  String? keterangan;
  String? gelombang;
  String? gelombangId;

  Response({this.uSERNAME, this.keterangan, this.gelombang, this.gelombangId});

  Response.fromJson(Map<String, dynamic> json) {
    uSERNAME = json['USERNAME'];
    keterangan = json['keterangan'];
    gelombang = json['gelombang'];
    gelombangId = json['gelombang_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['USERNAME'] = this.uSERNAME;
    data['keterangan'] = this.keterangan;
    data['gelombang'] = this.gelombang;
    data['gelombang_id'] = this.gelombangId;
    return data;
  }
}
