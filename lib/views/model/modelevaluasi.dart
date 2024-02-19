class ModelEvaluasi {
  MetaData? metaData;
  List<Response>? response;

  ModelEvaluasi({this.metaData, this.response});

  ModelEvaluasi.fromJson(Map<String, dynamic> json) {
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
  String? nIP;
  String? kritik;
  String? saran;
  String? pesan;

  Response({this.nIP, this.kritik, this.saran, this.pesan});

  Response.fromJson(Map<String, dynamic> json) {
    nIP = json['NIP'];
    kritik = json['kritik'];
    saran = json['saran'];
    pesan = json['pesan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NIP'] = this.nIP;
    data['kritik'] = this.kritik;
    data['saran'] = this.saran;
    data['pesan'] = this.pesan;
    return data;
  }
}
