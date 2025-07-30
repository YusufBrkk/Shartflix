import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../auth/home_page.dart';
import '../auth/profile_page.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const BottomNavBar({required this.currentIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _BottomNavButton(
            icon: Icons.home,
            label: AppLocalizations.of(context)?.home ?? '',
            selected: currentIndex == 0,
            onTap: () {
              if (currentIndex != 0) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );
              }
            },
          ),
          _BottomNavButton(
            icon: Icons.person,
            label: AppLocalizations.of(context)?.profile ?? '',
            selected: currentIndex == 1,
            onTap: () {
              if (currentIndex != 1) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const ProfilePage()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _BottomNavButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _BottomNavButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    //super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 48,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: selected ? Colors.red.withValues(alpha: 0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 22),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}