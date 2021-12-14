part of 'kegiatan_anggota_cubit.dart';

abstract class KegiatanAnggotaState extends Equatable {
  const KegiatanAnggotaState();
  @override
  List<Object> get props => [];
}

class KegiatanAnggotaInitial extends KegiatanAnggotaState {}
class KegiatanAnggotaLoading extends KegiatanAnggotaState {}
class KegiatanAnggotaLoaded extends KegiatanAnggotaState {}
class KegiatanAnggotaFailure extends KegiatanAnggotaState {
  final String message;
  KegiatanAnggotaFailure(this.message);
}

class KegiatanAnggotaUpdating extends KegiatanAnggotaState {}
class KegiatanAnggotaUpdated extends KegiatanAnggotaState {}
class KegiatanAnggotaError extends KegiatanAnggotaState {
  final String message;
  KegiatanAnggotaError(this.message);
}