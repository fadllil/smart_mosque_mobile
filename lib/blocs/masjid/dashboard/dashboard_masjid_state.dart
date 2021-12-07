part of 'dashboard_masjid_cubit.dart';

abstract class DashboardMasjidState extends Equatable {
  const DashboardMasjidState();
  @override
  List<Object> get props => [];
}

class DashboardMasjidInitial extends DashboardMasjidState {}
class DashboardMasjidLoading extends DashboardMasjidState {}
class DashboardMasjidLoaded extends DashboardMasjidState {
  final String? nama;
  DashboardMasjidLoaded(
  {this.nama});
}

class DashboardMasjidFailure extends DashboardMasjidState{
  final String? message;
  DashboardMasjidFailure(this.message);
}
