import 'movie_entity.dart';

// movie_repository.dart: Film verisi sağlayıcı interface.
// Gerçek veya sahte repository implementasyonları bu interface'i kullanır.

abstract class MovieRepository {
  Future<List<MovieEntity>> fetchMovies(int offset, int limit);
}
