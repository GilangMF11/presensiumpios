// To parse this JSON data, do
//
//     final modelLogin = modelLoginFromJson(jsonString);

import 'dart:convert';

ModelLogin modelLoginFromJson(String str) =>
    ModelLogin.fromJson(json.decode(str));

String modelLoginToJson(ModelLogin data) => json.encode(data.toJson());

class ModelLogin {
  ModelLogin({
    this.status,
    this.message,
    this.token,
    this.data,
  });

  bool? status;
  String? message;
  String? token;
  Data? data;

  factory ModelLogin.fromJson(Map<String, dynamic> json) => ModelLogin(
        status: json["status"],
        message: json["message"],
        token: json["token"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.username,
    this.nama,
  });

  String? username;
  String? nama;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        username: json["username"],
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "nama": nama,
      };
}
