import 'workout.dart';

class WorkoutGroup {
  String groupDescription;
  List<Workout> workouts;
  WorkoutGroup({required this.workouts, required this.groupDescription});
}