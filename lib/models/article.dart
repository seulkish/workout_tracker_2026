class Article {
  final String postTitle;
  final String authorName;
  final String avatarURL;
  final String postDate;
  final String postURL;
  final String postExcerpt;
  final List<String> postTag;
  final String featuredImage;

  Article({
    required this.postTitle,
    required this.authorName,
    required this.avatarURL,
    required this.postDate,
    required this.postURL,
    required this.postExcerpt,
    required this.postTag,
    required this.featuredImage,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    // HTML 태그 및 엔티티 제거를 위한 정규식
    String removeHtml(String htmlString) {
      return htmlString
          .replaceAll(RegExp(r'<[^>]*>'), '') // 태그 제거
          .replaceAll(RegExp(r'&[^;]+;'), '') // 엔티티 제거 (e.g. &nbsp;)
          .trim();
    }

    // 작성자 정보 파싱
    final author = json['author'] ?? {};
    
    // 태그 정보 파싱
    final tagsMap = json['tags'] as Map<String, dynamic>? ?? {};
    final tagsList = tagsMap.keys.toList();

    return Article(
      postTitle: removeHtml(json['title'] ?? '제목 없음'),
      authorName: author['name'] ?? '알 수 없음',
      avatarURL: author['avatar_URL'] ?? '',
      postDate: json['date'] != null 
          ? json['date'].toString().split('T')[0] 
          : '',
      postURL: json['URL'] ?? '',
      postExcerpt: removeHtml(json['excerpt'] ?? ''),
      postTag: tagsList,
      featuredImage: json['featured_image'] ?? '',
    );
  }
}
