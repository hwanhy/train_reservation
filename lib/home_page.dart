// lib/home_page.dart

import 'package:flutter/material.dart';
import 'package:train_reservation/seat_page.dart';
import 'package:train_reservation/station_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _departureStation;
  String? _arrivalStation;

  @override
  Widget build(BuildContext context) {
    final bool isReadyToSelectSeat =
        _departureStation != null && _arrivalStation != null;

    return Scaffold(
      // 고정 색상 대신 테마 색상 사용
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('기차 예매')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStationSelector(
                    context: context,
                    title: '출발역',
                    station: _departureStation,
                    onTap: () async {
                      final selected = await Navigator.push<String>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => StationListPage(
                            title: '출발역',
                            excludedStation: _arrivalStation,
                          ),
                        ),
                      );
                      if (selected != null) {
                        setState(() {
                          _departureStation = selected;
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: 50,
                    child: VerticalDivider(
                      width: 2,
                      thickness: 2,
                      color: Colors.grey[400],
                    ),
                  ),
                  _buildStationSelector(
                    context: context,
                    title: '도착역',
                    station: _arrivalStation,
                    onTap: () async {
                      final selected = await Navigator.push<String>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => StationListPage(
                            title: '도착역',
                            excludedStation: _departureStation,
                          ),
                        ),
                      );
                      if (selected != null) {
                        setState(() {
                          _arrivalStation = selected;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isReadyToSelectSeat
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SeatPage(
                            departureStation: _departureStation!,
                            arrivalStation: _arrivalStation!,
                          ),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                '좌석 선택',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStationSelector({
    required BuildContext context,
    required String title,
    required String? station,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              station ?? '선택',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: station != null
                    ? Theme.of(context).textTheme.bodyLarge?.color
                    : Colors.grey[400],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
