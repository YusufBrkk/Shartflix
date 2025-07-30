import 'package:flutter/material.dart';
import 'dart:ui';

class OfferFullPage extends StatelessWidget {
  const OfferFullPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              'Sınırlı Teklif',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Jeton paketini seçerek bonus kazanın ve yeni bölümlerin kilidini açın!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _BonusIcon(icon: Icons.diamond, label: 'Premium\nHesap', color: Colors.pinkAccent),
                _BonusIcon(icon: Icons.favorite, label: 'Daha\nFazla Eşleşme', color: Colors.pinkAccent),
                _BonusIcon(icon: Icons.arrow_upward, label: 'Öne\nÇıkarma', color: Colors.pinkAccent),
                _BonusIcon(icon: Icons.favorite_border, label: 'Daha\nFazla Beğeni', color: Colors.pinkAccent),
              ],
            ),
            SizedBox(height: 30),
            Text(
              'Kilidi açmak için bir jeton paketi seçin',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                _JetonCard(bonus: '+10%', jeton: '330', eskiJeton: '200', fiyat: '₺99,99', color: Colors.redAccent),
                SizedBox(height: 12),
                _JetonCard(bonus: '+70%', jeton: '3.375', eskiJeton: '2.000', fiyat: '₺799,99', color: Color(0xFF6B00B6)),
                SizedBox(height: 12),
                _JetonCard(bonus: '+35%', jeton: '1.350', eskiJeton: '1.000', fiyat: '₺399,99', color: Colors.redAccent),
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFB80000),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                child: Text('Tüm Jetonları Gör', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
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
        CircleAvatar(
          radius: 24,
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}

class _JetonCard extends StatelessWidget {
  final String bonus;
  final String jeton;
  final String eskiJeton;
  final String fiyat;
  final Color color;
  const _JetonCard({required this.bonus, required this.jeton, required this.eskiJeton, required this.fiyat, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.8), color.withValues(alpha: 0.4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(bonus, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(height: 8),
          Text('$eskiJeton → $jeton Jeton', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(fiyat + ' / haftalık', style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}
