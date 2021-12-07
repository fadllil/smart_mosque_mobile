import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/models/pengeluaran_model.dart';
import 'package:smart_mosque/service/keuangan_service.dart';

part 'pengeluaran_masjid_state.dart';

@injectable
class PengeluaranMasjidCubit extends Cubit<PengeluaranMasjidState> {
  final KeuanganService keuanganService;
  PengeluaranMasjidCubit(this.keuanganService) : super(PengeluaranMasjidInitial());
  PengeluaranModel? model;
  late List<Result> data;

  Future init(int id) async {
    try {
      emit(PengeluaranMasjidLoading());
      model = await keuanganService.getPengeluaran(id.toString());
      emit(PengeluaranMasjidLoaded());
    } catch (e) {
      emit(PengeluaranMasjidFailure(e.toString()));
    }
  }

}
