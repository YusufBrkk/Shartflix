import 'package:equatable/equatable.dart';
import '../../domain/movie_entity.dart';

// movie_state.dart: Film Bloc'unun state'ini tanımlar.
// Film listesi, loading durumu gibi bilgiler burada tutulur.

class MovieState extends Equatable {
  final List<MovieEntity> movies;
  final bool isLoading;

  const MovieState({
    this.movies = const [],
    this.isLoading = false,
  });

  MovieState copyWith({
    List<MovieEntity>? movies,
    bool? isLoading,
  }) {
    return MovieState(
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [movies, isLoading];
}
