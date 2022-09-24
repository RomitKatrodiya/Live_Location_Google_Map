import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../globals.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({Key? key}) : super(key: key);

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  Completer<GoogleMapController> mapController = Completer();
  late CameraPosition position;

  @override
  void initState() {
    super.initState();
    position = CameraPosition(
      target: LatLng(Global.lat, Global.long),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Google Map"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            position = CameraPosition(
              target: LatLng(Global.lat, Global.long),
              zoom: 12,
            );
          });
          final GoogleMapController controller = await mapController.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(position));
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.gps_fixed, color: Colors.black),
      ),
      body: GoogleMap(
          zoomControlsEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            mapController.complete(controller);
          },
          initialCameraPosition: position,
          markers: <Marker>{
            Marker(
              markerId: const MarkerId("Current Location"),
              position: LatLng(Global.lat, Global.long),
            ),
          }),
    );
  }
}
