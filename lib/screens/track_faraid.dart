import 'dart:async';
import 'package:flutter/material.dart';
import '../services/PrayerTimesService.dart';
import '../models/PrayerTimes.dart';
import '../widgets/PrayerButton.dart';

class TrackFaraidScreen extends StatefulWidget {
  @override
  _TrackFaraidScreenState createState() => _TrackFaraidScreenState();
}

class _TrackFaraidScreenState extends State<TrackFaraidScreen> {
  List<bool> isSelected = [false, false, false, false, false];
  late Future<PrayerTimes> _prayerTimesFuture;
  String _nextPrayer = '';
  String _countdown = '';

  @override
  void initState() {
    super.initState();
    _prayerTimesFuture = _fetchPrayerTimes();
  }

  Future<PrayerTimes> _fetchPrayerTimes() async {
    PrayerTimesService service = PrayerTimesService();
    return await service.fetchPrayerTimes();
  }

  void _determineNextPrayerAndCountdown(PrayerTimes prayerTimes) {
    final now = DateTime.now();
    Map<String, DateTime> prayers = {
      'Fajr': prayerTimes.fajr,
      'Dhuhr': prayerTimes.dhuhr,
      'Asr': prayerTimes.asr,
      'Maghrib': prayerTimes.maghrib,
      'Isha': prayerTimes.isha,
    };
    var sortedPrayers = prayers.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));
    for (var prayer in sortedPrayers) {
      if (now.isBefore(prayer.value)) {
        _nextPrayer = prayer.key;
        _countdown = _formatDuration(prayer.value.difference(now));
        break;
      }
    }
  }

  String _formatDuration(Duration duration) {
    // Updated to only display hours and minutes
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tareeq Mustaqeem'),
      ),
      body: Column(
        children: <Widget>[
          // The next prayer and countdown display
          FutureBuilder<PrayerTimes>(
            future: _prayerTimesFuture,
            builder: (context, snapshot) {
              // Default placeholder content
              String nextPrayer = "Loading...";
              String countdown = "";

              // Update the content if data is available
              if (snapshot.hasData && snapshot.data != null) {
                _determineNextPrayerAndCountdown(snapshot.data!);
                nextPrayer = 'Next Prayer: $_nextPrayer';
                countdown = 'Countdown: $_countdown';
              } else if (snapshot.hasError) {
                nextPrayer = "Error: ${snapshot.error}";
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    Text(nextPrayer, style: TextStyle(fontSize: 24)),
                    Text(countdown, style: TextStyle(fontSize: 20)),
                  ],
                ),
              );
            },
          ),
          Divider(),
          FutureBuilder<PrayerTimes>(
            future: _prayerTimesFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Today\'s Date:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Hijri: ${snapshot.data!.hijriDate}'),
                      Text('Gregorian: ${snapshot.data!.gregorianDate}'),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
          Divider(),
          // Prayer buttons in a single row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (index) {
              // Replace with your actual data and labels
              List<String> labels = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];
              List<String> initials = ['F', 'D', 'A', 'M', 'I'];

              return PrayerButton(
                label: initials[index],
                isSelected: isSelected[index],
                onTap: () {
                  setState(() {
                    isSelected[index] = !isSelected[index];
                  });
                },
                initial: '',
              );
            }),
          ),
        ],
      ),
    );
  }
}
