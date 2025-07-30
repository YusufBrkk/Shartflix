// limited_offer_modal.dart: Sınırlı teklif modalı. Kullanıcıya özel kampanya göstermek için kullanılır.
// showLimitedOfferModal fonksiyonu ile açılır.

import 'dart:ui';
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

// showLimitedOfferModal: Sınırlı teklif modalını açar.
Future<void> showLimitedOfferModal(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const LimitedOfferModal(),
  );
}

// LimitedOfferModal: Modal içeriği ve tasarımı burada tanımlanır.
class LimitedOfferModal extends StatelessWidget {
  const LimitedOfferModal({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Stack(
      children: [
        // BLUR ARKA PLAN
        Positioned.fill(
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: Container(
                    color: Colors.black.withAlpha(115),
              ),
            ),
          ),
        ),
        // MODAL KART
        Align(
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: mq.size.height * 0.80,
                maxHeight: mq.size.height * 0.95,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF6B0B1B), Color(0xFF101010)],
                ),
              ),
              child: SafeArea(
                top: false,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // ÜST BLUR
                      Container(
                        height: 80,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 8),
                                Text(
                                  l10n.limitedOffer,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  l10n.offerDescription,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 15,
                                    height: 1.3,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      // BONUSLAR
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.yourBonuses,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _BonusIcon(
                                  icon: Icons.diamond_rounded,
                                  label: l10n.premiumAccount,
                                  color: Color(0xFFE14B8A),
                                ),
                                _BonusIcon(
                                  icon: Icons.favorite,
                                  label: l10n.moreMatches,
                                  color: Color(0xFFE14B8A),
                                ),
                                _BonusIcon(
                                  icon: Icons.arrow_upward,
                                  label: l10n.highlight,
                                  color: Color(0xFFE14B8A),
                                ),
                                _BonusIcon(
                                  icon: Icons.favorite_border,
                                  label: l10n.moreLikes,
                                  color: Color(0xFFE14B8A),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // JETON KARTLARI
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.selectCoinPackage,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                _JetonCard(
                                  percent: '+10%',
                                  oldValue: '200',
                                  value: '330',
                                  label: 'Jeton',
                                  price: '₺99,99',
                                  color: Color(0xFFD9001B),
                                ),
                                _JetonCard(
                                  percent: '+70%',
                                  oldValue: '2.000',
                                  value: '3.375',
                                  label: 'Jeton',
                                  price: '₺799,99',
                                  color: Color(0xFF6B0BFF),
                                  highlight: true,
                                ),
                                _JetonCard(
                                  percent: '+35%',
                                  oldValue: '1.000',
                                  value: '1.350',
                                  label: 'Jeton',
                                  price: '₺399,99',
                                  color: Color(0xFFD9001B),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // TÜM JETONLARI GÖR BUTONU
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFD9001B),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              l10n.seeAllCoins,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BonusIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _BonusIcon({required this.icon, required this.label, required this.color});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
                color: color.withAlpha(46),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 30),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600, height: 1.1),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _JetonCard extends StatelessWidget {
  final String percent;
  final String oldValue;
  final String value;
  final String label;
  final String price;
  final Color color;
  final bool highlight;
  const _JetonCard({
    required this.percent,
    required this.oldValue,
    required this.value,
    required this.label,
    required this.price,
    required this.color,
    this.highlight = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: highlight ? const Color(0xFF6B0BFF) : color,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
                color: color.withAlpha(46),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              percent,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            oldValue,
            style: const TextStyle(
              color: Colors.white38,
              fontWeight: FontWeight.bold,
              fontSize: 13,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 13),
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 2),
          Text(
            AppLocalizations.of(context)?.perWeek ?? 'Per week',
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
