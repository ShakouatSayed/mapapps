import 'package:flutter/material.dart';
import 'package:mapapps/screen/location_tracker.dart';
import 'package:mapapps/screen/my_location_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LocationTracker());
  }
}
