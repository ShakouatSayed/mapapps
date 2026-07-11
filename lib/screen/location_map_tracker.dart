import 'dart:async';

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

  // Timerr that fires every 10 seconds to fetch a fresh location.
  Timer? _locationTime;

  // keeps the full trail of visited points so the polyline can keep growing
  final List<LatLng> _routePoints = [];

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
