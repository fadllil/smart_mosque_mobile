part of 'kegiatan_iuran_cubit.dart';

abstract class KegiatanIuranState extends Equatable {
  const KegiatanIuranState();
  @override
  List<Object> get props => [];
}

class KegiatanIuranInitial extends KegiatanIuranState {}
class KegiatanIuranLoading extends KegiatanIuranState {}
class KegiatanIuranLoaded extends KegiatanIuranState {}
class KegiatanIuranFailure extends KegiatanIuranState {
  final String message;
  KegiatanIuranFailure(this.message);
}

class KegiatanIuranCreating extends KegiatanIuranState {}
class KegiatanIuranCreated extends KegiatanIuranState {}
class KegiatanIuranUpdating extends KegiatanIuranState {}
class KegiatanIuranUpdated extends KegiatanIuranState {}
class KegiatanIuranError extends KegiatanIuranState {
  final String message;
  KegiatanIuranError(this.message);
}

