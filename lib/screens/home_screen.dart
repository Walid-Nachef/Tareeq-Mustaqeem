import 'package:flutter/material.dart';
import 'configuration_screen.dart';
import 'package:tareeq_mustaqeem/classes/GridItem.dart';
import 'package:tareeq_mustaqeem/screens/track_faraid.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tareeq Mustaqeem',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ConfigurationScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tareeq Mustaqeem'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Settings screen if you have one
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help & Feedback'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Help & Feedback screen if you have one
              },
            ),
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes),
            label: 'Trackers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuration',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int streakDays = 5; // Example streak, replace with actual data source

    List<GridItem> items = [
      GridItem(imagePath: 'lib/assets/rukuu.png', label: 'Faraa\'id\nالفرائض'),
      GridItem(imagePath: 'lib/assets/nawafil.png', label: 'Sunnah & Nawaafil\nالسنة و النوافل'),
      GridItem(imagePath: 'lib/assets/dhikr.png', label: 'Dhikr\nالذكر'),
      GridItem(imagePath: 'lib/assets/sadaqah.png', label: 'Good deeds\nالأعمال الصالحة'),
    ];

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Streak: $streakDays days',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 1.0,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return GridTile(
                child: InkWell(
                  onTap: () {
                    if (items[index].label.startsWith('Faraa\'id')) { // Assuming you tap the 'Faraa'id' button
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TrackFaraidScreen(),
                      ));
                    }
                  },
                  child: ClipOval(
                    child: Container(
                      color: Colors.white,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(items[index].imagePath, width: 80),
                            SizedBox(height: 8),
                            Text(
                              items[index].label,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

