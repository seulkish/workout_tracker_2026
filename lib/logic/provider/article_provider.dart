import 'package:flutter/material.dart';
import '../../models/article.dart';
import '../../services/article_api_service.dart';

class ArticleProvider extends ChangeNotifier {
  final ArticleApiService _apiService = ArticleApiService();
  
  List<Article> _articles = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Service Layer를 통해 데이터를 가져와 상태를 업데이트하고 리스트를 반환합니다.
  Future<List<Article>> getArticleData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Service Layer에서 이미 객체로 변환된 데이터를 받습니다.
      _articles = await _apiService.fetchArticles();
      _isLoading = false;
    } catch (e) {
      _errorMessage = '기사를 불러오는 중 오류가 발생했습니다.';
      _isLoading = false;
    }
    
    notifyListeners();
    return _articles;
  }
}
