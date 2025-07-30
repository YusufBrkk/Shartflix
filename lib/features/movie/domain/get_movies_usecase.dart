import 'movie_entity.dart';
import 'movie_repository.dart';

// get_movies_usecase.dart: Film listesini getiren usecase katmanı.

class GetMoviesUseCase {
  final MovieRepository repository;
  GetMoviesUseCase(this.repository);

  Future<List<MovieEntity>> call(int offset, int limit) {
    return repository.fetchMovies(offset, limit);
  }
}
