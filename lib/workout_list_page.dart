import 'package:flutter/material.dart';
import 'package:workout_tracker_2026/workout.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_tracker_2026/workout_manager.dart';

class WorkoutListPage extends StatelessWidget {
  int groupIndex;
  List<Workout> workouts;
  WorkoutListPage({required this.groupIndex, super.key}):workouts=WorkoutManager.workoutGroups[groupIndex].workouts;

  // List<Workout> workouts=WorkoutManager.workoutGroups[groupIndex].workouts;
  List<Widget> getWorkoutList(BuildContext context) {
    List<Widget> result=[];
    for(int i=0;i< workouts.length; i++){
      var name=workouts[i].name;
      var minutes=workouts[i].minutes;
      var image=workouts[i].imageName;
      Widget sample=GestureDetector(
        onTap:(){
          context.go('/workout_home/workout_list/$groupIndex/workout_guide/$i');
        },
        child: Row(
          spacing: 20,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/$image'),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
              ),
            ),
            Expanded(
              child: Text(
                '${i+1}.$name', style: TextStyle(fontSize:20),
              ),
            ),
            Text(
              '$minutes', style: TextStyle(fontSize:20, color:Colors.blue),
            ),
          ],
        ),
      );
      result.add(sample);
    }
    //###############################

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('WorkoutList'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children:getWorkoutList(context),
        ),
      ),
    );
  }

}
