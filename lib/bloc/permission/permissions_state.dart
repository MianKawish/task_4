part of 'permissions_bloc.dart';

sealed class PermissionsState extends Equatable {
  const PermissionsState();
}

final class PermissionsInitial extends PermissionsState {
  @override
  List<Object> get props => [];
}
