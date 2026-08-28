//filename: workout_day_selector.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../logic/my_workout_provider.dart';

class WorkoutDaySelector extends StatefulWidget {
  int workoutIndex;
  WorkoutDaySelector({super.key,required this.workoutIndex});

  @override
  State<WorkoutDaySelector> createState() => _WorkoutDaySelectorState();
}

class _WorkoutDaySelectorState extends State<WorkoutDaySelector> {
  List<bool> isSelected = List.filled(7, false);
  void updateIsSelected(int index){
    isSelected[index]=!isSelected[index];
    Provider.of<MyWorkoutProvider>(context, listen: false).updateMyWorkout(
      isSelected: List<bool>.from(isSelected),
      workoutIndex: widget.workoutIndex,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSelected=List<bool>.from(
      Provider.of<MyWorkoutProvider>(context,listen: false).workouts[widget.workoutIndex].workoutDays
    );
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      // selectedColor: Colors.blue,
      // fillColor: Colors.blue,
      isSelected: isSelected,
      constraints: const BoxConstraints(
        minHeight: 32,
        minWidth: 32,
      ),
      children: [
        Text('월'),
        Text('화'),
        Text('수'),
        Text('목'),
        Text('금'),
        Text('토'),
        Text('일'),
      ],
      onPressed: (index){
        setState(() {
          updateIsSelected(index);
        });
      },
    );
  }
}
