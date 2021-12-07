import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/models/detail_jadwal_imam_model.dart';
import 'package:smart_mosque/models/jadwal_imam_model.dart';

import 'http_service.dart';

@lazySingleton
class JadwalImamService extends HttpService{
  Future getJadwalImam(String id) async{
    Response response = await get('/masjid/jadwal-imam/$id');
    JadwalImamModel jadwalImamModel = jadwalImamModelFromJson(jsonEncode(response.data));
    return jadwalImamModel;
  }

  Future createJadwalImam(Map data) async{
    await post('/masjid/jadwal-imam/create', data);
  }

  Future updateJadwalImam(Map data) async{
    await post('/masjid/jadwal-imam/update', data);
  }

  Future deleteJadwalImam(String id) async{
    await get('/masjid/jadwal-imam/delete/$id');
  }

  Future getDetailJadwalImam(String id) async{
    Response response = await get('/masjid/jadwal-imam/detail/$id');
    DetailJadwalImamModel detailJadwalImamModel = detailJadwalImamModelFromJson(jsonEncode(response.data));
    return detailJadwalImamModel;
  }

  Future createDetailJadwalImam(Map data) async{
    await post('/masjid/jadwal-imam/detail/create', data);
  }

  Future updateDetailJadwalImam(Map data) async{
    await post('/masjid/jadwal-imam/detail/update', data);
  }

  Future deleteDetailJadwalImam(String id) async{
    await get('/masjid/jadwal-imam/detail/delete/$id');
  }
}