part of 'detail_jadwal_masjid_cubit.dart';

abstract class DetailJadwalMasjidState extends Equatable {
  const DetailJadwalMasjidState();
  @override
  List<Object> get props => [];
}

class DetailJadwalMasjidInitial extends DetailJadwalMasjidState {}
class DetailJadwalMasjidLoading extends DetailJadwalMasjidState {}
class DetailJadwalMasjidLoaded extends DetailJadwalMasjidState {}
class DetailJadwalMasjidFailure extends DetailJadwalMasjidState {
  final String? message;

  DetailJadwalMasjidFailure(this.message);
}
