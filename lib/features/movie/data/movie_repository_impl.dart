// movie_repository_impl.dart: Film verilerini sağlayan repository implementasyonu.
// Sahte (mock) film verisi üretir.

import '../domain/movie_entity.dart'; // Doğru model importu
import '../domain/movie_repository.dart';

// MovieRepositoryImpl: Film verilerini sağlayan repository.
class MovieRepositoryImpl implements MovieRepository {
  @override
  Future<List<MovieEntity>> fetchMovies(int offset, int limit) async {
    // Burada sahte film verisi üretiliyor.
    await Future.delayed(const Duration(seconds: 1));
    final sampleTitles = [
      'loveAndAdventure',
      'midnight',
      'lostCity',
      'lastJourney',
      'secretGarden',
      'brokenDreams',
      'underTheStars',
      'lightInTheDark',
      'onceUponATime',
      'colorsOfLife',
    ]; // Film başlıkları
    final sampleSubtitles = [
      'dramaRomance',
      'thrillerMystery',
      'adventureFantasy',
      'scienceFiction',
      'familyComedy',
      'actionCrime',
      'animation',
      'documentary',
      'horror',
      'history',
    ]; // Film alt başlıkları

    // Film sayısı kadar otomatik oluştur
    final movies = List.generate(limit, (i) {
      final filmNo = offset + i + 1;
      final title = sampleTitles[i % sampleTitles.length];
      final subtitle = sampleSubtitles[i % sampleSubtitles.length];
      final imagePath = 'assets/movie${(filmNo % 5 == 0 ? 5 : filmNo % 5)}.jpg'; // 1-5 arası döner

      return MovieEntity(
        filmNo: filmNo,
        title: title, // Sadece anahtar!
        subtitle: subtitle,
        imagePath: imagePath,
      );
    });

    return movies;
  }
}
