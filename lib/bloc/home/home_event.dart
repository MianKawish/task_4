part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

class VideoScreenEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class AudioScreenEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class ImagesScreenEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class HomeScreenEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}
