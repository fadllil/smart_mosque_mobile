import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/models/detail_anggota_model.dart';
import 'package:smart_mosque/models/detail_iuran_model.dart';
import 'package:smart_mosque/models/kegiatan_model.dart';
import 'package:smart_mosque/service/http_service.dart';

@lazySingleton
class KegiatanService extends HttpService{
  Future getKegiatan(String id, String status) async{
    Response response = await get('/masjid/kegiatan/$id?status=$status');
    KegiatanModel kegiatanModel = kegiatanModelFromJson(jsonEncode(response.data));
    return kegiatanModel;
  }

  Future createKegiatan(Map data) async{
    await post('/masjid/kegiatan/create', data);
  }

  Future updateKegiatan(Map data) async{
    await post('/masjid/kegiatan/update', data);
  }

  Future deleteKegiatan(String id) async{
    await get('/masjid/kegiatan/delete/$id');
  }

  Future getDetailAnggota(String id) async{
    Response response = await get('/masjid/kegiatan/detail-anggota/$id');
    DetailAnggotaModel detailAnggotaModel = detailAnggotaModelFromJson(jsonEncode(response.data));
    return detailAnggotaModel;
  }

  Future getDetailIuran(String id) async{
    Response response = await get('/masjid/kegiatan/detail-iuran/$id');
    DetailIuranModel detailIuranModel = detailIuranModelFromJson(jsonEncode(response.data));
    return detailIuranModel;
  }
}