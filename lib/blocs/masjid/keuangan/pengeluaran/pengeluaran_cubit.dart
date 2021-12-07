import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/models/pengeluaran_model.dart';
import 'package:smart_mosque/service/keuangan_service.dart';
import 'package:smart_mosque/utils/preference_helper.dart';

part 'pengeluaran_state.dart';

@injectable
class PengeluaranCubit extends Cubit<PengeluaranState> {
  final KeuanganService keuanganService;
  PengeluaranCubit(this.keuanganService) : super(PengeluaranInitial());
  PengeluaranModel? model;
  late List<Result> data;
  String? id_masjid;
  Future init() async {
    try {
      emit(PengeluaranLoading());
      this.id_masjid = await locator<PreferencesHelper>().getValue('id_masjid');
      if (this.id_masjid != null) {
        model = await keuanganService.getPengeluaran(id_masjid ?? '');
      }
      emit(PengeluaranLoaded());
    } catch (e) {
      emit(PengeluaranFailure(e.toString()));
    }
  }

  Future createPengeluaran(Map data) async {
    this.id_masjid = await locator<PreferencesHelper>().getValue('id_masjid');
    data['id_masjid'] = id_masjid;
    final currentState = state;
    if(state is PengeluaranLoaded){
      try{
        emit(PengeluaranCreating());
        await keuanganService.createPengeluaran(data);
        emit(PengeluaranCreated());
        emit(currentState);
      }catch (e){
        emit(PengeluaranError(e.toString()));
        emit(currentState);
      }
    }
  }

  Future updatePengeluaran(Map data) async {
    final currentState = state;
    if (state is PengeluaranLoaded){
      try{
        emit(PengeluaranUpdating());
        await keuanganService.updatePengeluaran(data);
        emit(PengeluaranUpdated());
        emit(currentState);
      } catch (e){
        emit(PengeluaranError(e.toString()));
        emit(currentState);
      }
    }
  }
}
