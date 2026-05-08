import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_app/app_theme.dart';

void main() {
  // debugPrintRebuildDirtyWidgets = true;
  runApp(const MyApp());
}

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, _) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: currentMode,
          home: const IOSGlassBottomBarDemo(),
        );
      },
    );
  }
}

class IOSGlassBottomBarDemo extends StatefulWidget {
  const IOSGlassBottomBarDemo({super.key});

  @override
  State<IOSGlassBottomBarDemo> createState() => _IOSGlassBottomBarDemoState();
}

class _IOSGlassBottomBarDemoState extends State<IOSGlassBottomBarDemo> {
  int _selectedIndex = 0;

  // iOS-style tab items
  final List<IOSNavItem> _tabs = const [
    IOSNavItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Home',
    ),
    IOSNavItem(
      icon: Icons.search_outlined,
      activeIcon: Icons.search,
      label: 'Search',
    ),
    IOSNavItem(
      icon: Icons.favorite_border_outlined,
      activeIcon: Icons.favorite,
      label: 'Saved',
    ),
    IOSNavItem(
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🔑 Must be true so content scrolls behind the glass bar
      extendBody: true,
      body: Stack(
        children: [
          // Vibrant background to showcase the blur effect
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue.shade400,
                  Colors.purple.shade500,
                  Colors.pink.shade400,
                ],
              ),
            ),
            child: const Center(
              child: Text(
                'iOS Glass Navigation\nScroll Behind to See Blur',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          // iPhone Glass Bar
          _buildIOSGlassBar(),
        ],
      ),
    );
  }

  Widget _buildIOSGlassBar() {
    // Use viewPadding for accurate notch/home indicator spacing
    final bottomPadding = MediaQuery.viewPaddingOf(context).bottom;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Positioned(
      left: 12,
      right: 12,
      bottom: bottomPadding + 12,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          // iOS uses strong blur with soft falloff
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            height: 64,
            decoration: BoxDecoration(
              // iOS "Ultra Thin Material" simulation
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.35),
                  Colors.white.withOpacity(0.15),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              // Subtle white edge highlight (iOS signature)
              border: Border.all(
                color: Colors.white.withOpacity(0.45),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_tabs.length, (index) {
                final isSelected = _selectedIndex == index;
                return _buildTabItem(
                  _tabs[index],
                  index,
                  isSelected,
                  primaryColor,
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem(
    IOSNavItem item,
    int index,
    bool isSelected,
    Color primaryColor,
  ) {
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? item.activeIcon : item.icon,
              color: isSelected ? primaryColor : Colors.white70,
              size: 24,
            ),
            const SizedBox(height: 3),
            Text(
              item.label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? primaryColor : Colors.white70,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IOSNavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const IOSNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
