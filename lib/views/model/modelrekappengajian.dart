class ModelRekapPengajian {
  bool? status;
  List<DataPengajianA>? data;
  String? message;

  ModelRekapPengajian({this.status, this.data, this.message});

  ModelRekapPengajian.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <DataPengajianA>[];
      json['data'].forEach((v) {
        data!.add(new DataPengajianA.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class DataPengajianA {
  String? temaPengajian;
  String? hikmah;
  String? nik;
  String? waktuPresensi;

  DataPengajianA(
      {this.temaPengajian, this.hikmah, this.nik, this.waktuPresensi});

  DataPengajianA.fromJson(Map<String, dynamic> json) {
    temaPengajian = json['tema_pengajian'];
    hikmah = json['hikmah'];
    nik = json['nik'];
    waktuPresensi = json['waktu_presensi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tema_pengajian'] = this.temaPengajian;
    data['hikmah'] = this.hikmah;
    data['nik'] = this.nik;
    data['waktu_presensi'] = this.waktuPresensi;
    return data;
  }
}
