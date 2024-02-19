class ModelRekapLembur {
  bool? status;
  List<Data>? data;

  ModelRekapLembur({this.status, this.data});

  ModelRekapLembur.fromJson(Map<String, dynamic> json) {
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
  String? jamAwal;
  String? jamAkhir;
  int? selama;
  String? keterangan;
  int? status;

  Data(
      {this.id,
      this.nik,
      this.tanggal,
      this.jamAwal,
      this.jamAkhir,
      this.selama,
      this.keterangan,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nik = json['nik'];
    tanggal = json['tanggal'];
    jamAwal = json['jam_awal'];
    jamAkhir = json['jam_akhir'];
    selama = json['selama'];
    keterangan = json['keterangan'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nik'] = this.nik;
    data['tanggal'] = this.tanggal;
    data['jam_awal'] = this.jamAwal;
    data['jam_akhir'] = this.jamAkhir;
    data['selama'] = this.selama;
    data['keterangan'] = this.keterangan;
    data['status'] = this.status;
    return data;
  }
}
