import 'package:http/http.dart' as http;
import '../../models/weather_model.dart';

class WeatherRepository {
  Future<WeatherModel?> getWeather(String city) async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=43ea6baaad7663dc17637e22ee6f78f2'));

      if (response.statusCode == 200) {
        return weatherModelFromJson(response.body);
      }
    } catch (e) {
    } finally {
      client.close();
    }
    return null;
  }
}


// var jsonMap = jsonDecode(response.body);
// print('coordinates: ${jsonMap['coord']}');
// print('weather: ${jsonMap['weather']}');
// print('base: ${jsonMap['base']}');
// print('main: ${jsonMap['main']}');
// print('visibility: ${jsonMap['visibility']}');
// print('wind: ${jsonMap['wind']}');
// print('cloud: ${jsonMap['cloud']}');
// print('dt: ${jsonMap['dt']}');
// print('sys: ${jsonMap['sys']}');
// print('timezone: ${jsonMap['timezone']}');
// print('id: ${jsonMap['id']}');
// print('name : ${jsonMap['name']}');
// print('cod: ${jsonMap['cod']}');