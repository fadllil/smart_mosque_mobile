import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/models/profil_jamaah_model.dart';
import 'package:smart_mosque/models/profil_model.dart';
import 'package:smart_mosque/service/http_service.dart';

@lazySingleton
class ProfilService extends HttpService{
  Future getProfil(String id) async{
    Response response = await get('/masjid/profil/$id');
    ProfilModel profilModel = ProfilModel.fromJson(response.data);
    return profilModel;
  }

  Future updateProfil(Map data)async{
    await post('/masjid/profil/update', data);
  }

  Future getProfilJamaah(String id) async{
    Response response = await get('/jamaah/profil/$id');
    ProfilJamaahModel profilJamaahModel = profilJamaahModelFromJson(jsonEncode(response.data));
    return profilJamaahModel;
  }

  Future updateProfilJamaah(Map data)async{
    await post('/jamaah/profil/update', data);
  }
}