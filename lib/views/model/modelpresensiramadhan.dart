class ModelPresensiRamadhan {
  MetaData? metaData;
  List<Response>? response;

  ModelPresensiRamadhan({this.metaData, this.response});

  ModelPresensiRamadhan.fromJson(Map<String, dynamic> json) {
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
  String? materiId;
  String? kegiatan;
  String? tanggale;
  String? dariJam;
  String? sampaiJam;
  String? pemateri;
  String? keterangan;
  String? radiusId;
  String? tempat;
  String? lat;
  String? long;
  String? radius;
  String? sesi;
  String? hikmah;

  Response(
      {this.materiId,
      this.kegiatan,
      this.tanggale,
      this.dariJam,
      this.sampaiJam,
      this.pemateri,
      this.keterangan,
      this.radiusId,
      this.tempat,
      this.lat,
      this.long,
      this.radius,
      this.sesi,
      this.hikmah});

  Response.fromJson(Map<String, dynamic> json) {
    materiId = json['materi_id'];
    kegiatan = json['kegiatan'];
    tanggale = json['tanggale'];
    dariJam = json['dari_jam'];
    sampaiJam = json['sampai_jam'];
    pemateri = json['pemateri'];
    keterangan = json['keterangan'];
    radiusId = json['radius_id'];
    tempat = json['tempat'];
    lat = json['lat'];
    long = json['long'];
    radius = json['radius'];
    sesi = json['sesi'];
    hikmah = json['hikmah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['materi_id'] = this.materiId;
    data['kegiatan'] = this.kegiatan;
    data['tanggale'] = this.tanggale;
    data['dari_jam'] = this.dariJam;
    data['sampai_jam'] = this.sampaiJam;
    data['pemateri'] = this.pemateri;
    data['keterangan'] = this.keterangan;
    data['radius_id'] = this.radiusId;
    data['tempat'] = this.tempat;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['radius'] = this.radius;
    data['sesi'] = this.sesi;
    data['hikmah'] = this.hikmah;
    return data;
  }
}
