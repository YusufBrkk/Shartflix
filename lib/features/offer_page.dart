
import 'package:flutter/material.dart';

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
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.pinkAccent, size: 32),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 13)),
      ],
    );
  }
}

class _JetonCard extends StatelessWidget {
  final String bonus;
  final String oldAmount;
  final String newAmount;
  final String price;
  final Color color;
  const _JetonCard({required this.bonus, required this.oldAmount, required this.newAmount, required this.price, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.18),
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
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              bonus,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            oldAmount,
            style: const TextStyle(
              color: Colors.white38,
              fontWeight: FontWeight.bold,
              fontSize: 13,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            newAmount,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ],
      ),
    );
  }
  }
