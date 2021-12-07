import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/models/pemasukan_model.dart';
import 'package:smart_mosque/service/keuangan_service.dart';
import 'package:smart_mosque/utils/preference_helper.dart';

part 'pemasukan_state.dart';

@injectable
class PemasukanCubit extends Cubit<PemasukanState> {
  final KeuanganService keuanganService;
  PemasukanCubit(this.keuanganService) : super(PemasukanInitial());
  PemasukanModel? model;
  late List<Result> data;
  String? id_masjid;
  Future init() async {
    try {
      emit(PemasukanLoading());
      this.id_masjid = await locator<PreferencesHelper>().getValue('id_masjid');
      if (this.id_masjid != null) {
        model = await keuanganService.getPemasukan(id_masjid ?? '');
      }
      emit(PemasukanLoaded());
    } catch (e) {
      emit(PemasukanFailure(e.toString()));
    }
  }

  Future createPemasukan(Map data) async {
    this.id_masjid = await locator<PreferencesHelper>().getValue('id_masjid');
    data['id_masjid'] = id_masjid;
    final currentState = state;
    if(state is PemasukanLoaded){
      try{
        emit(PemasukanCreating());
        await keuanganService.createPemasukan(data);
        emit(PemasukanCreated());
        emit(currentState);
      }catch (e){
        emit(PemasukanError(e.toString()));
        emit(currentState);
      }
    }
  }

  Future updatePemasukan(Map data) async {
    final currentState = state;
    if (state is PemasukanLoaded){
      try{
        emit(PemasukanUpdating());
        await keuanganService.updatePemasukan(data);
        emit(PemasukanUpdated());
        emit(currentState);
      } catch (e){
        emit(PemasukanError(e.toString()));
        emit(currentState);
      }
    }
  }
}
