import 'package:flutter/material.dart';
import 'news_screen.dart';

class CitySelectionScreen extends StatefulWidget {
  final String selectedCountry;

  const CitySelectionScreen({
    super.key,
    required this.selectedCountry,
  });

  @override
  State<CitySelectionScreen> createState() => _CitySelectionScreenState();
}

class _CitySelectionScreenState extends State<CitySelectionScreen> {
  String? selectedCity;
  late List<String> cities;

  @override
  void initState() {
    super.initState();
    // Örnek şehir listesi - gerçek uygulamada ülkeye göre dinamik olarak yüklenebilir
    cities = widget.selectedCountry == 'Türkiye'
        ? ['İstanbul', 'Ankara', 'İzmir', 'Bursa', 'Antalya']
        : ['Şehir verisi yükleniyor...'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Şehir Seçimi (Opsiyonel)'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cities.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(cities[index]),
                  leading: const Icon(Icons.location_city),
                  selected: selectedCity == cities[index],
                  onTap: () {
                    setState(() {
                      selectedCity = cities[index];
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsScreen(
                      selectedCountry: widget.selectedCountry,
                      selectedCity: selectedCity,
                    ),
                  ),
                );
              },
              child: const Text('Devam Et'),
            ),
          ),
        ],
      ),
    );
  }
} 