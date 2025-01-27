import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  static const String _apiKey = '959ea5e7296a44b4a2191fb009b46f33'; // NewsAPI.org'dan alacağınız API anahtarı
  static const String _baseUrl = 'https://newsapi.org/v2';

  Future<List<Map<String, dynamic>>> getNews({
    required String country,
    String? city,
  }) async {
    try {
      // Ülke kodunu al
      String countryCode = _getCountryCode(country);
      
      // Arama terimi oluştur
      String q = city != null ? '$city news' : '';
      
      final response = await http.get(
        Uri.parse(
          '$_baseUrl/top-headlines?country=$countryCode&q=$q&pageSize=10&apiKey=$_apiKey',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['articles']);
      } else {
        throw Exception('Haberler yüklenirken bir hata oluştu. Hata kodu: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  String _getCountryCode(String country) {
    switch (country) {
      case 'Türkiye':
        return 'tr';
      case 'ABD':
        return 'us';
      case 'İngiltere':
        return 'gb';
      case 'Almanya':
        return 'de';
      case 'Fransa':
        return 'fr';
      default:
        return 'tr';
    }
  }
} 