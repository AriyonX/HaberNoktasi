import 'package:flutter/material.dart';
import 'city_selection_screen.dart';

class CountrySelectionScreen extends StatefulWidget {
  const CountrySelectionScreen({super.key});

  @override
  State<CountrySelectionScreen> createState() => _CountrySelectionScreenState();
}

class _CountrySelectionScreenState extends State<CountrySelectionScreen> {
  String? selectedCountry;
  final List<Map<String, String>> countries = [
    {'name': 'Türkiye', 'code': 'tr'},
    {'name': 'Amerika Birleşik Devletleri', 'code': 'us'},
    {'name': 'Birleşik Krallık', 'code': 'gb'},
    {'name': 'Almanya', 'code': 'de'},
    {'name': 'Fransa', 'code': 'fr'},
    {'name': 'İtalya', 'code': 'it'},
    {'name': 'İspanya', 'code': 'es'},
    {'name': 'Portekiz', 'code': 'pt'},
    {'name': 'Hollanda', 'code': 'nl'},
    {'name': 'Belçika', 'code': 'be'},
    {'name': 'İsviçre', 'code': 'ch'},
    {'name': 'Avusturya', 'code': 'at'},
    {'name': 'İsveç', 'code': 'se'},
    {'name': 'Norveç', 'code': 'no'},
    {'name': 'Danimarka', 'code': 'dk'},
    {'name': 'Finlandiya', 'code': 'fi'},
    {'name': 'Rusya', 'code': 'ru'},
    {'name': 'Polonya', 'code': 'pl'},
    {'name': 'Çek Cumhuriyeti', 'code': 'cz'},
    {'name': 'Yunanistan', 'code': 'gr'},
    {'name': 'Macaristan', 'code': 'hu'},
    {'name': 'Romanya', 'code': 'ro'},
    {'name': 'Bulgaristan', 'code': 'bg'},
    {'name': 'Ukrayna', 'code': 'ua'},
    {'name': 'Japonya', 'code': 'jp'},
    {'name': 'Güney Kore', 'code': 'kr'},
    {'name': 'Çin', 'code': 'cn'},
    {'name': 'Hindistan', 'code': 'in'},
    {'name': 'Avustralya', 'code': 'au'},
    {'name': 'Yeni Zelanda', 'code': 'nz'},
    {'name': 'Kanada', 'code': 'ca'},
    {'name': 'Meksika', 'code': 'mx'},
    {'name': 'Brezilya', 'code': 'br'},
    {'name': 'Arjantin', 'code': 'ar'},
    {'name': 'Güney Afrika', 'code': 'za'},
    {'name': 'İsrail', 'code': 'il'},
    {'name': 'Mısır', 'code': 'eg'},
    {'name': 'Suudi Arabistan', 'code': 'sa'},
    {'name': 'Birleşik Arap Emirlikleri', 'code': 'ae'},
    {'name': 'Endonezya', 'code': 'id'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ülke Seçimi'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Ülke Ara...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  // Arama fonksiyonu eklenebilir
                });
              },
            ),
          ),
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
                  title: Text(countries[index]['name']!),
                  leading: const Icon(Icons.flag),
                  selected: selectedCountry == countries[index]['name'],
                  onTap: () {
                    setState(() {
                      selectedCountry = countries[index]['name'];
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