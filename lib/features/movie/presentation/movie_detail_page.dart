import '../../auth/profile_page.dart';
import '../../../l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../movie/presentation/bloc/movie_bloc.dart';
import '../../movie/presentation/bloc/movie_event.dart';
import '../../movie/presentation/bloc/movie_state.dart';
import '../domain/movie_entity.dart';
import 'localized_subtitle.dart';

// movie_detail_page.dart: Film detay ekranı.
// Seçilen filmin detayları, favori işlemleri ve görseli burada gösterilir.

class MovieDetailPage extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? imagePath;
  final bool? isFavorite;

  const MovieDetailPage({
    super.key,
    required this.title,
    this.subtitle,
    this.imagePath,
    this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          final movie = state.movies.firstWhere(
            (m) => m.title == title,
            orElse: () => MovieEntity(
              filmNo: -1,
              title: title,
              subtitle: subtitle ?? '',
              imagePath: imagePath ?? '',
              isFavorite: isFavorite ?? false,
            ),
          );
          final isFav = movie.isFavorite;
          return Stack(
            children: [
              // Fullscreen background image
              Positioned.fill(
                child: Hero(
                  tag: title,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image.asset(
                      imagePath ?? 'assets/profile_placeholder.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Back arrow
              Positioned(
                top: 18,
                left: 12,
                child: InkWell(
                  borderRadius: BorderRadius.circular(32),
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Icon(Icons.arrow_back, color: Colors.white, size: 26),
                  ),
                ),
              ),
              // Bottom info card
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(Icons.play_circle_fill, color: Colors.white, size: 28),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  getLocalizedSubtitle(context, subtitle ?? ''),
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white38, width: 1.5),
                            ),
                            child: IconButton(
                              icon: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: isFav ? Colors.red : Colors.white,
                                size: 28,
                              ),
                              onPressed: () {
                                context.read<MovieBloc>().add(ToggleFavorite(movie.filmNo));
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        AppLocalizations.of(context)?.fullDescription ?? '',
                        style: const TextStyle(color: Colors.white70, fontSize: 15),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            AppLocalizations.of(context)?.more ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                              ),
                              child: Text(AppLocalizations.of(context)?.watch ?? '', style: TextStyle(fontSize: 17)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Bottom navigation bar
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _NavButton(
                        icon: Icons.home,
                        label: AppLocalizations.of(context)?.home ?? '',
                        selected: true,
                        onTap: () => Navigator.of(context).pop(),
                      ),
                      _NavButton(
                        icon: Icons.person,
                        label: AppLocalizations.of(context)?.profile ?? '',
                        selected: false,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const ProfilePage()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _NavButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.white.withValues(alpha: 0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white24, width: 1.2),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 26),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
