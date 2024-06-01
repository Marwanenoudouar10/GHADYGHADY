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
