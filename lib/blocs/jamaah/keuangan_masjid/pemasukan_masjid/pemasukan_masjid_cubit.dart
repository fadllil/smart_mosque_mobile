import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/models/pemasukan_model.dart';
import 'package:smart_mosque/service/keuangan_service.dart';

part 'pemasukan_masjid_state.dart';

@injectable
class PemasukanMasjidCubit extends Cubit<PemasukanMasjidState> {
  final KeuanganService keuanganService;
  PemasukanMasjidCubit(this.keuanganService) : super(PemasukanMasjidInitial());
  PemasukanModel? model;
  late List<Result> data;

  Future init(int id) async {
    try {
      emit(PemasukanMasjidLoading());
      model = await keuanganService.getPemasukan(id.toString());
      emit(PemasukanMasjidLoaded());
    } catch (e) {
      emit(PemasukanMasjidFailure(e.toString()));
    }
  }
}
