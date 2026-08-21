import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_tracker_2026/landing_page.dart';
import 'package:workout_tracker_2026/login_page.dart';
import 'package:workout_tracker_2026/settings_page.dart';
import 'package:workout_tracker_2026/workout_guide_page.dart';
import 'package:workout_tracker_2026/workout_home_page.dart';
import 'package:workout_tracker_2026/workout_list_page.dart';
import 'package:workout_tracker_2026/workout_shell.dart';
import 'registration_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey= GlobalKey<NavigatorState>(debugLabel:'root');
final GlobalKey<NavigatorState> _homeNavigatorKey= GlobalKey<NavigatorState>(debugLabel:'home');
final GlobalKey<NavigatorState> _settingsNavigatorKey= GlobalKey<NavigatorState>(debugLabel:'settings');

// GoRouter configuration
final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LandingPage(),
    ),
    StatefulShellRoute.indexedStack(
        parentNavigatorKey: _rootNavigatorKey,
        builder:(context, state, navigationShell){
          return WorkoutShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes:[

              GoRoute(
                path: '/workout_home',
                builder: (context, state) => WorkoutHomePage(),
                routes:[
                  GoRoute(
                    path: 'workout_list/:group_index',
                    builder: (context, state) {
                      String? groupIndexString=state.pathParameters['group_index'];
                      final groupIndex=int.parse(groupIndexString!);
                      return WorkoutListPage(groupIndex:groupIndex);
                    },
                    routes: [
                      GoRoute(
                        path: 'workout_guide/:workouts_index',
                        builder: (context, state) {
                          String? workoutsIndexString=state.pathParameters['workouts_index'];
                          final workoutsIndex=int.parse(workoutsIndexString!);
                          return WorkoutGuidePage(workoutsIndex:workoutsIndex);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _settingsNavigatorKey,
            routes:[
              GoRoute(
                path: '/settings',
                builder: (context, state) => SettingsPage(),
                routes: [
                  GoRoute(
                    path: 'login',
                    builder: (context, state) => LoginPage(),
                    routes: [
                      GoRoute(
                        path: 'registration',
                        builder: (context, state) => RegistrationPage(),
                      ),
                    ],
                  )
                ]
              ),
            ],
          ),
        ]
    ),
  ],
);
/*
*
*
* */