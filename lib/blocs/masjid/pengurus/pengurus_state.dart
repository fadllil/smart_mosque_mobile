part of 'pengurus_cubit.dart';

abstract class PengurusState extends Equatable {
  const PengurusState();

  @override
  List<Object> get props => [];
}

class PengurusInitial extends PengurusState {}
class PengurusLoading extends PengurusState {}
class PengurusLoaded extends PengurusState {}
class PengurusFailure extends PengurusState {
  final String? message;

  PengurusFailure(this.message);
}

class PengurusCreating extends PengurusState {}
class PengurusCreated extends PengurusState {}
class PengurusDeleting extends PengurusState {}
class PengurusDeleted extends PengurusState {}
class PengurusError extends PengurusState{
  final String? message;

  PengurusError(this.message);
}
