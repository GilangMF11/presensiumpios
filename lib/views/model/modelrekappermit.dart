class ModelRekapPermit {
  bool? status;
  List<Data>? data;

  ModelRekapPermit({this.status, this.data});

  ModelRekapPermit.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? id;
  String? nik;
  String? tanggal;
  String? tglMulai;
  String? tglAkhir;
  dynamic? tipePermit;
  String? keterangan;
  String? file;
  int? status;

  Data(
      {this.id,
      this.nik,
      this.tanggal,
      this.tglMulai,
      this.tglAkhir,
      this.tipePermit,
      this.keterangan,
      this.file,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nik = json['nik'];
    tanggal = json['tanggal'];
    tglMulai = json['tgl_mulai'];
    tglAkhir = json['tgl_akhir'];
    tipePermit = json['tipe_permit'];
    keterangan = json['keterangan'];
    file = json['file'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nik'] = this.nik;
    data['tanggal'] = this.tanggal;
    data['tgl_mulai'] = this.tglMulai;
    data['tgl_akhir'] = this.tglAkhir;
    data['tipe_permit'] = this.tipePermit;
    data['keterangan'] = this.keterangan;
    data['file'] = this.file;
    data['status'] = this.status;
    return data;
  }
}
