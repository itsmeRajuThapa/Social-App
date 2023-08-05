import 'package:flutter/material.dart';
import 'package:project/Model/userModel.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key, UserModel? loginUsers});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Market'),
      ),
    );
  }
}
