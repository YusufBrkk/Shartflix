// profile_info.dart: Kullanıcı profil detaylarını ve fotoğrafını düzenleme ekranı.
// Kullanıcı fotoğrafı seçebilir ve kaydedebilir.

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../../../l10n/app_localizations.dart';
import 'profile_image_provider.dart';

// AuthService: Token işlemleri için tekrar tanımlanmış (gereksizse kaldırılabilir).
class AuthService {
  // Token'ı kaydeder.
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  // Token'ı okur.
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Token'ı siler.
  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
}

// ProfileInfoPage: Kullanıcı profil detaylarını ve fotoğrafını düzenleme ekranı.
class ProfileInfoPage extends StatefulWidget {
  const ProfileInfoPage({super.key});

  @override
  State<ProfileInfoPage> createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  File? _imageFile;

  // _pickImage: Galeriden fotoğraf seçmek için kullanılır.
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold: Sayfa iskeleti, profil başlığı ve fotoğraf yükleme alanı.
    return Scaffold(
      backgroundColor: const Color(0xFF101010),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)?.profileDetail ?? 'Profil Detayı',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text(
              AppLocalizations.of(context)?.uploadYourPhotos ?? 'Fotoğraflarınızı Yükleyin',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
                fontFamily: 'Montserrat',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              AppLocalizations.of(context)?.profileSubtitle ?? 'Resources out incentivize\nrelaxation floor loss cc.',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 15,
                fontFamily: 'Montserrat',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 38),
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    color: const Color(0xFF232323),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: _imageFile == null
                      ? const Center(
                          child: Icon(Icons.add, color: Colors.white54, size: 48),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          child: Image.file(_imageFile!, fit: BoxFit.cover),
                        ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD9001B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  onPressed: () {
                    if (_imageFile != null) {
                      Provider.of<ProfileImageProvider>(context, listen: false).setImage(_imageFile);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    AppLocalizations.of(context)?.continueBtn ?? 'Devam Et',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}