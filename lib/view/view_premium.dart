import 'package:flutter/material.dart';

class ViewPremium extends StatefulWidget {
  const ViewPremium({super.key});

  @override
  State<ViewPremium> createState() => _ViewPremiumState();
}

class _ViewPremiumState extends State<ViewPremium> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text('Premium'),
        ],
      ),
    );
  }
}
