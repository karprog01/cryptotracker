import 'package:appsdevtycoon/clist.dart';
import 'package:flutter/material.dart';

void main() => runApp(AppsDevTycoon());

class AppsDevTycoon extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CryptoTracker',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: CList()
    );
  }
}