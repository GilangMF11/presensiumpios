class ModelRekap {
  bool? status;
  String? message;
  List<Data>? data;

  ModelRekap({this.status, this.message, this.data});

  ModelRekap.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
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
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? tanggal;
  String? masuk;
  String? keluar;
  String? label;
  String? hari;

  Data({this.tanggal, this.masuk, this.keluar, this.label, this.hari});

  Data.fromJson(Map<String, dynamic> json) {
    tanggal = json['tanggal'];
    masuk = json['masuk'];
    keluar = json['keluar'];
    label = json['label'];
    hari = json['hari'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tanggal'] = this.tanggal;
    data['masuk'] = this.masuk;
    data['keluar'] = this.keluar;
    data['label'] = this.label;
    data['hari'] = this.hari;
    return data;
  }
}
