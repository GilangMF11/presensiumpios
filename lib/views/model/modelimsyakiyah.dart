class ModelImsyakyah {
  MetaData? metaData;
  ResponseImsyakah? response;

  ModelImsyakyah({this.metaData, this.response});

  ModelImsyakyah.fromJson(Map<String, dynamic> json) {
    metaData = json['metaData'] != null
        ? new MetaData.fromJson(json['metaData'])
        : null;
    response = json['response'] != null
        ? new ResponseImsyakah.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.metaData != null) {
      data['metaData'] = this.metaData!.toJson();
    }
    if (this.response != null) {
      data['response'] = this.response!.toJson();
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

class ResponseImsyakah {
  String? tanggal;
  String? imsak;
  String? subuh;
  String? terbit;
  String? dhuha;
  String? dzuhur;
  String? ashar;
  String? maghrib;
  String? isya;

  ResponseImsyakah(
      {this.tanggal,
      this.imsak,
      this.subuh,
      this.terbit,
      this.dhuha,
      this.dzuhur,
      this.ashar,
      this.maghrib,
      this.isya});

  ResponseImsyakah.fromJson(Map<String, dynamic> json) {
    tanggal = json['tanggal'];
    imsak = json['imsak'];
    subuh = json['subuh'];
    terbit = json['terbit'];
    dhuha = json['dhuha'];
    dzuhur = json['dzuhur'];
    ashar = json['ashar'];
    maghrib = json['maghrib'];
    isya = json['isya'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tanggal'] = this.tanggal;
    data['imsak'] = this.imsak;
    data['subuh'] = this.subuh;
    data['terbit'] = this.terbit;
    data['dhuha'] = this.dhuha;
    data['dzuhur'] = this.dzuhur;
    data['ashar'] = this.ashar;
    data['maghrib'] = this.maghrib;
    data['isya'] = this.isya;
    return data;
  }
}
