import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/models/inventaris_model.dart';
import 'package:smart_mosque/service/inventaris_service.dart';

part 'inventaris_masjid_state.dart';

@injectable
class InventarisMasjidCubit extends Cubit<InventarisMasjidState> {
  final InventarisService inventarisService;
  InventarisMasjidCubit(this.inventarisService) : super(InventarisMasjidInitial());
  InventarisModel? model;
  late List<Result> data;

  Future init(int id) async {
    try {
      emit(InventarisMasjidLoading());
      model = await inventarisService.getInventaris(id.toString());
      emit(InventarisMasjidLoaded());
    } catch (e) {
      emit(InventarisMasjidFailure(e.toString()));
    }
  }
}
