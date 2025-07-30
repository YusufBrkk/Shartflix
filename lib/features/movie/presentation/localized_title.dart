import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

// localized_title.dart: Film başlıklarını lokalize etmek için yardımcı fonksiyonlar içerir.

String getLocalizedTitle(BuildContext context, String key) {
  final l10n = AppLocalizations.of(context);
  // Anahtarı normalize et: sadece harfleri al
  final normalizedKey = key.replaceAll(RegExp(r'[^a-zA-Z]'), '');
  switch (normalizedKey) {
    case 'loveAndAdventure':
      return l10n?.loveAndAdventure ?? '';
    case 'midnight':
      return l10n?.midnight ?? '';
    case 'lostCity':
      return l10n?.lostCity ?? '';
    case 'lastJourney':
      return l10n?.lastJourney ?? '';
    case 'secretGarden':
      return l10n?.secretGarden ?? '';
    case 'brokenDreams':
      return l10n?.brokenDreams ?? '';
    case 'underTheStars':
      return l10n?.underTheStars ?? '';
    case 'lightInTheDark':
      return l10n?.lightInTheDark ?? '';
    case 'onceUponATime':
      return l10n?.onceUponATime ?? '';
    case 'colorsOfLife':
      return l10n?.colorsOfLife ?? '';
    default:
      return key;
  }
}

String getLocalizedSubtitle(BuildContext context, String key) {
  final l10n = AppLocalizations.of(context);
  final normalizedKey = key.replaceAll(RegExp(r'[^a-zA-Z]'), '');
  switch (normalizedKey) {
    case 'dramaRomance':
      return l10n?.dramaRomance ?? '';
    case 'thrillerMystery':
      return l10n?.thrillerMystery ?? '';
    case 'adventureFantasy':
      return l10n?.adventureFantasy ?? '';
    case 'scienceFiction':
      return l10n?.scienceFiction ?? '';
    case 'familyComedy':
      return l10n?.familyComedy ?? '';
    case 'actionCrime':
      return l10n?.actionCrime ?? '';
    case 'animation':
      return l10n?.animation ?? '';
    case 'documentary':
      return l10n?.documentary ?? '';
    case 'horror':
      return l10n?.horror ?? '';
    case 'history':
      return l10n?.history ?? '';
    default:
      return key;
  }
}
