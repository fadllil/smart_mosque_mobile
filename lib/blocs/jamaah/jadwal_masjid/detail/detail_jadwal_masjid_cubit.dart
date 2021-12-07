import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/models/detail_jadwal_imam_model.dart';
import 'package:smart_mosque/service/jadwal_imam_service.dart';

part 'detail_jadwal_masjid_state.dart';

@injectable
class DetailJadwalMasjidCubit extends Cubit<DetailJadwalMasjidState> {
  final JadwalImamService jadwalImamService;
  DetailJadwalMasjidCubit(this.jadwalImamService) : super(DetailJadwalMasjidInitial());
  DetailJadwalImamModel? model;
  late List<Result> data;

  Future init(int id) async{
    try{
      emit(DetailJadwalMasjidLoading());
      model = await jadwalImamService.getDetailJadwalImam(id.toString());
      emit(DetailJadwalMasjidLoaded());
    }catch (e){
      emit(DetailJadwalMasjidFailure(e.toString()));
    }
  }
}
