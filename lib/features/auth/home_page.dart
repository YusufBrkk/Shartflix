// home_page.dart: Ana film listeleme ve favori ekleme/sıralama ekranı.
// Kullanıcı giriş yaptıktan sonra ana ekran olarak kullanılır.

import '../movie/presentation/bloc/movie_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../movie/presentation/bloc/movie_bloc.dart';
import '../movie/presentation/bloc/movie_event.dart';
import '../movie/presentation/movie_detail_page.dart';
import '../movie/presentation/localized_title.dart';

import '../common/bottom_nav_bar.dart';
import '../../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../main.dart' show LocaleProvider;

// HomePage: Ana film listeleme widget'ı.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // PageController: Dikey film kaydırma için kullanılır.
  final PageController _pageController = PageController();

  @override
  void initState() {
    // Uygulama başlarken filmleri yükler.
    super.initState();
    context.read<MovieBloc>().add(LoadMovies()); // veya RefreshMovies()
    // Sayfa sonuna gelince yeni filmleri yükler.
    _pageController.addListener(() {
      final bloc = context.read<MovieBloc>();
      if (_pageController.position.pixels >= _pageController.position.maxScrollExtent - 100) {
        bloc.add(LoadMovies());
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold: Sayfa iskeleti.
    // AppBar: Dil değiştirme butonları.
    // BlocBuilder: Film listesini ve loading durumunu yönetir.
    // PageView: Filmleri dikey kaydırmalı gösterir.
    // Favori butonu: Her film için favori ekleme/çıkarma.

    return Scaffold(
      backgroundColor: const Color(0xFF101010),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: null,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    Provider.of<LocaleProvider>(context, listen: false).setLocale(const Locale('en'));
                  },
                  child: const Text('EN', style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () {
                    Provider.of<LocaleProvider>(context, listen: false).setLocale(const Locale('tr'));
                  },
                  child: const Text('TR', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          // filmNo'ya göre sıralama
          final movies = List.of(state.movies)..sort((a, b) => a.filmNo.compareTo(b.filmNo));
          final isLoading = state.isLoading;
          if (movies.isEmpty && isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (movies.isEmpty) {
            return Center(
              child: Text(
                AppLocalizations.of(context)?.noFavorites ?? 'Henüz favori film yok.',
                style: const TextStyle(color: Colors.white70, fontSize: 18),
              ),
            );
          }
          return PageView.builder(
            scrollDirection: Axis.vertical,
            controller: _pageController,
            itemCount: movies.length + (isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < movies.length) {
                final movie = movies[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => MovieDetailPage(
                            title: movie.title,
                            subtitle: movie.subtitle,
                            imagePath: movie.imagePath,
                            isFavorite: movie.isFavorite,
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.asset(
                            movie.imagePath,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          right: 16,
                          top: 16,
                          child: GestureDetector(
                            onTap: () {
                              // Favori işlemini filmNo ile yap
                              context.read<MovieBloc>().add(ToggleFavorite(movie.filmNo));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Icon(
                                movie.isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: movie.isFavorite ? Colors.red : Colors.white,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.7),
                              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '#${movie.filmNo}',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      getLocalizedTitle(context, movie.title),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  movie.subtitle,
                                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
    );
  }
}

