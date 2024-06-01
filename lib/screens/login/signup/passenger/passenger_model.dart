class PassengerModel {
  String? uid;
  String? email;
  String? fullName;
  String? phoneNumber;

  PassengerModel({this.uid, this.email, this.fullName, this.phoneNumber});

  // receiving data from server
  factory PassengerModel.fromMap(map) {
    return PassengerModel(
      uid: map['uid'],
      email: map['email'],
      fullName: map['fullName'],
      phoneNumber: map['phoneNumber'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email.toString().trim(),
      'fullName': fullName,
      'phoneNumber': phoneNumber,
    };
  }
}
