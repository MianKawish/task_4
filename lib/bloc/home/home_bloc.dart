import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<VideoScreenEvent>(_videoScreenEvent);
    on<AudioScreenEvent>(_audioScreenEvent);
    on<ImagesScreenEvent>(_imagesScreenEvent);
    on<HomeScreenEvent>(_homeScreenEvent);
  }

  FutureOr<void> _videoScreenEvent(
      VideoScreenEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(status: PageToDisplay.video));
  }

  FutureOr<void> _audioScreenEvent(
      AudioScreenEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(status: PageToDisplay.audio));
  }

  FutureOr<void> _imagesScreenEvent(
      ImagesScreenEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(status: PageToDisplay.image));
  }

  FutureOr<void> _homeScreenEvent(
      HomeScreenEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(status: PageToDisplay.home));
  }
}
