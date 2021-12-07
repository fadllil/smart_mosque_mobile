import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/models/jadwal_imam_model.dart';
import 'package:smart_mosque/service/jadwal_imam_service.dart';
import 'package:smart_mosque/utils/preference_helper.dart';

part 'jadwal_imam_state.dart';

@injectable
class JadwalImamCubit extends Cubit<JadwalImamState> {
  final JadwalImamService jadwalImamService;
  JadwalImamCubit(this.jadwalImamService) : super(JadwalImamInitial());
  JadwalImamModel? model;
  late List<Result> data;
  String? id_masjid;

  Future init() async{
    try{
      emit(JadwalImamLoading());
      this.id_masjid = await locator<PreferencesHelper>().getValue('id_masjid');
      if (this.id_masjid!=null){
        model = await jadwalImamService.getJadwalImam(id_masjid ?? '');
      }
      emit(JadwalImamLoaded());
    }catch (e){
      emit(JadwalImamFailure(e.toString()));
    }
  }

  Future createJadwal(String hari) async {
    final currentState = state;
    if (state is JadwalImamLoaded){
      try{
        emit(JadwalImamCreating());
        await jadwalImamService.createJadwalImam({
          'id_masjid' : this.id_masjid,
          'hari' : hari
        });
        emit(JadwalImamCreated());
        emit(currentState);
      }catch (e){
        emit(JadwalImamError(e.toString()));
        emit(currentState);
      }
    }
  }

  Future updateJadwal(Map data) async {
    final currentState = state;
    if (state is JadwalImamLoaded){
      try{
        emit(JadwalImamUpdating());
        await jadwalImamService.updateJadwalImam(data);
        emit(JadwalImamUpdated());
        emit(currentState);
      }catch (e) {
        emit(JadwalImamError(e.toString()));
        emit(currentState);
      }
    }
  }

  Future deleteJadwal(String _id) async {
    final currentState = state;
    if (state is JadwalImamLoaded){
      try{
        emit(JadwalImamDeleting());
        await jadwalImamService.deleteJadwalImam(_id);
        emit(JadwalImamDeleted());
        emit(currentState);
      }catch (e) {
        emit(JadwalImamError(e.toString()));
        emit(currentState);
      }
    }
  }
}
