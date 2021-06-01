import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherResponse{

  String url;
  WeatherResponse(this.url);

  Future getData() async {
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      String data = response.body;
      return json.decode(data);
    }else
      print(response.statusCode);
  }
}