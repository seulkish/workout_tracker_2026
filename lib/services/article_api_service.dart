import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class ArticleApiService {
  // 확정된 WordPress REST API Endpoint
  static const String _url = 'https://public-api.wordpress.com/rest/v1.1/read/tags/workout/posts';

  /// WordPress API로부터 데이터를 가져와 Article 객체 리스트로 변환하여 반환합니다.
  Future<List<Article>> fetchArticles() async {
    try {
      final response = await http.get(Uri.parse(_url));

      // utf8.decode로 디코딩하여 로그 출력 (필요 시)
      final decodedBody = utf8.decode(response.bodyBytes);
      log('Fetched Body: $decodedBody');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(decodedBody);
        final List<dynamic> posts = jsonData['posts'] ?? [];
        
        // JSON 데이터를 Article 객체 리스트로 변환 (Service Layer에서 수행)
        return posts.map((post) => Article.fromJson(post)).toList();
      } else {
        throw Exception('Failed to load articles: ${response.statusCode}');
      }
    } catch (e) {
      log('Error in fetchArticles: $e');
      rethrow; // Provider에서 에러 처리를 할 수 있도록 던집니다.
    }
  }
}
