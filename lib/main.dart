import 'package:flutter/material.dart';
import 'package:route_tracking/features/google_map/view/google_map_screen.dart';

void main() {
  runApp(const RouteTrackingApp());
}

class RouteTrackingApp extends StatelessWidget {
  const RouteTrackingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GoogleMapScreen(),
    );
  }
}
