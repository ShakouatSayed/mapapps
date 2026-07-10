import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MyLocationScreen extends StatefulWidget {
  const MyLocationScreen({super.key});

  @override
  State<MyLocationScreen> createState() => _MyLocationScreenState();
}

class _MyLocationScreenState extends State<MyLocationScreen> {
  Position? _currentPosition;
  StreamSubscription? _locationSubscriber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text(
              "My current Location: ${_currentPosition?.latitude} : ${_currentPosition?.longitude}",
            ),
            FilledButton(
              onPressed: _getCurrentLocation,
              child: Text("Get Location"),
            ),
            SizedBox(height: 10),
            FilledButton(
              onPressed: _listenCurrentLocation,
              child: Text("Listen Current Location"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    // Check if location permisson enabled
    bool isPermissionEnabled = await _isPermissionEnabled();
    if (isPermissionEnabled) {
      // if yes, than go next
      bool isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();
      if (isLocationServiceEnabled) {
        Position position = await Geolocator.getCurrentPosition();
        print(position);
        _currentPosition = position;
        setState(() {});
      } else {
        Geolocator.openLocationSettings();
      }
      // check if location service enbled
      // if yes, then go next
      // Get current location
    } else {
      // if no, then ask to enabled location service
      bool isPermissionEnabled = await _requestPermissionEnabled();
      if (isPermissionEnabled) {
        _getCurrentLocation();
      } else {
        Geolocator.openAppSettings();
      }
    }

    // if no, then request permisson

    Position position = await Geolocator.getCurrentPosition();
  }

  Future<void> _listenCurrentLocation() async {
    _handleLocationPermision(
      onSuccess: () {
        // get real time location
        _locationSubscriber = Geolocator.getPositionStream().listen((
          Position? newPosition,
        ) {
          _currentPosition = newPosition;
          setState(() {});
        });
      },
    );
  }

  Future<void> _handleLocationPermision({
    required VoidCallback onSuccess,
  }) async {
    // Check if location permisson enabled
    bool isPermissionEnabled = await _isPermissionEnabled();
    if (isPermissionEnabled) {
      // if yes, than go next
      bool isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();
      if (isLocationServiceEnabled) {
        // action
        onSuccess();
      } else {
        Geolocator.openLocationSettings();
      }
      // check if location service enbled
      // if yes, then go next
      // Get current location
    } else {
      // if no, then ask to enabled location service
      bool isPermissionEnabled = await _requestPermissionEnabled();
      if (isPermissionEnabled) {
        _getCurrentLocation();
      } else {
        Geolocator.openAppSettings();
      }
    }

    // if no, then request permisson

    Position position = await Geolocator.getCurrentPosition();
  }

  Future<bool> _isPermissionEnabled() async {
    LocationPermission permission = await Geolocator.checkPermission();
    return permission == .always || permission == .whileInUse;
  }

  Future<bool> _requestPermissionEnabled() async {
    LocationPermission permission = await Geolocator.requestPermission();
    return permission == .always || permission == .whileInUse;
  }

  @override
  void dispose() {
    _locationSubscriber?.cancel();
    super.dispose();
  }
}
