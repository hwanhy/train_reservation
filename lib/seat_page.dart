import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeatPage extends StatefulWidget {
  final String departureStation;
  final String arrivalStation;

  const SeatPage({
    super.key,
    required this.departureStation,
    required this.arrivalStation,
  });

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  String? _selectedSeat; // e.g., "A3", "C15"

  void _onSeatTap(String seatId) {
    setState(() {
      _selectedSeat = (_selectedSeat == seatId) ? null : seatId;
    });
  }

  void _showBookingDialog() {
    if (_selectedSeat == null) return;

    showCupertinoDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return CupertinoAlertDialog(
          title: const Text('예매 하시겠습니까?'),
          content: Text('좌석: $_selectedSeat'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              child: const Text('취소'),
              onPressed: () => Navigator.pop(dialogContext),
            ),
            CupertinoDialogAction(
              child: const Text('확인'),
              onPressed: () {
                Navigator.pop(dialogContext); // Close dialog
                Navigator.pop(context); // Go back to HomePage
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('좌석 선택')),
      body: Column(
        children: [
          _buildStationInfo(),
          _buildSeatLegend(),
          const SizedBox(height: 8),
          Expanded(child: _buildSeatGrid()),
          _buildBookingButton(),
        ],
      ),
    );
  }

  Widget _buildStationInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.departureStation,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(
              Icons.arrow_circle_right_outlined,
              color: Colors.black,
              size: 30,
            ),
          ),
          Text(
            widget.arrivalStation,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeatLegend() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildLegendItem(Colors.purple, '선택됨'),
          const SizedBox(width: 20),
          _buildLegendItem(Colors.grey[300]!, '선택 안 됨'),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(width: 4),
        Text(text),
      ],
    );
  }

  Widget _buildSeatGrid() {
    const int totalRows = 20;
    const List<String> columns = ['A', 'B', 'C', 'D'];

    Widget buildRow(List<Widget> children) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      );
    }

    Widget buildLabel(String label) => SizedBox(
      width: 50,
      height: 50,
      child: Center(child: Text(label, style: const TextStyle(fontSize: 18))),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        itemCount: totalRows + 1, // +1 for the header row
        itemBuilder: (context, rowIndex) {
          // Header Row
          if (rowIndex == 0) {
            return buildRow([
              const SizedBox(width: 50),
              buildLabel(columns[0]),
              const SizedBox(width: 4),
              buildLabel(columns[1]),
              const SizedBox(width: 20),
              buildLabel(columns[2]),
              const SizedBox(width: 4),
              buildLabel(columns[3]),
            ]);
          }
          // Seat Rows
          final rowNum = rowIndex;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: buildRow([
              buildLabel('$rowNum'),
              ...List.generate(columns.length, (colIndex) {
                final seatId = '${columns[colIndex]}$rowNum';
                return Padding(
                  padding: EdgeInsets.only(
                    left: colIndex == 2 ? 20 : (colIndex == 0 ? 0 : 4),
                    right: colIndex == 1 ? 20 : (colIndex == 3 ? 0 : 4),
                  ),
                  child: _buildSeatItem(seatId, _selectedSeat == seatId),
                );
              }),
            ]),
          );
        },
      ),
    );
  }

  Widget _buildSeatItem(String seatId, bool isSelected) {
    return InkWell(
      onTap: () => _onSeatTap(seatId),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple : Colors.grey[300]!,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildBookingButton() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        onPressed: _selectedSeat != null ? _showBookingDialog : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text(
          '예매 하기',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
