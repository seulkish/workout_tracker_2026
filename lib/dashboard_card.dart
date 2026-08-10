import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardCard extends StatelessWidget {
  Icon icon;
  Text title;
  Widget info;

  Color? backgroundColor;
  LinearGradient? gradient;
  DecorationImage? backgroundImage;

  Function()? customOnTap;

  DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.info,
    this.backgroundColor,
    this.gradient,
    this.backgroundImage,
    this.customOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: customOnTap,
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300, width: 1.5),
          // color: Colors.grey.shade300,
          gradient: gradient,
          color: gradient == null
              ? backgroundColor ?? Colors.transparent
              : null,
          image: backgroundImage,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  icon,
                  SizedBox(width: 5,),
                  title,
                ],
              ),
              Expanded(
                  child: info,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

