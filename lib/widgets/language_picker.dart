import 'package:flutter/material.dart';

// language_picker.dart: Kullanıcının uygulama dilini seçmesini sağlayan widget.
// Dropdown veya buton ile dil seçimi yapılır.

class LanguagePicker extends StatelessWidget {
  const LanguagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Locale>(
      value: Localizations.localeOf(context),
      icon: const Icon(Icons.language, color: Colors.white),
      dropdownColor: Colors.black,
      underline: const SizedBox(),
      items: const [
        DropdownMenuItem(
          value: Locale('en'),
          child: Text('English', style: TextStyle(color: Colors.white)),
        ),
        DropdownMenuItem(
          value: Locale('tr'),
          child: Text('Türkçe', style: TextStyle(color: Colors.white)),
        ),
      ],
      onChanged: (locale) {
        if (locale != null) {
          // Locale değişimini sağlayacak kod burada olacak
          // (Provider, setState veya başka bir yöntemle)
        }
      },
    );
  }
}
