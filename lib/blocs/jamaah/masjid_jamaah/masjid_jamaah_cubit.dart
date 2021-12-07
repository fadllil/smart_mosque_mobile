import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/models/masjid_list_model.dart';
import 'package:smart_mosque/service/masjid_service.dart';
import 'package:smart_mosque/utils/preference_helper.dart';

part 'masjid_jamaah_state.dart';

@injectable
class MasjidJamaahCubit extends Cubit<MasjidJamaahState> {
  final MasjidService masjidService;
  MasjidJamaahCubit(this.masjidService) : super(MasjidJamaahInitial());
  MasjidListModel? model;
  late List<Result> data;
  String? id;
  Future semua() async{
    try{
      emit(MasjidJamaahLoading());
      model = await masjidService.getAllMasjid();
      emit(MasjidJamaahLoaded());
    }catch (e){
      emit(MasjidJamaahFailure(e.toString()));
    }
  }

  Future diikuti() async{
    try{
      emit(MasjidJamaahLoading());
      this.id = await locator<PreferencesHelper>().getValue('id');
      model = await masjidService.getMasjidDiikuti(id!);
      emit(MasjidJamaahLoaded());
    }catch (e){
      emit(MasjidJamaahFailure(e.toString()));
    }
  }
}
