import 'package:flutter/material.dart';

class CarsPage extends StatelessWidget {
  const CarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cars Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: const [
            ListTile(
              title: Text('Lexus Rx350'),
              subtitle: Text('NWA 62 HP'),
              trailing: Text('17th Oct, 2024'),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.greenAccent,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text('Toyota Rx350'),
              subtitle: Text('RRT 62 HP'),
              trailing: Text('12th June, 2024'),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.greenAccent,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text('Benz c300'),
              subtitle: Text('IMO 2100'),
              trailing: Text('1st Nov, 2024'),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.greenAccent,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
