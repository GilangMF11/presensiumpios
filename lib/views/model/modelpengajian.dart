class ModelPengajianGet {
  bool? status;
  List<ResponsePengajian>? data;

  ModelPengajianGet({this.status, this.data});

  ModelPengajianGet.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ResponsePengajian>[];
      json['data'].forEach((v) {
        data!.add(new ResponsePengajian.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResponsePengajian {
  String? id;
  String? temaPengajian;
  String? tglHijriyah;
  String? tglMasehi;
  String? jamTutup;
  String? brosur;
  String? jamMulai;
  String? longlitude;
  String? latitude;
  String? radius;
  String? tempat;

  ResponsePengajian(
      {this.id,
      this.temaPengajian,
      this.tglHijriyah,
      this.tglMasehi,
      this.jamTutup,
      this.brosur,
      this.jamMulai,
      this.longlitude,
      this.latitude,
      this.radius,
      this.tempat});

  ResponsePengajian.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    temaPengajian = json['tema_pengajian'];
    tglHijriyah = json['tgl_hijriyah'];
    tglMasehi = json['tgl_masehi'];
    jamTutup = json['jam_tutup'];
    brosur = json['brosur'];
    jamMulai = json['jam_mulai'];
    longlitude = json['longlitude'];
    latitude = json['latitude'];
    radius = json['radius'];
    tempat = json['tempat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tema_pengajian'] = this.temaPengajian;
    data['tgl_hijriyah'] = this.tglHijriyah;
    data['tgl_masehi'] = this.tglMasehi;
    data['jam_tutup'] = this.jamTutup;
    data['brosur'] = this.brosur;
    data['jam_mulai'] = this.jamMulai;
    data['longlitude'] = this.longlitude;
    data['latitude'] = this.latitude;
    data['radius'] = this.radius;
    data['tempat'] = this.tempat;
    return data;
  }
}
