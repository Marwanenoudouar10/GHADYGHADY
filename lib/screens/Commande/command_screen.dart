import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/mock_backend.dart'
    as backend; // Use prefix 'backend' for mock_backend
import 'package:myapp/screens/UserProfile/user_profile_screen.dart';
import 'package:myapp/screens/login/signup/driver/driver_model.dart'
    as model; // Use prefix 'model' for driver_model
import 'package:myapp/widgets/Increment_decrement_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class CommandScreen extends StatefulWidget {
  const CommandScreen({super.key});

  @override
  _CommandScreenState createState() => _CommandScreenState();
}

class _CommandScreenState extends State<CommandScreen> {
  GoogleMapController? _controller;
  LatLng _initialPosition = LatLng(33.9716, -6.8498);
  bool _loading = true;
  int _price = 15;
  List<model.DriverModel> _drivers = [];
  Set<Polyline> _polylines = {};
  LatLng? _destination;
  BitmapDescriptor? _carIcon;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _fetchDrivers();
    _loadCarIcon();
  }

  Future<void> _getCurrentLocation() async {
    var status = await Permission.location.request();

    if (status.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _initialPosition = LatLng(position.latitude, position.longitude);
        _loading = false;
      });
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _fetchDrivers() async {
    final response = await backend.mockBackend("destination", "price");
    final responseData = jsonDecode(response.body);
    if (responseData['success']) {
      List<model.DriverModel> drivers = [];
      for (var driverData in responseData['drivers']) {
        drivers.add(model.DriverModel.fromMap(driverData));
      }
      setState(() {
        _drivers = drivers;
      });
    } else {
      print('Failed to fetch drivers');
    }
  }

  Future<void> _loadCarIcon() async {
    _carIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)),
        'assets/icons/car_logo.png');
  }

  void _drawPolylineToNearestDriver() {
    if (_drivers.isEmpty || _destination == null) return;

    double nearestDistance = double.infinity;
    LatLng nearestDriverLocation = const LatLng(0, 0);
    for (var driver in _drivers) {
      double distance = Geolocator.distanceBetween(
        _destination!.latitude,
        _destination!.longitude,
        driver.latitude!,
        driver.longitude!,
      );
      if (distance < nearestDistance) {
        nearestDistance = distance;
        nearestDriverLocation = LatLng(driver.latitude!, driver.longitude!);
      }
    }

    _polylines.clear();
    _polylines.add(Polyline(
      polylineId: const PolylineId('destinationPolyline'),
      color: Colors.blue,
      points: [_destination!, nearestDriverLocation],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.settings),
        backgroundColor: kMainColor,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: (controller) {
                    _controller = controller;
                    _drawPolylineToNearestDriver();
                  },
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 14,
                  ),
                  markers: _drivers.map((driver) {
                    return Marker(
                      markerId: MarkerId(driver.uid.toString()),
                      position: LatLng(driver.latitude!, driver.longitude!),
                      icon: _carIcon ?? BitmapDescriptor.defaultMarker,
                      infoWindow: InfoWindow(title: driver.fullName),
                      onTap: () {
                        // Navigate to UserProfileScreen when marker is tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserProfileScreen(
                              driver: driver,
                            ),
                          ),
                        );
                      },
                    );
                  }).toSet(),
                  polylines: _polylines,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Row(
                      children: [
                        IncrementDecrementButton(
                          incDec: '-',
                          updatePrice: _updatePrice,
                        ),
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Recherche des conducteurs ...',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 10),
                              const Text(
                                'Votre offre',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove, color: Colors.red),
                                    onPressed: () {
                                      _updatePrice(-15);
                                    },
                                  ),
                                  Text(
                                    '$_price MAD',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add, color: Colors.orange),
                                    onPressed: () {
                                      _updatePrice(15);
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: Colors.white,
                                  side: BorderSide(color: Colors.black),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text('Annuler la commande'),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 0),
                          child: IncrementDecrementButton(
                            incDec: '+',
                            updatePrice: _updatePrice,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  void _updatePrice(int amount) {
    setState(() {
      _price += amount;
      if (_price < 0) _price = 0;
    });
  }
}
