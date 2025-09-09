import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  final LatLng initialPosition;
  final Set<Marker> markers;
  final Function(LatLng) onTap;
  final Completer<GoogleMapController>? controller;

  const MapSample({
    super.key,
    required this.initialPosition,
    required this.markers,
    required this.onTap,
    this.controller,
  });

  @override
  State<MapSample> createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.hybrid,
      markers: widget.markers,
      initialCameraPosition: CameraPosition(
        target: widget.initialPosition,
        zoom: 16,
      ),
      onTap: widget.onTap,
      onMapCreated: (GoogleMapController controller) {
        widget.controller?.complete(controller);
      },
    );
  }
}
