import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/models/informasi_jamaah_model.dart';
import 'package:smart_mosque/service/informasi_service.dart';
import 'package:smart_mosque/utils/preference_helper.dart';

part 'informasi_jamaah_state.dart';

@injectable
class InformasiJamaahCubit extends Cubit<InformasiJamaahState> {
  final InformasiService informasiService;
  InformasiJamaahCubit(this.informasiService) : super(InformasiJamaahInitial());
  InformasiJamaahModel? model;
  late List<Result> data;
  String? id;

  Future semua() async {
    try{
      emit(InformasiJamaahLoading());
      model = await informasiService.getAllInformasi();
      emit(InformasiJamaahLoaded());
    }catch (e){
      emit(InformasiJamaahFailure(e.toString()));
    }
  }

  Future diikuti() async {
    try{
      emit(InformasiJamaahLoading());
      this.id = await locator<PreferencesHelper>().getValue('id');
      if(this.id!=null){
        model = await informasiService.getInformasiJamaah(id ?? '');
      }
      emit(InformasiJamaahLoaded());
    }catch (e){
      emit(InformasiJamaahFailure(e.toString()));
    }
  }
}
