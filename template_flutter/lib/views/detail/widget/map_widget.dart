import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {


  Completer<GoogleMapController> _controller = Completer();
  var _position = LatLng(10.8468936, 106.6408852);
  static final CameraPosition _kGooglePosition = CameraPosition(
    target: LatLng(10.8468936, 106.6408852),
    zoom: 14.5,
  );

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      zoomControlsEnabled: false,
      onTap: (LatLng _latLng) async {},
      markers: Set.of([
        Marker(
          markerId: MarkerId("home"),
          draggable: true,
          position: _position,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
        ),
      ]),
      initialCameraPosition: _kGooglePosition,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
