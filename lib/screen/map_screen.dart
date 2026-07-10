import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          zoom: 16,
          target: LatLng(23.723130638779892, 90.39322791683894),
        ),
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        onTap: (LatLng latLng) {
          print('on tap $latLng');
        },
        onLongPress: (LatLng latLng) {
          print('ont long pressed $latLng');
        },
        mapType: MapType.normal,
        trafficEnabled: true,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },

        markers: <Marker>{
          Marker(
            markerId: MarkerId('home'),
            position: LatLng(23.722849932922937, 90.39381634443998),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen,
            ),
            onTap: () {
              print("On taped marker home");
            },
            infoWindow: InfoWindow(
              title: "Home",
              onTap: () {
                print('On tapped home infor Window');
              },
            ),
            consumeTapEvents: false,
          ),

          Marker(
            markerId: MarkerId('Office'),
            position: LatLng(23.719160389336544, 90.393031463027),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            ),
            onTap: () {
              print("On taped marker Office");
            },
            infoWindow: InfoWindow(
              title: "Office",
              onTap: () {
                print('On tapped Office infor Window');
              },
            ),
            consumeTapEvents: false,
          ),
        },

        polylines: <Polyline>{
          Polyline(
            polylineId: PolylineId('Home-to-Office'),
            points: [
              LatLng(23.722849932922937, 90.39381634443998),
              LatLng(23.719160389336544, 90.393031463027),
            ],
            onTap: () {},
            color: Colors.purple,
            width: 8,
            endCap: .roundCap,
            startCap: .buttCap,
            visible: true,
            jointType: .bevel,
          ),
        },

        circles: <Circle>{
          Circle(
            circleId: CircleId('danger-zone'),
            center: LatLng(23.71682874040793, 90.39592456072569),
            radius: 300,
            strokeWidth: 5,
            strokeColor: Colors.red,
            fillColor: Colors.red.withAlpha(40),
            onTap: () {
              print("On tapped red-zone");
            },

            consumeTapEvents: true,

            visible: true,
          ),
        },

        polygons: <Polygon>{
          Polygon(
            polygonId: PolygonId('random-polygon'),
            points: [
              LatLng(23.717390169427702, 90.39235286414623),
              LatLng(23.721281736179943, 90.3907261043787),
              LatLng(23.724746845643462, 90.39159245789051),
            ],
            fillColor: Colors.purple.withAlpha(35),
            strokeColor: Colors.purple,
            strokeWidth: 6,
            onTap: () {
              print('On tapped random polygon');
            },
          ),
        },
      ),
      floatingActionButtonLocation: .centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _moveToHome,
        child: Icon(Icons.home),
      ),
    );
  }

  void _moveToHome() {
    // _mapController.moveCamera(
    //   CameraUpdate.newCameraPosition(
    //     CameraPosition(
    //       zoom: 16,
    //       target: LatLng(23.722849932922937, 90.39381634443998),
    //     ),
    //   ),

    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 16,
          target: LatLng(23.722849932922937, 90.39381634443998),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
