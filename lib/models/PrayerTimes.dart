import 'dart:convert';
import 'package:intl/intl.dart';

class PrayerTimes {
  final DateTime fajr, sunrise, dhuhr, asr, sunset, maghrib, isha;
  final String hijriDate;
  final String gregorianDate;

  PrayerTimes({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.sunset,
    required this.maghrib,
    required this.isha,
    required this.hijriDate,
    required this.gregorianDate,
  });

  factory PrayerTimes.fromJson(Map<String, dynamic> json) {
    DateTime parsePrayerTime(String time) {
      final format = DateFormat('HH:mm');
      return format.parse(time);
    }

    String formatHijriDate(Map<String, dynamic> hijriJson) {
      return "${hijriJson['day']} ${hijriJson['month']['en']} ${hijriJson['year']}";
    }

    String formatGregorianDate(Map<String, dynamic> gregorianJson) {
      return gregorianJson['date'];
    }

    final timings = json['timings'];
    final hijri = json['date']['hijri'];
    final gregorian = json['date']['gregorian'];

    return PrayerTimes(
      fajr: parsePrayerTime(timings['Fajr']),
      sunrise: parsePrayerTime(timings['Sunrise']),
      dhuhr: parsePrayerTime(timings['Dhuhr']),
      asr: parsePrayerTime(timings['Asr']),
      sunset: parsePrayerTime(timings['Sunset']),
      maghrib: parsePrayerTime(timings['Maghrib']),
      isha: parsePrayerTime(timings['Isha']),
      hijriDate: formatHijriDate(hijri),
      gregorianDate: formatGregorianDate(gregorian),
    );
  }
}