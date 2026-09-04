import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../logic/provider/article_provider.dart';

class WorkoutArticleListPage extends StatefulWidget {
  const WorkoutArticleListPage({super.key});

  @override
  State<WorkoutArticleListPage> createState() => _WorkoutArticleListPageState();
}

class _WorkoutArticleListPageState extends State<WorkoutArticleListPage> {
  @override
  void initState() {
    super.initState();
    // 초기 데이터 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ArticleProvider>(context, listen: false).getArticleData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5FB), // 이미지의 연한 보라색 배경 느낌
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Articles',
          style: TextStyle(
            color: Color(0xFF49454F),
            fontWeight: FontWeight.w400,
            fontSize: 22,
          ),
        ),
      ),
      body: Consumer<ArticleProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(provider.errorMessage!),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => provider.getArticleData(),
                    child: const Text('다시 시도'),
                  ),
                ],
              ),
            );
          }

          if (provider.articles.isEmpty) {
            return const Center(child: Text('표시할 기사가 없습니다.'));
          }

          return RefreshIndicator(
            onRefresh: () => provider.getArticleData(),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: provider.articles.length,
              itemBuilder: (context, index) {
                final article = provider.articles[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 상단 기사 이미지
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                        child: article.featuredImage.isNotEmpty
                            ? Image.network(
                                article.featuredImage,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  height: 200,
                                  color: Colors.grey[200],
                                  child: const Icon(Icons.broken_image, color: Colors.grey),
                                ),
                              )
                            : Container(
                                height: 200,
                                color: Colors.grey[200],
                                child: const Icon(Icons.image, color: Colors.grey),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 작성자 및 날짜 행
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 18,
                                  backgroundImage: article.avatarURL.isNotEmpty
                                      ? NetworkImage(article.avatarURL)
                                      : null,
                                  child: article.avatarURL.isEmpty
                                      ? const Icon(Icons.person, size: 20)
                                      : null,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    article.authorName,
                                    style: const TextStyle(
                                      color: Color(0xFF79747E),
                                      fontSize: 14,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  article.postDate,
                                  style: const TextStyle(
                                    color: Color(0xFF79747E),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // 제목
                            Text(
                              article.postTitle,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1C1B1F),
                              ),
                            ),
                            const SizedBox(height: 8),
                            // 요약본
                            Text(
                              article.postExcerpt,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF49454F),
                                height: 1.4,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 16),
                            // 태그 리스트 (가로 스크롤 가능하게 Wrap 대신 사용하거나 Wrap 그대로 사용)
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: article.postTag.take(3).map((tag) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF5F5D71), // 이미지의 어두운 그레이/보라 칩 색상
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    tag,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 20),
                            // 하단 아이콘 (좋아요, 댓글 - API 연동 전이므로 아이콘만 배치)
                            Row(
                              children: [
                                const Icon(Icons.thumb_up_alt_outlined, size: 20, color: Color(0xFF6750A4)),
                                const SizedBox(width: 6),
                                const Text('0', style: TextStyle(color: Color(0xFF49454F))),
                                const SizedBox(width: 20),
                                const Icon(Icons.chat_bubble_outline, size: 20, color: Color(0xFF6750A4)),
                                const SizedBox(width: 6),
                                const Text('0', style: TextStyle(color: Color(0xFF49454F))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
