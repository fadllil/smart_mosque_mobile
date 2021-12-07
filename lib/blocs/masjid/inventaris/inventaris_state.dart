part of 'inventaris_cubit.dart';

abstract class InventarisState extends Equatable {
  const InventarisState();

  @override
  List<Object> get props => [];
}

class InventarisInitial extends InventarisState {}
class InventarisLoading extends InventarisState {}
class InventarisLoaded extends InventarisState {}
class InventarisFailure extends InventarisState {
  final String? message;

  InventarisFailure(this.message);
}

class InventarisCreating extends InventarisState {}
class InventarisCreated extends InventarisState {}
class InventarisUpdating extends InventarisState {}
class InventarisUpdated extends InventarisState {}
class InventarisDeleting extends InventarisState {}
class InventarisDeleted extends InventarisState {}
class InventarisError extends InventarisState {
  final String? message;

  InventarisError(this.message);
}