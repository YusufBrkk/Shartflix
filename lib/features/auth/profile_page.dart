// profile_page.dart: Kullanıcı profil ana ekranı.
// Profil bilgileri, profil fotoğrafı ve sınırlı teklif modalı buradan yönetilir.

import '../auth/home_page.dart';
import 'signup_page.dart' as signup;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../l10n/app_localizations.dart';
import '../common/bottom_nav_bar.dart';
import '../movie/presentation/bloc/movie_bloc.dart';
import '../movie/presentation/bloc/movie_state.dart';
import '../auth/profile_info.dart';
import 'profile_image_provider.dart';
import 'limited_offer_modal.dart';

// ProfilePage: Kullanıcı profil ana widget'ı.
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // userName: Kullanıcı adını UserStore'dan alır.
  String get userName => signup.UserStore.userName ?? 'Kullanıcı';

  // _navigateToProfileInfo: Profil detay sayfasına geçiş.
  void _navigateToProfileInfo() async {
    final result = await Navigator.of(context).push<File>(
      MaterialPageRoute(builder: (_) => const ProfileInfoPage()),
    );
    if (result != null) {
      setState(() {
        // _imageFile = result;
      });
    }
  }

  // _showLimitedOfferModal: Sınırlı teklif modalını açar.
  void _showLimitedOfferModal(BuildContext context) {
    showLimitedOfferModal(context);
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold: Profil ekranı iskeleti, başlık, profil fotoğrafı, teklif butonu.
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              child: Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(32),
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const HomePage()),
                        (route) => false,
                      );
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    AppLocalizations.of(context)?.profileDetail ?? 'Profil Detayı',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 19),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () => _showLimitedOfferModal(context),
                    icon: const Icon(Icons.local_offer, color: Colors.white, size: 18),
                    label: Text(AppLocalizations.of(context)?.limitedOffer ?? 'Sınırlı Teklif'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profil fotoğrafı kısmı
                  GestureDetector(
                    onTap: _navigateToProfileInfo,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[800],
                      backgroundImage: Provider.of<ProfileImageProvider>(context).imageFile != null
                          ? FileImage(Provider.of<ProfileImageProvider>(context).imageFile!)
                          : const AssetImage('assets/movie6.jpg') as ImageProvider,
                      child: Provider.of<ProfileImageProvider>(context).imageFile == null
                          ? null
                          : null, // Artık child'a ikon koymaya gerek yok, çünkü varsayılan resim var
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 2),
                        Text(
                          '${AppLocalizations.of(context)?.userId ?? 'ID'}: 245677',
                          style: const TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _navigateToProfileInfo, // <-- Sadece bu fonksiyonu kullan!
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    child: Text(AppLocalizations.of(context)?.addPhoto ?? 'Fotoğraf Ekle'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                AppLocalizations.of(context)?.favoriteMovies ?? 'Beğendiğim Filmler',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: BlocBuilder<MovieBloc, MovieState>(
                  builder: (context, state) {
                    if (!state.isLoading) {
                      // Filmler yüklenmiş demektir
                      final favoriteMovies = state.movies.where((m) => m.isFavorite).toList();
                      return GridView.builder(
                        itemCount: favoriteMovies.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 18,
                          crossAxisSpacing: 14,
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (context, index) {
                          final movie = favoriteMovies[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.18),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image.asset(
                                    movie.imagePath,
                                    width: double.infinity,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    movie.title,
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  child: Text(
                                    movie.subtitle,
                                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
    );
  }
}


