import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationTracker extends StatefulWidget {
  const LocationTracker({super.key});

  @override
  State<LocationTracker> createState() => _LocationTrackerState();
}

class _LocationTrackerState extends State<LocationTracker> {
  GoogleMapController? _controller;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  final List<LatLng> _polylinePoints = [];

  Timer? _timer;

  static const CameraPosition _initialCamera = CameraPosition(
    target: LatLng(23.8103, 904125),
    zoom: 15,
  );

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    _getCurrentLocation();

    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      _getCurrentLocation();
    });
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    LatLng currentLocation = LatLng(position.latitude, position.longitude);
    _polylinePoints.add(currentLocation);
    _markers.clear();
    _markers.add(
      Marker(
        markerId: MarkerId("current"),
        position: currentLocation,
        infoWindow: InfoWindow(
          title: 'My current location',
          snippet: '${position.latitude}, ${position.longitude}',
        ),
      ),
    );
    _polylines.clear();
    _polylines.add(
      Polyline(
        polylineId: PolylineId("route"),
        color: Colors.blue,
        width: 5,
        points: _polylinePoints,
      ),
    );

    _controller?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: currentLocation, zoom: 18),
      ),
    );

    setState(() {});

    @override
    void dispose() {
      _timer?.cancel();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text(
          "Real-Time Location Tracker",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: _initialCamera,
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        compassEnabled: true,
        markers: _markers,
        polylines: _polylines,
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
      ),
    );
  }
}
