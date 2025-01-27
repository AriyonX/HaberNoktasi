import 'package:flutter/material.dart';
import '../services/news_service.dart';

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

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    try {
      final newsData = await _newsService.getNews(
        country: widget.selectedCountry,
        city: widget.selectedCity,
      );
      
      setState(() {
        news = newsData;
        isLoading = false;
      });
    } catch (e) {
      //print('Haberler yüklenirken bir hata oluştu:');
      const errorMessage = 'Haberler yüklenirken bir hata oluştu';
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(errorMessage)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.selectedCountry} Haberleri'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                isLoading = true;
              });
              fetchNews();
            },
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
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateStr;
    }
  }
} 