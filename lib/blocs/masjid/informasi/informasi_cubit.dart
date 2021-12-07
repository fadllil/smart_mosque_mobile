import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/models/informasi_model.dart';
import 'package:smart_mosque/service/informasi_service.dart';
import 'package:smart_mosque/utils/preference_helper.dart';

part 'informasi_state.dart';

@injectable
class InformasiCubit extends Cubit<InformasiState> {
  final InformasiService informasiService;
  InformasiCubit(this.informasiService) : super(InformasiInitial());
  InformasiModel? model;
  late List<Result> data;
  String? id_masjid;

  Future init() async {
    try{
      emit(InformasiLoading());
      this.id_masjid = await locator<PreferencesHelper>().getValue('id_masjid');
      if(this.id_masjid!=null){
        model = await informasiService.getInformasi(id_masjid ?? '');
      }
      emit(InformasiLoaded());
    }catch (e){
      emit(InformasiFailure(e.toString()));
    }
  }

  Future createInformasi(Map data) async {
    this.id_masjid = await locator<PreferencesHelper>().getValue('id_masjid');
    data['id_masjid'] = id_masjid;
    final currentState = state;
    if (state is InformasiLoaded){
      try{
        emit(InformasiCreating());
        await informasiService.createInformasi(data);
        emit(InformasiCreated());
        emit(currentState);
      } catch (e){
        emit(InformasiError(e.toString()));
        emit(currentState);
      }
    }
  }

  Future updateInformasi(Map data) async {
    final currentState = state;
    if (state is InformasiLoaded){
      try{
        emit(InformasiUpdating());
        await informasiService.updateInformasi(data);
        emit(InformasiUpdated());
        emit(currentState);
      } catch (e){
        emit(InformasiError(e.toString()));
        emit(currentState);
      }
    }
  }

  Future deleteInformasi(String _id) async {
    final currentState = state;
    if (state is InformasiLoaded){
      try{
        emit(InformasiDeleting());
        await informasiService.deleteInformasi(_id);
        emit(InformasiDeleted());
        emit(currentState);
      }catch (e){
        emit(InformasiError(e.toString()));
        emit(currentState);
      }
    }
  }
}
