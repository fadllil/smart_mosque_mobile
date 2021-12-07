// To parse this JSON data, do
//
//     final profilJamaahModel = profilJamaahModelFromJson(jsonString);

import 'dart:convert';

ProfilJamaahModel profilJamaahModelFromJson(String str) => ProfilJamaahModel.fromJson(json.decode(str));

class ProfilJamaahModel {
  ProfilJamaahModel({
    this.message,
    this.results,
    this.code,
  });

  String? message;
  Results? results;
  int? code;

  factory ProfilJamaahModel.fromJson(Map<String, dynamic> json) => ProfilJamaahModel(
    message: json["message"],
    results: Results.fromJson(json["results"]),
    code: json["code"],
  );
}

class Results {
  Results({
    this.id,
    this.nama,
    this.email,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.jamaah,
  });

  int? id;
  String? nama;
  String? email;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  Jamaah? jamaah;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    id: json["id"],
    nama: json["nama"],
    email: json["email"],
    role: json["role"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    jamaah: Jamaah.fromJson(json["jamaah"]),
  );
}

class Jamaah {
  Jamaah({
    this.id,
    this.idUser,
    this.noHp,
    this.alamat,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? idUser;
  String? noHp;
  String? alamat;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Jamaah.fromJson(Map<String, dynamic> json) => Jamaah(
    id: json["id"],
    idUser: json["id_user"],
    noHp: json["no_hp"],
    alamat: json["alamat"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}
