class PrayerTimes {
  DateTime fajr, dhuhr, asr, maghrib, isha;

  PrayerTimes({
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  factory PrayerTimes.fromJson(Map<String, dynamic> json) {
    // Assuming that 'Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha' are keys in the json map
    // and their values are the times as strings.
    return PrayerTimes(
      fajr: DateTime.parse(json['Fajr']),
      dhuhr: DateTime.parse(json['Dhuhr']),
      asr: DateTime.parse(json['Asr']),
      maghrib: DateTime.parse(json['Maghrib']),
      isha: DateTime.parse(json['Isha']),
    );
  }
}
