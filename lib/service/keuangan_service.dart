import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/models/pemasukan_model.dart';
import 'package:smart_mosque/models/pengeluaran_model.dart';

import 'http_service.dart';

@lazySingleton
class KeuanganService extends HttpService {
  Future getPemasukan(String id) async {
    Response response = await get('/masjid/keuangan/pemasukan/$id');
    PemasukanModel pemasukanModel = pemasukanModelFromJson(jsonEncode(response.data));
    return pemasukanModel;
  }

  Future getPengeluaran(String id) async {
    Response response = await get('/masjid/keuangan/pengeluaran/$id');
    PengeluaranModel pengeluaranModel = pengeluaranModelFromJson(jsonEncode(response.data));
    return pengeluaranModel;
  }

  Future createPemasukan(Map data) async{
    await post('/masjid/keuangan/pemasukan/create', data);
  }

  Future createPengeluaran(Map data) async{
    await post('/masjid/keuangan/pengeluaran/create', data);
  }

  Future updatePemasukan(Map data) async{
    await post('/masjid/keuangan/pemasukan/update', data);
  }

  Future updatePengeluaran(Map data) async{
    await post('/masjid/keuangan/pengeluaran/update', data);
  }
}