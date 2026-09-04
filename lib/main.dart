import 'package:firebase_core/firebase_core.dart';
import 'package:workout_tracker_2026/logic/my_workout_provider.dart';
import 'package:workout_tracker_2026/logic/provider/article_provider.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'pages/workout_list_page.dart';
import 'pages/workout_guide_page.dart' as original;
import 'pages/workout_guide_page_test.dart' as testPage;
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'test_tutorial/duolingo_home.dart';
import 'pages/duolingo_study_page.dart';
import 'pages/workout_home_page.dart';
import 'my_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> MyWorkoutProvider()),
        ChangeNotifierProvider(create: (_)=> ArticleProvider()),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        theme: FlexThemeData.light(scheme: FlexScheme.blue),
        darkTheme: FlexThemeData.dark(scheme: FlexScheme.redWine),
        themeMode: ThemeMode.system,
      ),
    );

    // return MaterialApp(
    //   home: WorkoutHomePage(),
    //   // home: DuolingoStudyPage(),
    //   // home: testPage.WorkoutGuidePage(),
    //   // home: original.WorkoutGuidePage(),
    //   // theme: FlexThemeData.light(scheme: FlexScheme.redWine),
    //   theme: FlexThemeData.light(scheme: FlexScheme.blue),
    //   darkTheme: FlexThemeData.dark(scheme: FlexScheme.redWine),
    //   themeMode: ThemeMode.system,
    // );
  }
}

