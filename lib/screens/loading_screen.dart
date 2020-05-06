import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';
import 'package:location_permissions/location_permissions.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  WeatherModel weather = WeatherModel();
  bool isLocationServiceEnabled = false;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  Future<void> checkLocationPermission() async {
    PermissionStatus permission = await LocationPermissions().checkPermissionStatus();
    if (permission != PermissionStatus.granted) {
      permission = await LocationPermissions().requestPermissions();
      if (permission != PermissionStatus.granted) {
        setState(() {
          isLocationServiceEnabled = false;
        });
      }

      else {
        ServiceStatus serviceStatus = await LocationPermissions().checkServiceStatus();
        if (serviceStatus == ServiceStatus.disabled) {
          setState(() {
            isLocationServiceEnabled = false;
          });
        }

        else if (serviceStatus == ServiceStatus.enabled) {
          setState(() {
            isLocationServiceEnabled = true;
          });
        }
      }
    }

    else {
      ServiceStatus serviceStatus = await LocationPermissions().checkServiceStatus();
      if (serviceStatus == ServiceStatus.disabled) {
        setState(() {
          isLocationServiceEnabled = false;
        });
      }

      else if (serviceStatus == ServiceStatus.enabled) {
        setState(() {
          isLocationServiceEnabled = true;
        });
      }
    }
  }

  Future<void> getLocationData() async {
    // await checkLocationPermission();
    // if (!isLocationServiceEnabled) {
    //   return;
    // }

    var weatherData = await weather.getLocationweather();

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
