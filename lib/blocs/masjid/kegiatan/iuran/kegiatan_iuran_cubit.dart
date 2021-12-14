import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/models/detail_iuran_model.dart';
import 'package:smart_mosque/service/kegiatan_service.dart';

part 'kegiatan_iuran_state.dart';

@injectable
class KegiatanIuranCubit extends Cubit<KegiatanIuranState> {
  final KegiatanService kegiatanService;
  KegiatanIuranCubit(this.kegiatanService) : super(KegiatanIuranInitial());
  DetailIuranModel? model;
  late List<Result> data;
  String? id;

  Future init(String id) async {
    try{
      emit(KegiatanIuranLoading());
      model = await kegiatanService.getDetailIuran(id.toString());
      emit(KegiatanIuranLoaded());
    }catch (e){
      emit(KegiatanIuranFailure(e.toString()));
    }
  }
}
