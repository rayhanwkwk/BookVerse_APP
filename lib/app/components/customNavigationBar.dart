import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color background = Color(0xFF121212);
    const Color primary = Color(0xFFFD5B35);
    const Color colorUnSelect = Color(0xFFF6F6F6);
    return NavigationBar(
      destinations: [
        ...List.generate(4, (index) {
          final isSelected = index == currentIndex;
          return NavigationDestination(
            icon: Icon(
              _icons[index],
              color: isSelected ? Colors.white : background, // Dynamic color
            ),
            label: _labels[index],
          );
        }),
      ],
      backgroundColor: colorUnSelect,
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      indicatorColor: primary,
      elevation: 0,
      height: 65.0,
      animationDuration: const Duration(milliseconds: 500),
      surfaceTintColor: Colors.white,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    );
  }
}

const _icons = [
  Icons.house_rounded,
  Icons.book_rounded,
  Icons.bookmarks,
  Icons.person_rounded,
];

const _labels = [
  'Home',
  'Boook',
  'Bookmarks',
  'Profile',
];
