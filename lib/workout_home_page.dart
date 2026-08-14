import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:workout_tracker_2026/workout_manager.dart';
import 'dashboard_card.dart';
// import 'package:intl/intl_browser.dart';
import 'package:go_router/go_router.dart';

class WorkoutHomePage extends StatefulWidget {
  const WorkoutHomePage({super.key});

  @override
  State<WorkoutHomePage> createState() => _WorkoutHomePageState();
}

class _WorkoutHomePageState extends State<WorkoutHomePage> {
  final f1 = NumberFormat.decimalPattern('ko_KR');
  late Future<int> myFuture;
  @override
  void initState(){
    super.initState();
    myFuture = WorkoutManager.getTodayWorkoutMinutes();
  }

  @override
  void didUpdateWidget(covariant WorkoutHomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    myFuture = WorkoutManager.getTodayWorkoutMinutes();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/runner_icon.png', width: 24),
                  Image.asset('assets/notifications_icon.png', width: 19),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '반가워요.',
                              style: textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: ' 건강을 위한 한 걸음\n',
                              style: textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: colorScheme.primary,
                              ),
                            ),
                            TextSpan(text: '오늘도 힘차게 운동을 해볼까요?\n'),
                            TextSpan(
                              text: '> 내 프로필',
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.outline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Image.asset('assets/half_circle.png', width: 132),
                      Positioned(
                        left: 15,
                        bottom: 19,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.blue, width: 1),
                            image: DecorationImage(
                              image: AssetImage('assets/me.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Expanded(
                      child: DashboardCard(
                        icon: Icon(
                          Icons.push_pin_outlined,
                          color: colorScheme.outline,
                        ),
                        title: Text(
                          'Today',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: colorScheme.outline,
                          ),
                        ),
                        info: FutureBuilder(
                          future: myFuture,
                          builder: (context, asyncSnapshot) {
                            if(asyncSnapshot.connectionState == ConnectionState.waiting){
                              return Center(child: CircularProgressIndicator(),);
                            }
                            if(asyncSnapshot.hasError){
                              return Center(child: Text('-'),);
                            }
                            int? data=asyncSnapshot.data;

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                // SizedBox(height: 10),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      height: 120,
                                      child: CircularProgressIndicator(
                                        value: 0.9,
                                        strokeWidth: 8,
                                        backgroundColor: colorScheme.outlineVariant,
                                      ),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '운동시간\n',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: colorScheme.outline,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '$data분',
                                            style: TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                              color: colorScheme.primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                // SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 30),
                                  child: Text.rich(
                                    textAlign: TextAlign.center,
                                    TextSpan(
                                      children: [
                                        TextSpan(text: '소모 칼로리\n'),
                                        TextSpan(
                                          text: '2,400 kcal',
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: colorScheme.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: DashboardCard(
                        icon: Icon(
                          Icons.calendar_month_outlined,
                          color: colorScheme.outline,
                        ),
                        title: Text(
                          'Monthly',
                          style: TextStyle(
                            color: colorScheme.outline,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        info: FutureBuilder(
                          future: WorkoutManager.getTodayWorkoutMinutes(),
                          builder: (context, asyncSnapshot) {
                            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator(),);
                            }
                            if (asyncSnapshot.hasError) {
                              return Center(child: Text('error'));
                            }

                            int? data = asyncSnapshot.data;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                // SizedBox(height: 10),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      height: 120,
                                      child: CircularProgressIndicator(
                                        value: 0.9,
                                        strokeWidth: 8,
                                        backgroundColor: colorScheme.outlineVariant,
                                      ),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '운동시간\n',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: colorScheme.outline,
                                            ),
                                          ),
                                          TextSpan(
                                            text: '$data분',
                                            style: TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                              color: colorScheme.primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                // SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 30),
                                  child: Text.rich(
                                    textAlign: TextAlign.center,
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '지난달 대비\n',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '10시간',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: colorScheme.primary,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' 더 했어요',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 200,
                        child: DashboardCard(
                          icon: Icon(Icons.run_circle_outlined),
                          title: Text(
                            '그룹1',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          info: Container(
                            child: Row(
                              children: [
                                Image.asset('assets/group1.png', width: 80),
                                Text(
                                  '아침을 여는\n5가지 운동',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          customOnTap: (){
                            context.go('/workout_home/workout_list/0');
                          },
                          backgroundColor: Color(0xFFFFFFFF),
                          gradient: LinearGradient(
                            colors: [Colors.white, Color(0xFFFFFFD9)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: DashboardCard(
                          icon: Icon(Icons.fitness_center),
                          title: Text('그룹2'),
                            info: Container(
                              child: Row(
                                children: [
                                  Image.asset('assets/group2.png', width: 80),
                                  Text(
                                    '근력을 \n키우는\n7가지 운동',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            backgroundColor: Color(0xFFFFFFFF),
                            gradient: LinearGradient(
                              colors: [Colors.white, colorScheme.inversePrimary],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          customOnTap: (){
                            context.go('/workout_home/workout_list/1');
                          },
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: DashboardCard(
                          icon: Icon(Icons.rowing),
                          title: Text('그룹3'),
                          info: Container(
                            child: Row(
                              children: [
                                Image.asset('assets/group3.png', width: 80),
                                Text(
                                  '하루를\n마무리하는\n4가지 운동',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          backgroundColor: Color(0xFFFFFFFF),
                          gradient: LinearGradient(
                            colors: [Colors.white, colorScheme.errorContainer],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: DashboardCard(
                  icon: Icon(Icons.ac_unit_sharp, color: colorScheme.primary,),
                  title: Text('운동이어서하기', style: TextStyle(fontSize: 22, color: colorScheme.primary, fontWeight: FontWeight.w800),),
                  info: Padding(
                    padding: const EdgeInsets.only(bottom: 38, right: 12),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: Text('당신의 몸은 해 낼 수 있다.\n당신의 마음만 설득하면 된다.', style: TextStyle(fontSize: 20, color: colorScheme.outline),)
                    ),
                  ),
                  backgroundColor: null,
                  gradient: null,
                  backgroundImage: DecorationImage(
                    image: AssetImage('assets/continue.png'),
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomRight
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
