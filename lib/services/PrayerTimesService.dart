import 'dart:convert';
import 'package:http/http.dart' as http;
import 'PrayerTimes.dart';

class PrayerTimesService {
  Future<PrayerTimes> fetchPrayerTimes() async {
    var url = Uri.parse('http://api.aladhan.com/v1/timingsByCity?city=Rabat&country=Morocco&method=2');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      // Assuming the API returns a 'data' object that contains a 'timings' object
      return PrayerTimes.fromJson(data['data']['timings']);
    } else {
      throw Exception('Failed to load prayer times');
    }
  }
}
