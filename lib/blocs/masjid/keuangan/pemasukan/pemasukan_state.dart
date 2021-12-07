part of 'pemasukan_cubit.dart';

abstract class PemasukanState extends Equatable {
  const PemasukanState();

  @override
  List<Object> get props => [];
}

class PemasukanInitial extends PemasukanState {}
class PemasukanLoading extends PemasukanState {}
class PemasukanLoaded extends PemasukanState {}
class PemasukanFailure extends PemasukanState {
  final String? message;

  PemasukanFailure(this.message);
}

class PemasukanCreating extends PemasukanState {}
class PemasukanCreated extends PemasukanState {}
class PemasukanUpdating extends PemasukanState {}
class PemasukanUpdated extends PemasukanState {}
class PemasukanError extends PemasukanState {
  final String? message;

  PemasukanError(this.message);
}
