import 'package:flutter/material.dart';


class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}


class _DiscoverPageState extends State<DiscoverPage> {
  List<Map<String, dynamic>> allMovies = [
    {
      'title': 'Günahkar Adam',
      'description': 'Community every territories dogpile so. Last they investigation model and more details about the movie can be shown here for the user to read.',
      'image': 'assets/movie5.jpg',
    },
    {
      'title': 'Kayıp Ruhlar',
      'description': 'A mysterious journey through the unknown. This is a sample description for the second movie.',
      'image': 'assets/movie5.jpg',
    },
    {
      'title': 'Gece Yarısı',
      'description': 'Night falls and secrets are revealed. This is a sample description for the third movie.',
      'image': 'assets/movie5.jpg',
    },
    // 5'ten fazla örnek film ekle
    {
      'title': 'Karanlık Yol',
      'description': 'A dark road with no return. Sample description for the fourth movie.',
      'image': 'assets/movie5.jpg',
    },
    {
      'title': 'Son Umut',
      'description': 'The last hope fades away. Sample description for the fifth movie.',
      'image': 'assets/movie5.jpg',
    },
    {
      'title': 'Kırık Hayaller',
      'description': 'Broken dreams and new beginnings. Sample description for the sixth movie.',
      'image': 'assets/movie5.jpg',
    },
    {
      'title': 'Gölge',
      'description': 'Shadow follows everywhere. Sample description for the seventh movie.',
      'image': 'assets/movie5.jpg',
    },
    {
      'title': 'Yitik Zaman',
      'description': 'Lost in time. Sample description for the eighth movie.',
      'image': 'assets/movie5.jpg',
    },
    {
      'title': 'Küçük Prens',
      'description': 'A little prince in a big world. Sample description for the ninth movie.',
      'image': 'assets/movie5.jpg',
    },
    {
      'title': 'Sonsuz Gece',
      'description': 'Endless night, endless dreams. Sample description for the tenth movie.',
      'image': 'assets/movie5.jpg',
    },
  ];

  List<Map<String, dynamic>> visibleMovies = [];
  List<bool> isFavoriteList = [];
  List<bool> showFullTextList = [];
  int loadedCount = 0;
  @override
  void initState() {
    super.initState();
    _loadMoreMovies();
  }

  void _loadMoreMovies() {
    final nextCount = (loadedCount + 5).clamp(0, allMovies.length);
    if (nextCount > loadedCount) {
      setState(() {
        visibleMovies.addAll(allMovies.sublist(loadedCount, nextCount));
        isFavoriteList.addAll(List.generate(nextCount - loadedCount, (index) => false));
        showFullTextList.addAll(List.generate(nextCount - loadedCount, (index) => false));
        loadedCount = nextCount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final int pageCount = (visibleMovies.length / 5).ceil();
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: pageCount,
        onPageChanged: (pageIndex) {
          // Son sayfaya gelindiyse yeni 5 film ekle
          if (pageIndex == pageCount - 1 && loadedCount < allMovies.length) {
            _loadMoreMovies();
          }
        },
        itemBuilder: (context, pageIndex) {
          final start = pageIndex * 5;
          final end = (start + 5).clamp(0, visibleMovies.length);
          final movies = visibleMovies.sublist(start, end);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(movies.length, (i) {
              final movie = movies[i];
              final globalIndex = start + i;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.asset(
                          movie['image'],
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
                            setState(() {
                              isFavoriteList[globalIndex] = !isFavoriteList[globalIndex];
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              isFavoriteList[globalIndex] ? Icons.favorite : Icons.favorite_border,
                              color: isFavoriteList[globalIndex] ? Colors.red : Colors.white,
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
                              Text(
                                movie['title'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                showFullTextList[globalIndex]
                                    ? movie['description']
                                    : '${movie['description'].substring(0, 55)}...',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showFullTextList[globalIndex] = !showFullTextList[globalIndex];
                                  });
                                },
                                child: Text(
                                  showFullTextList[globalIndex] ? 'Daha Az' : 'Daha Fazlası',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

