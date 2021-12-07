import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/models/informasi_model.dart';
import 'package:smart_mosque/service/informasi_service.dart';

part 'informasi_masjid_state.dart';

@injectable
class InformasiMasjidCubit extends Cubit<InformasiMasjidState> {
  final InformasiService informasiService;
  InformasiMasjidCubit(this.informasiService) : super(InformasiMasjidInitial());
  InformasiModel? model;
  late List<Result> data;
  String? id_masjid;

  Future init(int? id) async {
    try{
      emit(InformasiMasjidLoading());
      model = await informasiService.getInformasi(id.toString());
      emit(InformasiMasjidLoaded());
    }catch (e){
      emit(InformasiMasjidFailure(e.toString()));
    }
  }
}
