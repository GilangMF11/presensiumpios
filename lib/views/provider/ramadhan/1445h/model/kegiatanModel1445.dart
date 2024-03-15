import 'dart:convert';

class ModelKegiatan1445 {
  MetaData? metaData;
  List<Response>? response;
  List<Kegiatan>? listKegiatan; // Properti baru untuk menyimpan daftar kegiatan

  ModelKegiatan1445({
    this.metaData,
    this.response,
    this.listKegiatan,
  });

  factory ModelKegiatan1445.fromJson(Map<String, dynamic> json) =>
      ModelKegiatan1445(
        metaData: json["metaData"] == null
            ? null
            : MetaData.fromJson(json["metaData"]),
        response: json["response"] == null
            ? []
            : List<Response>.from(
                json["response"].map((x) => Response.fromJson(x))),
        listKegiatan: [], // Inisialisasi list kegiatan
      );

  Map<String, dynamic> toJson() => {
        "metaData": metaData?.toJson(),
        "response": response == null
            ? []
            : List<dynamic>.from(response!.map((x) => x.toJson())),
      };
}

class MetaData {
  String? message;
  String? code;

  MetaData({
    this.message,
    this.code,
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
  String? jenisKegiatan;
  String? jenisKegiatanId;

  Response({
    this.jenisKegiatan,
    this.jenisKegiatanId,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        jenisKegiatan: json["jenis_kegiatan"],
        jenisKegiatanId: json["jenis_kegiatan_id"],
      );

  Map<String, dynamic> toJson() => {
        "jenis_kegiatan": jenisKegiatan,
        "jenis_kegiatan_id": jenisKegiatanId,
      };
}

class Kegiatan {
  final String id;
  final String nama;

  Kegiatan(this.id, this.nama);
}
