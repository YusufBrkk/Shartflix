// profile_image_provider.dart: Kullanıcının profil fotoğrafını yönetmek için kullanılır.
// ChangeNotifier ile state yönetimi sağlar.

import 'dart:io';
import 'package:flutter/material.dart';

// ProfileImageProvider: Profil fotoğrafı state yönetimi.
class ProfileImageProvider extends ChangeNotifier {
  File? _imageFile;

  File? get imageFile => _imageFile;

  // setImage: Yeni profil fotoğrafı ayarlar ve dinleyicileri bilgilendirir.
  void setImage(File? file) {
    _imageFile = file;
    notifyListeners();
  }
}