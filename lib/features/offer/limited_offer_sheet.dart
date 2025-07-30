import 'package:flutter/material.dart';

class LimitedOfferSheet extends StatelessWidget {
  const LimitedOfferSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
      child: Container(
        color: Colors.transparent,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFB8002E), Colors.black],
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
          ),
          padding: const EdgeInsets.fromLTRB(0, 28, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Sınırlı Teklif',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Jeton paketin’ni seçerek bonus kazanın ve yeni bölümlerin kilidini açın!',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 28),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    _BonusIcon(icon: Icons.diamond, label: 'Premium\nHesap'),
                    _BonusIcon(icon: Icons.favorite, label: 'Daha\nFazla Eşleşme'),
                    _BonusIcon(icon: Icons.arrow_circle_up, label: 'Öne\nÇıkarma'),
                    _BonusIcon(icon: Icons.favorite_border, label: 'Daha\nFazla Beğeni'),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Kilidi açmak için bir jeton paketi seçin',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    _TokenCard(
                      percent: '+10%',
                      oldAmount: '200',
                      newAmount: '330',
                      price: '₺99,99',
                      highlight: false,
                    ),
                    _TokenCard(
                      percent: '+70%',
                      oldAmount: '2.000',
                      newAmount: '3.375',
                      price: '₺799,99',
                      highlight: true,
                    ),
                    _TokenCard(
                      percent: '+35%',
                      oldAmount: '1.000',
                      newAmount: '1.350',
                      price: '₺399,99',
                      highlight: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                    ),
                    child: const Text('Tüm Jetonları Gör', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class _BonusIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  const _BonusIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFFFF5A9E), Color(0xFFB8002E)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _TokenCard extends StatelessWidget {
  final String percent;
  final String oldAmount;
  final String newAmount;
  final String price;
  final bool highlight;
  const _TokenCard({
    required this.percent,
    required this.oldAmount,
    required this.newAmount,
    required this.price,
    required this.highlight,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: highlight
              ? const LinearGradient(
                  colors: [Color(0xFF7B2FF2), Color(0xFFB8002E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : const LinearGradient(
                  colors: [Color(0xFFB8002E), Color(0xFF7B2FF2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          boxShadow: [
            BoxShadow(
              color: highlight ? Colors.purple.withValues(alpha: 0.18) : Colors.red.withValues(alpha: 0.18),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: highlight ? const Color(0xFF7B2FF2) : Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                percent,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              oldAmount,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
                decoration: TextDecoration.lineThrough,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              newAmount,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 2),
            const Text('Jeton', style: TextStyle(color: Colors.white70, fontSize: 15)),
            const SizedBox(height: 10),
            Text(
              price,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 2),
            const Text('Başına haftalık', style: TextStyle(color: Colors.white70, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
