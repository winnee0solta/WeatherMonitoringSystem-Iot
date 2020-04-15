class Location {
  String location;
  String deviceid;
  String devicekey;
  Location({this.deviceid, this.location, this.devicekey});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      deviceid: json['id'].toString(),
      location: json['location'].toString(),
      devicekey: json['device_key'].toString(),
    );
  }
}
