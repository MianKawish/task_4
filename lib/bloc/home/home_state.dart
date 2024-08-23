part of 'home_bloc.dart';

enum PageToDisplay { home, video, audio, image }

class HomeState extends Equatable {
  final PageToDisplay status;
  const HomeState({this.status = PageToDisplay.home});
  HomeState copyWith({PageToDisplay? status}) {
    return HomeState(status: status ?? this.status);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status];
}
