import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

// localized_subtitle.dart: Film alt başlıklarını lokalize etmek için yardımcı fonksiyonlar içerir.

String getLocalizedSubtitle(BuildContext context, String key) {
  final l10n = AppLocalizations.of(context);
  switch (key) {
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
