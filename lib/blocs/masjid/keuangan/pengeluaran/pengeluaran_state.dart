part of 'pengeluaran_cubit.dart';

abstract class PengeluaranState extends Equatable {
  const PengeluaranState();
  @override
  List<Object> get props => [];
}

class PengeluaranInitial extends PengeluaranState {}
class PengeluaranLoading extends PengeluaranState {}
class PengeluaranLoaded extends PengeluaranState {}
class PengeluaranFailure extends PengeluaranState {
  final String? message;

  PengeluaranFailure(this.message);
}

class PengeluaranCreating extends PengeluaranState {}
class PengeluaranCreated extends PengeluaranState {}
class PengeluaranUpdating extends PengeluaranState {}
class PengeluaranUpdated extends PengeluaranState {}
class PengeluaranDeleting extends PengeluaranState {}
class PengeluaranDeleted extends PengeluaranState {}
class PengeluaranError extends PengeluaranState {
  final String? message;

  PengeluaranError(this.message);
}