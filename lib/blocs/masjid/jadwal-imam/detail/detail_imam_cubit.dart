import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/models/detail_jadwal_imam_model.dart';
import 'package:smart_mosque/service/jadwal_imam_service.dart';
import 'package:smart_mosque/utils/preference_helper.dart';

part 'detail_imam_state.dart';

@injectable
class DetailImamCubit extends Cubit<DetailImamState> {
  final JadwalImamService jadwalImamService;
  DetailImamCubit(this.jadwalImamService) : super(DetailImamInitial());
  DetailJadwalImamModel? model;
  late List<Result> data;
  String? id_masjid;

  Future init(int id) async {
    // print('test nilai id'+id.toString());
    try{
      emit(DetailImamLoading());
      this.id_masjid = await locator<PreferencesHelper>().getValue('id_masjid');
      if(this.id_masjid!=null){
        model = await jadwalImamService.getDetailJadwalImam(id.toString());
      }
      emit(DetailImamLoaded(idDetail:id));
    }catch (e){
      emit(DetailImamFailure(e.toString()));
    }
  }

  Future createJadwalImam(Map data) async {
    final currentState = state;
    if (state is DetailImamLoaded){
      try{
        emit(DetailImamLoading());
        await jadwalImamService.createDetailJadwalImam(data);
        emit(DetailImamCreated());
        emit(currentState);
      } catch (e){
        emit(DetailImamError(e.toString()));
        emit(currentState);
      }
    }
  }

  Future updateJadwalImam(Map data) async {
    final currentState = state;
    if(state is DetailImamLoaded){
      try{
        emit(DetailImamUpdating());
        await jadwalImamService.updateDetailJadwalImam(data);
        emit(DetailImamUpdated());
        emit(currentState);
      }catch (e){
        emit(DetailImamError(e.toString()));
        emit(currentState);
      }
    }
  }

  Future deleteJadwalImam(String _id) async {
    final currentState = state;
    try{
      emit(DetailImamDeleting());
      await jadwalImamService.deleteDetailJadwalImam(_id);
      emit(DetailImamDeleted());
      emit(currentState);
    }catch (e){
      emit(DetailImamError(e.toString()));
      emit(currentState);
    }
  }
}
