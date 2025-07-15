import 'package:flutter/material.dart';
import 'package:train_reservation/constants.dart';

class StationListPage extends StatelessWidget {
  final String title;
  final String? excludedStation;

  const StationListPage({super.key, required this.title, this.excludedStation});

  @override
  Widget build(BuildContext context) {
    // Filter out the excluded station
    final List<String> availableStations = stationList
        .where((s) => s != excludedStation)
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        itemCount: availableStations.length,
        itemBuilder: (context, index) {
          final station = availableStations[index];
          return InkWell(
            onTap: () {
              Navigator.pop(context, station);
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              alignment: Alignment.centerLeft,
              child: Text(
                station,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
