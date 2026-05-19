import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class PermissionsDemo extends StatefulWidget {
  const PermissionsDemo({super.key});

  @override
  State<PermissionsDemo> createState() => _PermissionsDemoState();
}

class _PermissionsDemoState extends State<PermissionsDemo> {
  String _message = '';


  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    
    // 1. check if GPS is turn on
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {   
      setState(() {
        _message = 'GPD is not enabled. Please enable it and try again';
      });
      return;
    }

    // 2. check if the app has permission to use GPS
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied){
      // ask permission to user
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied){
        setState(() {
          _message = 'GPS permission was denied.';
        });
        return;
      }
      
    } 

    if (permission == LocationPermission.deniedForever){
      setState(() {
        _message = 'GPS permission is permanently denied. Please enable it in your phone settings';
      });
      return;
    }


    // 3. if we have permission, get the GPS coordinates
    setState(() {
      _message = 'Fetching coordinates...';
    });

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _message = 'Latitude: ${position.latitude}\n Longitude: ${position.longitude}';
    });
  
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text( _message, style: TextStyle(fontSize: 30)),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed:_getCurrentLocation,
              child: Text('Find my location')),
          ],
      ),
    )
    );
  }



}