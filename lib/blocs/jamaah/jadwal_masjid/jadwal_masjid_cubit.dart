import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/models/jadwal_imam_model.dart';
import 'package:smart_mosque/service/jadwal_imam_service.dart';

part 'jadwal_masjid_state.dart';

@injectable
class JadwalMasjidCubit extends Cubit<JadwalMasjidState> {
  final JadwalImamService jadwalImamService;
  JadwalMasjidCubit(this.jadwalImamService) : super(JadwalMasjidInitial());
  JadwalImamModel? model;
  late List<Result> data;

  Future init(int id) async{
    try{
      emit(JadwalMasjidLoading());
      model = await jadwalImamService.getJadwalImam(id.toString());
      emit(JadwalMasjidLoaded());
    }catch (e){
      emit(JadwalMasjidFailure(e.toString()));
    }
  }
}
