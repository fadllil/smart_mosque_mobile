import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/models/inventaris_model.dart';
import 'package:smart_mosque/service/inventaris_service.dart';
import 'package:smart_mosque/utils/preference_helper.dart';

part 'inventaris_state.dart';

@injectable
class InventarisCubit extends Cubit<InventarisState> {
  final InventarisService inventarisService;
  InventarisCubit(this.inventarisService) : super(InventarisInitial());
  InventarisModel? model;
  late List<Result> data;
  String? id_masjid;
  Future init() async {
    try {
      emit(InventarisLoading());
      this.id_masjid = await locator<PreferencesHelper>().getValue('id_masjid');
      if (this.id_masjid != null) {
        model = await inventarisService.getInventaris(id_masjid ?? '');
      }
      emit(InventarisLoaded());
    } catch (e) {
      emit(InventarisFailure(e.toString()));
    }
  }

  Future createInventaris(Map data) async {
    this.id_masjid = await locator<PreferencesHelper>().getValue('id_masjid');
    data['id_masjid'] = id_masjid;
    final currentState = state;
    if(state is InventarisLoaded){
      try{
        emit(InventarisCreating());
        await inventarisService.createInventaris(data);
        emit(InventarisCreated());
        emit(currentState);
      }catch (e){
        emit(InventarisError(e.toString()));
        emit(currentState);
      }
    }
  }

  Future updateInventaris(Map data) async {
    final currentState = state;
    if (state is InventarisLoaded){
      try{
        emit(InventarisUpdating());
        await inventarisService.updateInventaris(data);
        emit(InventarisUpdated());
        emit(currentState);
      } catch (e){
        emit(InventarisError(e.toString()));
        emit(currentState);
      }
    }
  }

  Future deleteInventaris(String _id) async {
    final currentState = state;
    if (state is InventarisLoaded){
      try{
        emit(InventarisDeleting());
        await inventarisService.deleteInventaris(_id);
        emit(InventarisDeleted());
        emit(currentState);
      }catch (e){
        emit(InventarisError(e.toString()));
        emit(currentState);
      }
    }
  }
}