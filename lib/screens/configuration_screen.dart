import 'package:flutter/material.dart';
import 'package:tareeq_mustaqeem/classes/GridItem.dart';

class ConfigurationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Only three buttons for Configuration
    List<GridItem> items = [
      GridItem(imagePath: 'lib/assets/nawafil.png', label: 'Sunnah & Nawafil\nالسنة و النوافل'),
      GridItem(imagePath: 'lib/assets/dhikr.png', label: 'Dhikr\nالذكر'),
      GridItem(imagePath: 'lib/assets/sadaqah.png', label: 'Good deeds\nالأعمال الصالحة'),
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 1.0,
          ),
          itemCount: items.length + 1, // Add one more item for the invisible container
          itemBuilder: (context, index) {
            if (index == items.length) { // The last actual item
              return Center(
                child: GridTile(
                  child: Opacity(
                    opacity: 0.0, // Make the extra container invisible
                    child: Container(),
                  ),
                ),
              );
            }
            if (index > items.length) { // After the last actual item, place an empty container
              return Container();
            }
            return GridTile(
              child: InkWell(
                onTap: () {
                  // Handle the tap
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
    );
  }
}
