class ModelRekapLogbook {
  bool? status;
  List<Data>? data;

  ModelRekapLogbook({this.status, this.data});

  ModelRekapLogbook.fromJson(Map<String, dynamic> json) {
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
  String? jamMulai;
  String? jamSelesai;
  String? catatan;
  int? status;

  Data(
      {this.id,
      this.nik,
      this.tanggal,
      this.jamMulai,
      this.jamSelesai,
      this.catatan,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nik = json['nik'];
    tanggal = json['tanggal'];
    jamMulai = json['jam_mulai'];
    jamSelesai = json['jam_selesai'];
    catatan = json['catatan'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nik'] = this.nik;
    data['tanggal'] = this.tanggal;
    data['jam_mulai'] = this.jamMulai;
    data['jam_selesai'] = this.jamSelesai;
    data['catatan'] = this.catatan;
    data['status'] = this.status;
    return data;
  }
}
