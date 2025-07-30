import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

class LoadMovies extends HomeEvent {}
class RefreshMovies extends HomeEvent {}
class ToggleFavorite extends HomeEvent {
  final String movie;
  const ToggleFavorite(this.movie);
  @override
  List<Object?> get props => [movie];
}
