//my_router.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:workout_tracker_2026/pages/landing_page.dart';
import 'package:workout_tracker_2026/pages/login_page.dart';
import 'package:workout_tracker_2026/pages/reset_password_page.dart';
import 'package:workout_tracker_2026/pages/settings_page.dart';
import 'package:workout_tracker_2026/pages/workout_guide_page.dart';
import 'package:workout_tracker_2026/pages/workout_home_page.dart';
import 'package:workout_tracker_2026/pages/workout_list_page.dart';
import 'package:workout_tracker_2026/pages/workout_shell.dart';
import 'package:workout_tracker_2026/pages/registration_page.dart';
import 'package:workout_tracker_2026/pages/profile_page.dart';

import 'pages/my_workout_list_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _homeNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'home',
);
final GlobalKey<NavigatorState> _settingsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'settings');

// GoRouter configuration
final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(path: '/', builder: (context, state) => LandingPage()),
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state, navigationShell) {
        return WorkoutShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeNavigatorKey,
          routes: [
            GoRoute(
              path: '/workout_home',
              builder: (context, state) => WorkoutHomePage(),
              routes: [
                GoRoute(
                  path: 'my_workout_list',
                  builder: (context, state) {
                    return MyWorkoutListPage();
                  },
                ),
                GoRoute(
                  path: 'workout_list/:group_index',
                  builder: (context, state) {
                    String? groupIndexString =
                        state.pathParameters['group_index'];
                    final groupIndex = int.parse(groupIndexString!);
                    return WorkoutListPage(groupIndex: groupIndex);
                  },
                  routes: [
                    GoRoute(
                      path: 'workout_guide/:workouts_index',
                      builder: (context, state) {
                        String? workoutsIndexString =
                            state.pathParameters['workouts_index'];
                        final workoutsIndex = int.parse(workoutsIndexString!);
                        return WorkoutGuidePage(workoutsIndex: workoutsIndex);
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
          routes: [
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
                    GoRoute(
                      path: 'reset_password',
                      builder: (context, state) => ResetPasswordPage(),
                    ),
                  ],
                ),

                GoRoute(
                  path: 'profile',
                  builder: (context, state) => ProfilePage(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
  redirect: (context, state) {
    User? user = FirebaseAuth.instance.currentUser;

    // debugPrint('현재 경로: ${state.uri.path}');
    // debugPrint('전체 URI: ${state.uri}');
    // debugPrint('로그인 여부: ${user != null}');

    if ((user == null) &&
        (state.uri.path != '/settings/login/registration' &&
            state.uri.path != '/settings/login/reset_password' &&
            state.uri.path != '/')) {
      //로그인 안 된 상태
      return '/settings/login';
    }
    if (user != null &&
        (state.uri.path == '/settings/login' ||
            state.uri.path == '/settings/login/registration')) {
      //로그인 된 상태 + settings tab 클릭했을 때
      return '/settings';
    }
  },
);
