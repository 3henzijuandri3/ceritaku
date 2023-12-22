import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MiniMap extends StatefulWidget {
  final double lat;
  final double long;
  final String id;
  final String name;

  const MiniMap({
    super.key,
    required this.lat,
    required this.long,
    required this.id,
    required this.name
  });

  @override
  State<MiniMap> createState() => _MiniMapState();
}

class _MiniMapState extends State<MiniMap> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();


  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      rotateGesturesEnabled: false,
      scrollGesturesEnabled: false,
      tiltGesturesEnabled: false,
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.lat, widget.long),
        zoom: 14
      ),

      markers: {
        Marker(
          markerId: MarkerId(widget.id),
          position: LatLng(widget.lat, widget.long),
          infoWindow: InfoWindow(
            title: widget.name,
          ),
        ),
      },

      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },

    );
  }
}
