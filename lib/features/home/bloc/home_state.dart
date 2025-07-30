import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final List<String> movies;
  final Set<String> favorites;
  final bool isLoading;

  const HomeState({
    this.movies = const [],
    this.favorites = const {},
    this.isLoading = false,
  });

  HomeState copyWith({
    List<String>? movies,
    Set<String>? favorites,
    bool? isLoading,
  }) {
    return HomeState(
      movies: movies ?? this.movies,
      favorites: favorites ?? this.favorites,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [movies, favorites, isLoading];
}
