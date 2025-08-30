import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  LatLng _center = const LatLng(36.2021, 37.1343); // إحداثيات حلب الافتراضية
  Position? _currentPosition;
  bool _isLoading = false;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // دالة للحصول على الموقع الحالي
  Future<void> _getCurrentLocation() async {
    setState(() => _isLoading = true);

    try {
      // التحقق من الصلاحيات
      final status = await Permission.location.request();
      if (status.isDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم رفض إذن الموقع'))
        );
        return;
      }

      // جلب الموقع الحالي
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high
      );

      setState(() {
        _currentPosition = position;
        _center = LatLng(position.latitude, position.longitude);
      });

      // تحريك الكاميرا إلى الموقع الجديد
      mapController.animateCamera(
        CameraUpdate.newLatLng(_center),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ في جلب الموقع: ${e.toString()}'))
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الموقع على الخريطة'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _getCurrentLocation,
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 15.0, // تكبير أكبر للموقع الحالي
            ),
            markers: {
              if (_currentPosition != null)
                Marker(
                  markerId: const MarkerId('currentLocation'),
                  position: _center,
                  infoWindow: const InfoWindow(title: 'موقعك الحالي'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue,
                  ),
                ),
              Marker(
                markerId: const MarkerId('problemLocation'),
                position: const LatLng(36.2021, 37.1343),
                infoWindow: const InfoWindow(title: 'موقع المشكلة'),
              ),
            },
            myLocationEnabled: true, // يظهر زر الموقع الحالي المدمج
            myLocationButtonEnabled: false, // نعطله لأننا أضفنا زرنا الخاص
          ),
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentLocation,
        child: const Icon(Icons.my_location),
        tooltip: 'الموقع الحالي',
      ),
    );
  }
}