import 'package:flutter/material.dart';
import 'screens/country_selection_screen.dart';

void main() {
  runApp(const HaberNoktasi());
}

class HaberNoktasi extends StatelessWidget {
  const HaberNoktasi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haber Noktası',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const CountrySelectionScreen(),
    );
  }
} 