class WeatherStat {
  String deviceid;
  String devicekey;
  String location;
  String temperature;
  String pressure;
  String rain;
  String humidity;
  String soilmoisture;
  String updatedat;

  WeatherStat({
    this.deviceid,
    this.devicekey,
    this.location,
    this.temperature,
    this.pressure,
    this.rain,
    this.humidity,
    this.soilmoisture,
    this.updatedat,
  });

  factory WeatherStat.fromJson(Map<String, dynamic> json) {
    return WeatherStat(
      deviceid: json['device_id'].toString(),
      devicekey: json['device_key'].toString(),
      location: json['location'].toString(),
      temperature: json['temperature'].toString(),
      pressure: json['pressure'].toString(),
      rain: json['rain'].toString(),
      humidity: json['humidity'].toString(),
      soilmoisture: json['soil_moisture'].toString(),
      updatedat: json['updated_at'].toString(),
    );
  }
}
