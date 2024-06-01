import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class DriverModel {
  String? uid;
  String? email;
  String? fullName;
  String? phoneNumber;
  String? picPerso;
  String? cinRecto;
  String? cinVerso;
  String? permisRecto;
  String? permisVerso;
  String? expDate;
  String? marqueMotor;
  String? picMotor;
  double? latitude;
  double? longitude;

  DriverModel({
    this.uid,
    this.email,
    this.fullName,
    this.phoneNumber,
    this.picPerso,
    this.cinRecto,
    this.cinVerso,
    this.permisRecto,
    this.permisVerso,
    this.expDate,
    this.marqueMotor,
    this.picMotor,
    this.latitude,
    this.longitude,
  });

  factory DriverModel.fromMap(Map<String, dynamic> map) {
    return DriverModel(
      uid: map['uid'],
      email: map['email'],
      fullName: map['fullName'],
      phoneNumber: map['phoneNumber'],
      picPerso: map['picPerso'],
      cinRecto: map['cinRecto'],
      cinVerso: map['cinVerso'],
      permisRecto: map['permisRecto'],
      permisVerso: map['permisVerso'],
      expDate: map['expDate'],
      marqueMotor: map['marqueMotor'],
      picMotor: map['picMotor'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  get lat => null;

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'picPerso': picPerso,
      'cinRecto': cinRecto,
      'cinVerso': cinVerso,
      'permisRecto': permisRecto,
      'permisVerso': permisVerso,
      'expDate': expDate,
      'marqueMotor': marqueMotor,
      'picMotor': picMotor,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class PassengerModel {
  String? uid;
  String? email;
  String? fullName;
  String? phoneNumber;

  PassengerModel({this.uid, this.email, this.fullName, this.phoneNumber});

  factory PassengerModel.fromMap(Map<String, dynamic> map) {
    return PassengerModel(
      uid: map['uid'],
      email: map['email'],
      fullName: map['fullName'],
      phoneNumber: map['phoneNumber'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
    };
  }
}

double generateRandomPrice() {
  return Random().nextDouble() * (50.0 - 5.0) + 5.0;
}

double suggestPrice({required double lat, required double lng}) {
  final priceAdjustment = lat > 34.025 ? 5.0 : -2.0;
  return generateRandomPrice() + priceAdjustment;
}

Future<http.Response> mockBackend(String destination, String price) async {
  await Future.delayed(Duration(seconds: 2));

  final mockResponseData = {
    'success': true,
    'drivers': [
      {
        'uid': '1',
        'email': 'john.doe@example.com',
        'fullName': 'John Doe',
        'phoneNumber': '5551234567',
        'picPerso': 'profile1.jpg',
        'cinRecto': 'cin1.jpg',
        'cinVerso': 'cin2.jpg',
        'permisRecto': 'permis1.jpg',
        'permisVerso': 'permis2.jpg',
        'expDate': '2025-12-31',
        'marqueMotor': 'Yamaha',
        'picMotor': 'motor1.jpg',
        'latitude': 34.022882,
        'longitude': -6.842650,
      },
      {
        'uid': '2',
        'email': 'jane.smith@example.com',
        'fullName': 'Jane Smith',
        'phoneNumber': '555987654',
        'cinRecto': 'cin3.jpg',
        'cinVerso': 'cin4.jpg',
        'permisRecto': 'permis3.jpg',
        'permisVerso': 'permis4.jpg',
        'expDate': '2024-11-30',
        'marqueMotor': 'Honda',
        'picMotor': 'motor2.jpg',
        'latitude': 34.027000,
        'longitude': -6.841000,
      },
      {
        'uid': '3',
        'email': 'mike.johnson@example.com',
        'fullName': 'Mike Johnson',
        'phoneNumber': '5558765432',
        'picPerso': 'profile3.jpg',
        'cinRecto': 'cin5.jpg',
        'cinVerso': 'cin6.jpg',
        'permisRecto': 'permis5.jpg',
        'permisVerso': 'permis6.jpg',
        'expDate': '2026-01-15',
        'marqueMotor': 'Suzuki',
        'picMotor': 'motor3.jpg',
        'latitude': 34.023500,
        'longitude': -6.848000,
      },
      {
        'uid': '4',
        'email': 'emily.davis@example.com',
        'fullName': 'Emily Davis',
        'phoneNumber': '5556543210',
        'picPerso': 'profile4.jpg',
        'cinRecto': 'cin7.jpg',
        'cinVerso': 'cin8.jpg',
        'permisRecto': 'permis7.jpg',
        'permisVerso': 'permis8.jpg',
        'expDate': '2023-09-10',
        'marqueMotor': 'Kawasaki',
        'picMotor': 'motor4.jpg',
        'latitude': 34.020000,
        'longitude': -6.850000,
      },
    ],
    'passengers': [
      {
        'uid': '1',
        'email': 'alice.williams@example.com',
        'fullName': 'Alice Williams',
        'phoneNumber': '5554321098',
      },
      {
        'uid': '2',
        'email': 'bob.brown@example.com',
        'fullName': 'Bob Brown',
        'phoneNumber': '5553210987',
      },
    ]
  };

  return http.Response(jsonEncode(mockResponseData), 200);
}

void main() async {
  // Example usage of the mock backend function
  final response = await mockBackend('Destination Example', '20.0');
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['success']) {
      List<DriverModel> drivers = (data['drivers'] as List)
          .map((driver) => DriverModel.fromMap(driver))
          .toList();
      List<PassengerModel> passengers = (data['passengers'] as List)
          .map((passenger) => PassengerModel.fromMap(passenger))
          .toList();

      print('Drivers:');
      drivers.forEach((driver) {
        print(
            '${driver.fullName} (${driver.email}) at (${driver.latitude}, ${driver.longitude})');
      });

      print('Passengers:');
      passengers.forEach((passenger) {
        print('${passenger.fullName} (${passenger.email})');
      });
    } else {
      print('Failed to fetch data');
    }
  } else {
    print('Error: ${response.statusCode}');
  }
}
