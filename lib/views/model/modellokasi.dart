class ModelLocation {
  bool? status;
  List<DataISI>? data;

  ModelLocation({this.status, this.data});

  ModelLocation.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <DataISI>[];
      json['data'].forEach((v) {
        data!.add(new DataISI.fromJson(v));
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

class DataISI {
  String? label;
  DetailAA? detail;

  DataISI({this.label, this.detail});

  DataISI.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    detail =
        json['detail'] != null ? new DetailAA.fromJson(json['detail']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    if (this.detail != null) {
      data['detail'] = this.detail!.toJson();
    }
    return data;
  }
}

class DetailAA {
  double? lat;
  double? long;
  int? radius;
  String? idlokasi;
  DetailAA({this.lat, this.long, this.radius, this.idlokasi});

  DetailAA.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
    radius = json['radius'];
    idlokasi = json['idlokasi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['radius'] = this.radius;
    data['idlokasi'] = this.idlokasi;
    return data;
  }
}
