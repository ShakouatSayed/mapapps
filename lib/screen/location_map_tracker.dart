import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMapTracker extends StatefulWidget {
  const LocationMapTracker({super.key});
  @override
  State<LocationMapTracker> createState() => _LocationMapTrackerState();
}

class _LocationMapTrackerState extends State<LocationMapTracker> {
  // Controller for the Google Map Widget, used to animate the camera.
  GoogleMapController? _mapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
