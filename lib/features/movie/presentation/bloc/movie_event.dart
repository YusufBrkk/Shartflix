// movie_event.dart: Film ile ilgili Bloc event'lerini tanımlar.
// Örn: LoadMovies, RefreshMovies, ToggleFavorite

import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
  @override
  List<Object?> get props => [];
}

class LoadMovies extends MovieEvent {}
class RefreshMovies extends MovieEvent {}
class ToggleFavorite extends MovieEvent {
  final int filmNo;
  const ToggleFavorite(this.filmNo);
  @override
  List<Object?> get props => [filmNo];
}
