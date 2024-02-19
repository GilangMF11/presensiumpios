class ModelDropdownPengajian {
  bool? status;
  List<DataRes>? data;
  String? message;

  ModelDropdownPengajian({this.status, this.data, this.message});

  ModelDropdownPengajian.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <DataRes>[];
      json['data'].forEach((v) {
        data!.add(new DataRes.fromJson(v));
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

class DataRes {
  String? bulan;
  String? bln;
  String? th;

  DataRes({this.bulan, this.bln, this.th});

  DataRes.fromJson(Map<String, dynamic> json) {
    bulan = json['bulan'];
    bln = json['bln'];
    th = json['th'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bulan'] = this.bulan;
    data['bln'] = this.bln;
    data['th'] = this.th;
    return data;
  }
}
