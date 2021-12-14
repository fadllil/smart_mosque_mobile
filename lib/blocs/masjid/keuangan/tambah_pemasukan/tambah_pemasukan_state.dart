part of 'tambah_pemasukan_cubit.dart';

abstract class TambahPemasukanState extends Equatable {
  const TambahPemasukanState();
  @override
  List<Object> get props => [];
}

class TambahPemasukanInitial extends TambahPemasukanState {}
class TambahPemasukanLoading extends TambahPemasukanState {}
class TambahPemasukanLoaded extends TambahPemasukanState {
  final JamaahListModel? jamaah;
  TambahPemasukanLoaded({this.jamaah});
}
class TambahPemasukanFailure extends TambahPemasukanState {
  final String message;
  TambahPemasukanFailure(this.message);
}
class TambahPemasukanCreating extends TambahPemasukanState {}
class TambahPemasukanCreated extends TambahPemasukanState {}
class TambahPemasukanError extends TambahPemasukanState {
  final String message;
  TambahPemasukanError(this.message);
}
