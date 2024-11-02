import 'package:flutter/material.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Customers'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: const [
            ListTile(
              title: Text('Nnamani David'),
              subtitle: Text('Status: Settled'),
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
              title: Text('Nwadinigwe Victor'),
              subtitle: Text('Status: Unsettled'),
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
              title: Text('Nwakanma Ogechi'),
              subtitle: Text('Status: Settled'),
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
