part of 'inventaris_masjid_cubit.dart';

abstract class InventarisMasjidState extends Equatable {
  const InventarisMasjidState();
  @override
  List<Object> get props => [];
}

class InventarisMasjidInitial extends InventarisMasjidState {}
class InventarisMasjidLoading extends InventarisMasjidState {}
class InventarisMasjidLoaded extends InventarisMasjidState {}
class InventarisMasjidFailure extends InventarisMasjidState {
  final String? message;

  InventarisMasjidFailure(this.message);
}
