class ModelEvaluasiQuisioner {
  MetaData? metaData;
  List<Response>? response;
  List<Jawaban>? jawaban;

  ModelEvaluasiQuisioner({this.metaData, this.response, this.jawaban});

  ModelEvaluasiQuisioner.fromJson(Map<String, dynamic> json) {
    metaData = json['metaData'] != null
        ? new MetaData.fromJson(json['metaData'])
        : null;
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(new Response.fromJson(v));
      });
    }
    if (json['jawaban'] != null) {
      jawaban = <Jawaban>[];
      json['jawaban'].forEach((v) {
        jawaban!.add(new Jawaban.fromJson(v));
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
    if (this.jawaban != null) {
      data['jawaban'] = this.jawaban!.map((v) => v.toJson()).toList();
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

class Response {
  String? no;
  String? soalId;
  String? soal;

  Response({this.no, this.soalId, this.soal});

  Response.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    soalId = json['soal_id'];
    soal = json['soal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no'] = this.no;
    data['soal_id'] = this.soalId;
    data['soal'] = this.soal;
    return data;
  }
}

class Jawaban {
  String? pilId;
  String? pilJawaban;

  Jawaban({this.pilId, this.pilJawaban});

  Jawaban.fromJson(Map<String, dynamic> json) {
    pilId = json['pil_id'];
    pilJawaban = json['pil_jawaban'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pil_id'] = this.pilId;
    data['pil_jawaban'] = this.pilJawaban;
    return data;
  }
}
