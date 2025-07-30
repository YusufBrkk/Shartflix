import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/get_movies_usecase.dart';
import '../../domain/movie_entity.dart';
import 'movie_event.dart';
import 'movie_state.dart';

// movie_bloc.dart: Film state yönetimi için Bloc sınıfı.
// Filmleri yükleme, favori ekleme/çıkarma işlemleri burada yönetilir.

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMoviesUseCase getMoviesUseCase;
  final Set<String> _favorites = {};
  int _offset = 0;
  final int _limit = 5;

  MovieBloc(this.getMoviesUseCase) : super(const MovieState()) {
    log('MovieBloc initialized');
    on<LoadMovies>(_onLoadMovies);
    on<RefreshMovies>(_onRefreshMovies);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadMovies(LoadMovies event, Emitter<MovieState> emit) async {
    log('LoadMovies event triggered');
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true));
    final movies = await getMoviesUseCase(_offset, _limit);
    log('Loaded movies count: ${movies.length}');
    _offset += _limit;
    emit(state.copyWith(movies: List.of(state.movies)..addAll(movies), isLoading: false));
  }

  Future<void> _onRefreshMovies(RefreshMovies event, Emitter<MovieState> emit) async {
    log('RefreshMovies event triggered');
    emit(state.copyWith(isLoading: true));
    _offset = 0;
    final movies = await getMoviesUseCase(_offset, _limit);
    log('Refreshed movies count: ${movies.length}');
    _offset = _limit;
    emit(state.copyWith(movies: movies, isLoading: false));
  }

  void _onToggleFavorite(ToggleFavorite event, Emitter<MovieState> emit) {
    final updatedMovies = state.movies.map((movie) {
      if (movie.filmNo == event.filmNo) {
        final isFav = !movie.isFavorite;
        if (isFav) {
          _favorites.add(movie.filmNo.toString());
        } else {
          _favorites.remove(movie.filmNo.toString());
        }
        return movie.copyWith(isFavorite: isFav);
      }
      return movie;
    }).toList();
    emit(state.copyWith(movies: updatedMovies));
  }

  List<MovieEntity> get favorites => state.movies.where((m) => m.isFavorite).toList();
}
