import 'package:flutter/material.dart';

class MyLocationScreen extends StatefulWidget {
  @override
  State<MyLocationScreen> createState() => _MyLocationScreenState();
}

class _MyLocationScreenState extends State<MyLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Column(
        children: [
          Text("My current Location: Lat Lng"),
          FilledButton(
            onPressed: _getCurrentLocation,
            child: Text("Get Location"),
          ),
        ],
      ),
    );
  }

  Future<void> _getCurrentLocation() async {}
}
