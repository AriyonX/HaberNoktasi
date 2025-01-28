import 'package:flutter/material.dart';
import '../services/news_service.dart';

class MainNewsScreen extends StatelessWidget {
  final String? selectedCity;
  final String selectedCountry;

  const MainNewsScreen({Key? key, this.selectedCity, required this.selectedCountry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("News")),
      body: Column(
        children: [
          Text("Selected Country: $selectedCountry, Selected City: $selectedCity")
        ],
      ),
    );
  }
}
class NewsScreen extends StatefulWidget {
  final String selectedCountry;
  final String? selectedCity;

  const NewsScreen({
    super.key,
    required this.selectedCountry,
    this.selectedCity,
  });

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final NewsService _newsService = NewsService();
  List<Map<String, dynamic>> news = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final newsData = await _newsService.getNews(
        country: widget.selectedCountry,
        city: widget.selectedCity,
      );
      if (mounted) {
        setState(() {
          news = newsData;
          isLoading = false;
        });
      }

      setState(() {
        news = newsData;
        isLoading = false;
      });
    } catch (e) {
      final errorMessage = 'Haberler yüklenirken bir hata oluştu: ${e.toString()}'; // Hata mesajını göster
      //print('Hata Detayı: $e'); // Hata detayını konsola yazdır
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)), // Hata mesajını SnackBar'da göster
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.selectedCountry} ${widget.selectedCity ?? ''} Haberleri'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchNews,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: fetchNews,
              child: ListView.builder(
                itemCount: news.length,
                itemBuilder: (context, index) {
                  final article = news[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        if (article['urlToImage'] != null)
                          Image.network(
                            article['urlToImage'],
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) {
                                return child;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: progress.expectedTotalBytes != null
                                        ? progress.cumulativeBytesLoaded /
                                            (progress.expectedTotalBytes ?? 1)
                                        : null,
                                  ),
                                );
                              }
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                const SizedBox.shrink(),
                          ),
                        ListTile(
                          title: Text(
                            article['title'] ?? 'Başlık yok',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              Text(article['description'] ?? 'Açıklama yok'),
                              const SizedBox(height: 8),
                              Text(
                                _formatDate(article['publishedAt']),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return '';
    try {
      final date = DateTime.parse(dateStr);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
    } catch (e) {
      return dateStr;
    }
  }
}
