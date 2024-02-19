class ModelPretest {
  List<Response>? response;
  List<Jawaban>? jawaban;

  ModelPretest({this.response, this.jawaban});

  ModelPretest.fromJson(Map<String, dynamic> json) {
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
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
    }
    if (this.jawaban != null) {
      data['jawaban'] = this.jawaban!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Response {
  String? no;
  String? soalId;
  String? soal;
  String? jenis;

  Response({this.no, this.soalId, this.soal, this.jenis});

  Response.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    soalId = json['soal_id'];
    soal = json['soal'];
    jenis = json['jenis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no'] = this.no;
    data['soal_id'] = this.soalId;
    data['soal'] = this.soal;
    data['jenis'] = this.jenis;
    return data;
  }
}

class Jawaban {
  String? soalId;
  String? pilId;
  String? pilJawaban;

  Jawaban({this.soalId, this.pilId, this.pilJawaban});

  Jawaban.fromJson(Map<String, dynamic> json) {
    soalId = json['soal_id'];
    pilId = json['pil_id'];
    pilJawaban = json['pil_jawaban'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['soal_id'] = this.soalId;
    data['pil_id'] = this.pilId;
    data['pil_jawaban'] = this.pilJawaban;
    return data;
  }
}
