// Referencias

// link : medium.com/comunidad-flutter/google-maps-en-flutter-98bedecb528b

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class RestaurantMaps extends StatefulWidget {
  RestaurantMaps({Key key}) : super(key: key);

  @override
  _RestaurantMaps createState() => _RestaurantMaps();
}

class _RestaurantMaps extends State<RestaurantMaps> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  void initState() {
    super.initState();
  }

  Future<void> requestPermission() async {
    await Permission.location.request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubicacion de restaurantes'),
        backgroundColor: Color.fromRGBO(245, 100, 90, 50),
      ),
      // body: GoogleMap(
      //   mapType: MapType.hybrid,
      //   initialCameraPosition: _kGooglePlex,
      //   onMapCreated: (GoogleMapController controller) {
      //     _controller.complete(controller);
      //   },
      // ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: Text('To the lake!'),
      //   icon: Icon(Icons.directions_boat),
      // ),
    );
  }

  Future<void> _goToTheLake() async {
    // requestPermission();
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
