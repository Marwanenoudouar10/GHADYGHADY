import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/mock_backend.dart';
import 'package:myapp/screens/MapScreen/map_screen.dart';
import 'package:myapp/widgets/button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';

class DestinationScreen extends StatefulWidget {
  const DestinationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DestinationScreenState createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  GoogleMapController? _controller;
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  LatLng _initialPosition = const LatLng(33.9716, -6.8498);
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.settings,
          size: 40,
        ),
        backgroundColor: kMainColor,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: (controller) {
                    _controller = controller;
                  },
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 14,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId("currentLocation"),
                      position: _initialPosition,
                    )
                  },
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  height: 200,
                  child: Column(
                    children: [
                      TextField(
                        controller: _destinationController,
                        decoration: InputDecoration(
                          hintText: 'Destination',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _priceController,
                        decoration: InputDecoration(
                          hintText: 'MAD Suggest a price',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Button(
                        text: 'Submit',
                        onPressed: () {
                          Navigator.pushNamed(context, '/MapScreen');
                        },
                        fontSize: 20.0,
                        color: kMainColor,
                        colorText: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  void _submit(BuildContext context) async {
    final destination = _destinationController.text;
    final price = _priceController.text;

    if (destination.isEmpty || price.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter destination and price')),
      );
      return;
    }
    final response = await mockBackend(destination, price);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['success']) {
        final owners = jsonResponse['owners'];
        print('Owners: $owners');
        Navigator.pushNamed(context, '/CommandScreen');
      } else {}
    } else {
      // Handle error
    }
    print('Error: ${response.statusCode}');
  }
}
