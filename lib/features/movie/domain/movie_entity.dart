// movie_entity.dart: Film modelini tanımlar. Her film için filmNo, başlık, alt başlık, görsel ve favori bilgisi tutulur.

class MovieEntity {
  final int filmNo;
  final String title;
  final String subtitle;
  final String imagePath;
  final bool isFavorite;

  MovieEntity({
    required this.filmNo,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    this.isFavorite = false,
  });

  MovieEntity copyWith({
    int? filmNo,
    String? title,
    String? subtitle,
    String? imagePath,
    bool? isFavorite,
  }) {
    return MovieEntity(
      filmNo: filmNo ?? this.filmNo,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      imagePath: imagePath ?? this.imagePath,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
