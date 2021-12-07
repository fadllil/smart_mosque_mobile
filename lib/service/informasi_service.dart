import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/models/informasi_jamaah_model.dart';
import 'package:smart_mosque/models/informasi_model.dart';
import 'package:smart_mosque/service/http_service.dart';

@lazySingleton
class InformasiService extends HttpService {
  Future getInformasi(String id) async {
    Response response = await get('/masjid/informasi/$id');
    InformasiModel informasiModel = informasiModelFromJson(
        jsonEncode(response.data));
    return informasiModel;
  }

  Future createInformasi(Map data) async{
    await post('/masjid/informasi/create', data);
  }

  Future updateInformasi(Map data) async{
    await post('/masjid/informasi/update', data);
  }

  Future deleteInformasi(String id) async{
    await get('/masjid/informasi/delete/$id');
  }

  Future getAllInformasi() async {
    Response response = await get('/jamaah/informasi');
    InformasiJamaahModel informasiJamaahModel = informasiJamaahModelFromJson(
        jsonEncode(response.data));
    return informasiJamaahModel;
  }

  Future getInformasiJamaah(String id) async {
    Response response = await get('/jamaah/informasi/$id');
    InformasiJamaahModel informasiJamaahModel = informasiJamaahModelFromJson(
        jsonEncode(response.data));
    return informasiJamaahModel;
  }
}