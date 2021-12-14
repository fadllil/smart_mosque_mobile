import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/models/kegiatan_model.dart';
import 'package:smart_mosque/service/kegiatan_service.dart';

part 'kegiatan_masjid_state.dart';

@injectable
class KegiatanMasjidCubit extends Cubit<KegiatanMasjidState> {
  final KegiatanService kegiatanService;
  KegiatanMasjidCubit(this.kegiatanService) : super(KegiatanMasjidInitial());
  KegiatanModel? model;
  late List<Result> data;
  String? id_masjid;

  Future init(int id) async {
    try{
      emit(KegiatanMasjidLoading());
      model = await kegiatanService.getKegiatan(id.toString(), 'Belum Terlaksana');
      emit(KegiatanMasjidLoaded());
    }catch (e){
      emit(KegiatanMasjidFailure(e.toString()));
    }
  }
}
