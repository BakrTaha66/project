import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeHome extends StatefulWidget {
  const HomeHome({Key? key}) : super(key: key);

  @override
  State<HomeHome> createState() => _HomeHomeState();
}

// FloatingActionButton

class _HomeHomeState extends State<HomeHome> {
  // Completer<GoogleMapController> mapController = Completer();
  // CameraPosition initialPosition = const CameraPosition(
  //     target: LatLng(26.8206, 30.8025), zoom: 10, tilt: 50, bearing: 50);

  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(55.3781, 3.4360),
    zoom: 14,
  );

  List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(26.8206, 30.8025),
        infoWindow: InfoWindow(title: 'Cairo')),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(40.4637, 3.7492),
        infoWindow: InfoWindow(title: 'Madrid, Spain')),
    Marker(
        markerId: MarkerId('3'),
        position: LatLng(55.3781, 3.4360),
        infoWindow: InfoWindow(title: 'London, the UK')),
    Marker(
        markerId: MarkerId('4'),
        position: LatLng(36.2048, 138.2529),
        infoWindow: InfoWindow(title: 'Japan')),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }

  // marker
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Map')),
        backgroundColor: Colors.red,
      ),
      body: GoogleMap(
        // initialCameraPosition: initialPosition,
        initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(_marker),
        // onMapCreated: (GoogleMapController controller) {
        //   mapController.complete(controller);
        // }, // Bit Map
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: const Icon(Icons.location_searching_outlined),
        onPressed: () async {
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(
              CameraUpdate.newCameraPosition(const CameraPosition(
            target: LatLng(40.4637, 3.7492),
            zoom: 14,
          )));
          setState(() {});
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
