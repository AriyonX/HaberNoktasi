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
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
          errorMessage = 'Haberler yüklenirken bir hata oluştu. Lütfen tekrar deneyin.';
        });
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
          : errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(errorMessage!),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: fetchNews,
                        child: const Text('Tekrar Dene'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: fetchNews,
                  child: news.isEmpty
                      ? const Center(
                          child: Text('Haber bulunamadı'),
                        )
                      : ListView.builder(
                          itemCount: news.length,
                          itemBuilder: (context, index) {
                            final article = news[index];
                            return Card(
                              margin: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (article['urlToImage'] != null)
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(4),
                                      ),
                                      child: Image.network(
                                        article['urlToImage'],
                                        height: 200,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) =>
                                            const SizedBox.shrink(),
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          article['title'] ?? 'Başlık yok',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          article['description'] ?? 'Açıklama yok',
                                          style: const TextStyle(fontSize: 14),
                                        ),
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