import 'dart:convert';

ModelLogbook1445 modelLogbook1445FromJson(String str) =>
    ModelLogbook1445.fromJson(json.decode(str));

String modelLogbook1445ToJson(ModelLogbook1445 data) =>
    json.encode(data.toJson());

class ModelLogbook1445 {
  MetaData metaData;
  List<Response> response;

  ModelLogbook1445({
    required this.metaData,
    required this.response,
  });

  factory ModelLogbook1445.fromJson(Map<String, dynamic> json) =>
      ModelLogbook1445(
        metaData: MetaData.fromJson(json["metaData"]),
        response: List<Response>.from(
            json["response"].map((x) => Response.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "metaData": metaData.toJson(),
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
      };

  // Menambahkan metode untuk mengurutkan response berdasarkan tanggal secara descending
  void sortByDateDesc() {
    response.sort((a, b) => b.tanggal.compareTo(a.tanggal));
  }
}

class MetaData {
  String message;
  String code;

  MetaData({
    required this.message,
    required this.code,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "code": code,
      };
}

class Response {
  int logbookId;
  String nip;
  String tanggal;
  String jenisKegiatan;
  String jamMulai;
  String jamAkhir;
  String keterangan;

  Response({
    required this.logbookId,
    required this.nip,
    required this.tanggal,
    required this.jenisKegiatan,
    required this.jamMulai,
    required this.jamAkhir,
    required this.keterangan,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        logbookId: json["logbook_id"],
        nip: json["NIP"],
        tanggal: json["tanggal"],
        jenisKegiatan: json["jenis_kegiatan"],
        jamMulai: json["jam_mulai"],
        jamAkhir: json["jam_akhir"],
        keterangan: json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "logbook_id": logbookId,
        "NIP": nip,
        "tanggal": tanggal,
        "jenis_kegiatan": jenisKegiatan,
        "jam_mulai": jamMulai,
        "jam_akhir": jamAkhir,
        "keterangan": keterangan,
      };
}
