class WeatherResponse {
  String city, description;
  double temperature;

  WeatherResponse({this.city, this.description, this.temperature});

  factory WeatherResponse.fromJSON(Map<String, dynamic> json) {
    return WeatherResponse(
      city: json['name'],
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'],
    );
  }
}