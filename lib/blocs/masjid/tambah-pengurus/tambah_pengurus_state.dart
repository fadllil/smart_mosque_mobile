part of 'tambah_pengurus_cubit.dart';

abstract class TambahPengurusState extends Equatable {
  const TambahPengurusState();

  @override
  List<Object> get props => [];
}

class TambahPengurusInitial extends TambahPengurusState {}
class TambahPengurusLoading extends TambahPengurusState {}
class TambahPengurusLoaded extends TambahPengurusState {}

class TambahPengurusFailure extends TambahPengurusState {
  final String? message;
  TambahPengurusFailure(this.message);
}

class TambahPengurusCreating extends TambahPengurusState {}
class TambahPengurusCreated extends TambahPengurusState {}
class TambahPengurusError extends TambahPengurusState {
  final String message;
  TambahPengurusError(this.message);
}
