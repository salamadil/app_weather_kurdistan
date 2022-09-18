import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Homee extends StatefulWidget {
  const Homee({super.key});

  @override
  State<Homee> createState() => _HomeeState();
}

class _HomeeState extends State<Homee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 200,
          width: 100,
          color: Colors.yellow,
        ),
      ),
    );
  }

  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController newGoogleMapController;
  var geoLocator = Geolocator();

  void locatePosition() async {
    Position currentPosition;
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    currentPosition = position;

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        new CameraPosition(target: latLatPosition, zoom: 14);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(36.191113, 44.009167),
    zoom: 14.4746,
  );

  final List<Marker> _marker = <Marker>[
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(36.1901, 43.9930),
        infoWindow: InfoWindow(
          title: 'Current location',
        ))
  ];

  loaData() {
    getUserCurrentLocation().then((value) async {
      print("my current location");
      print(value.latitude.toString() + "" + value.longitude.toString());
      _marker.add(Marker(
          markerId: MarkerId('2'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: InfoWindow(
            title: 'my LC',
          )));
      CameraPosition cameraPosition = CameraPosition(
          zoom: 14, target: LatLng(value.latitude, value.longitude));

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("error" + error.toString());
    });

    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState2() {
    // TODO: implement initState
    super.initState();
    loaData();
  }
}
