import 'package:go_router/go_router.dart';
import 'package:workout_tracker_2026/landing_page.dart';
import 'package:workout_tracker_2026/workout_guide_page.dart';
import 'workout_home_page.dart';
import 'workout_list_page.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LandingPage(),
    ),
    GoRoute(
      path: '/workout_home',
      builder: (context, state) => WorkoutHomePage(),
      routes: [
        GoRoute(
          path: 'workout_list/:group_index',
          builder: (context, state) {
            String? groupIndexString = state.pathParameters['group_index'];
            final groupIndex = int.parse(groupIndexString!);
            return WorkoutListPage(groupIndex:groupIndex);
          },
          routes: [
            GoRoute(
              path: 'workout_guide/:workouts_index',
              builder: (context, state) {
                String? workoutIndexString = state.pathParameters['workouts_index'];
                final workoutsIndex=int.parse(workoutIndexString!);
                return WorkoutGuidePage(workoutsIndex:workoutsIndex);
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
