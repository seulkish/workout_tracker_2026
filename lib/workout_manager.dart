import 'package:shared_preferences/shared_preferences.dart';
import 'workout.dart';
import 'workout_group.dart';

class WorkoutManager{
  static List<Workout> workouts=[
    Workout(name: '스쿼트',imageName: 'squat.png', minutes: 30, audioName: 'squat.mp3', kcal: 200),
    Workout(name: '윗몸 일으키기', minutes: 20, imageName: 'sit_up.png', audioName: 'sit_up.mp3', kcal: 100),
    Workout(name: '마운틴 클림버', minutes: 15, imageName: 'mountain_climber.png', audioName: 'mountain_climber.mp3', kcal: 50),
    Workout(name: '사이드 런지', minutes: 20, imageName: 'side_lunge.png', audioName: 'side_lunge.mp3', kcal: 100),
    Workout(name: '푸시업', minutes: 15, imageName: 'push_up.png', audioName: 'push_up.mp3', kcal: 100),
    Workout(name: '덩키 킥', minutes: 30, imageName: 'donkey_kick.png', audioName: 'donkey_kick.mp3', kcal: 50),
    Workout(name: '사이드 플랭크', minutes: 25, imageName: 'side_plank.png', audioName: 'side_plank.mp3', kcal: 120),
    Workout(name: '리버스 플랭크', minutes: 25, imageName: 'reverse_plank.png', audioName: 'reverse_plank.mp3', kcal: 120),
    Workout(name: '힙 브릿지', minutes: 20, imageName: 'hip_bridge.png', audioName: 'hip_brdige.mp3', kcal: 80),
    Workout(name: '어깨 스트레칭', minutes: 10, imageName: 'shoulder_stretch.png', audioName: 'shoulder_stretch.mp3', kcal: 30),
    Workout(name: '햄스트링 스트레칭', minutes: 10, imageName: 'hamstring_stretch.png', audioName: 'hamstring_stretch.mp3', kcal: 30),
  ];

  static List<Workout> group1Workout=[
    workouts[0],
    workouts[2],
    workouts[5],
    workouts[3],
    workouts[7],
  ];
  static List<Workout> group2Workout=[
    workouts[0],
    workouts[2],
    workouts[5],
    workouts[3],
    workouts[0],
    workouts[0],
    workouts[0],
  ];

  static List<WorkoutGroup> workoutGroups=[
    WorkoutGroup(
        groupDescription: '그룹1, 아침을 여는 5가지 운동',
        workouts: [
          workouts[0],
          workouts[2],
          workouts[5],
          workouts[3],
          workouts[7],
        ]
    ),
    WorkoutGroup(
        groupDescription: '그룹2, 7가지 운동',
        workouts: [
          workouts[1],
          workouts[2],
          workouts[3],
          workouts[6],
          workouts[7],
          workouts[8],
          workouts[0],
        ]
    ),
  ];

  static final asyncPrefs = SharedPreferencesAsync();

  static void increaseTodayWorkoutMinutes(int minutes) async{
    int todayMinutes = await getTodayWorkoutMinutes();
    await asyncPrefs.setInt('todayMinutes', minutes+todayMinutes);
  }
  static Future<int> getTodayWorkoutMinutes() async{
    int todayMinutes = await asyncPrefs.getInt('todayMinutes')??0;
    return todayMinutes;
  }
  static Future<>
}
