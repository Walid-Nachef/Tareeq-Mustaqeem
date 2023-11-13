import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tareeq_mustaqeem/models/PrayerTimes.dart';

class PrayerTimesService {
  Future<PrayerTimes> fetchPrayerTimes() async {
    try {
      final url = Uri.parse('http://api.aladhan.com/v1/timingsByCity?city=Rabat&country=Morocco&method=3');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['code'] == 200 && data['data'] != null) {
          return PrayerTimes.fromJson(data['data']);
        } else {
          throw Exception('API returned an error: ${data['status']}');
        }
      } else {
        throw Exception('Failed to load prayer times with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching prayer times: $e');
    }
  }
}
