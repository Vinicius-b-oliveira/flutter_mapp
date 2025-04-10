import 'package:flutter/material.dart';

class ExpandedFlexiblePage extends StatelessWidget {
  const ExpandedFlexiblePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 20.0,
                  color: Colors.orange,
                  child: Text("Testando expanded"),
                ),
              ),
              Flexible(
                child: Container(
                  height: 20.0,
                  color: Colors.teal,
                  child: Text("Testando flexible"),
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Flexible(
                child: Container(
                  height: 20.0,
                  color: Colors.orange,
                  child: Text("Testando expanded"),
                ),
              ),
              Expanded(
                child: Container(
                  height: 20.0,
                  color: Colors.teal,
                  child: Text("Testando flexible"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
