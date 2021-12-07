part of 'kegiatan_masjid_cubit.dart';

abstract class KegiatanMasjidState extends Equatable {
  const KegiatanMasjidState();
  @override
  List<Object> get props => [];
}

class KegiatanMasjidInitial extends KegiatanMasjidState {}
class KegiatanMasjidLoading extends KegiatanMasjidState {}
class KegiatanMasjidLoaded extends KegiatanMasjidState {}
class KegiatanMasjidFailure extends KegiatanMasjidState {
  final String? message;

  KegiatanMasjidFailure(this.message);
}
