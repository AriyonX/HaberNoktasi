import 'package:flutter/material.dart';
import 'city_selection_screen.dart';

class CountrySelectionScreen extends StatefulWidget {
  const CountrySelectionScreen({super.key});

  @override
  State<CountrySelectionScreen> createState() => _CountrySelectionScreenState();
}

class _CountrySelectionScreenState extends State<CountrySelectionScreen> {
  String? selectedCountry;
  final List<String> countries = ['Türkiye', 'ABD', 'İngiltere', 'Almanya', 'Fransa'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ülke Seçimi'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Lütfen bir ülke seçiniz',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(countries[index]),
                  leading: const Icon(Icons.flag),
                  selected: selectedCountry == countries[index],
                  onTap: () {
                    setState(() {
                      selectedCountry = countries[index];
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CitySelectionScreen(
                          selectedCountry: selectedCountry!,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 