import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WorkoutShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const WorkoutShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
        onDestinationSelected: (index){
          navigationShell.goBranch(
            index,
            initialLocation: index==navigationShell.currentIndex);
        },
      ),
    );
  }
}
