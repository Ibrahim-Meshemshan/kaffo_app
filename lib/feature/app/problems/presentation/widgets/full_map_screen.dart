import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class FullMapScreen extends StatefulWidget {
  final LatLng initialPosition;

  const FullMapScreen({super.key, required this.initialPosition});

  @override
  State<FullMapScreen> createState() => _FullMapScreenState();
}

class _FullMapScreenState extends State<FullMapScreen> {
  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تحديد الموقع")),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: widget.initialPosition,
          zoom: 14,
        ),
        onTap: (latLng) {
          setState(() {
            _pickedLocation = latLng;
          });
        },
        markers: _pickedLocation == null
            ? {}
            : {
          Marker(
            markerId: const MarkerId("picked"),
            position: _pickedLocation!,
            infoWindow: const InfoWindow(title: "المكان المحدد"),
          )
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          if (_pickedLocation != null) {
            Navigator.pop(context, _pickedLocation);
          }
        },
        child: const Icon(Icons.check, color: Colors.white),
      ),
    );
  }
}
