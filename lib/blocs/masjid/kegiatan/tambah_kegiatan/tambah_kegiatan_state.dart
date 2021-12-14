part of 'tambah_kegiatan_cubit.dart';

abstract class TambahKegiatanState extends Equatable {
  const TambahKegiatanState();
  @override
  List<Object> get props => [];
}

class TambahKegiatanInitial extends TambahKegiatanState {}
class TambahKegiatanLoading extends TambahKegiatanState {}
class TambahKegiatanLoaded extends TambahKegiatanState {
  final JamaahListModel? jamaah;
  TambahKegiatanLoaded({this.jamaah});
}
class TambahKegiatanFailure extends TambahKegiatanState {
  final String message;
  TambahKegiatanFailure(this.message);
}
class TambahKegiatanCreating extends TambahKegiatanState {}
class TambahKegiatanCreated extends TambahKegiatanState {}
class TambahKegiatanError extends TambahKegiatanState {
  final String message;
  TambahKegiatanError(this.message);
}