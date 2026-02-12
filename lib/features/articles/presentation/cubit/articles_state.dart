part of 'articles_cubit.dart';

class ArticlesState extends Equatable {
  const ArticlesState({
    this.isLoading = false,
    this.isError = false,
    this.articles = const [],
    this.error,
    this.currentArticle,
    this.categories = const [],
  });

  final bool isLoading;
  final bool isError;
  final String? error;
  final List<ArticleEntity> articles;
  final ArticleEntity? currentArticle;
  final List<String> categories;

  @override
  List<Object?> get props => [
    isLoading,
    isError,
    error,
    articles,
    currentArticle,
    categories,
  ];

  ArticlesState copyWith({
    bool? isLoading,
    bool? isError,
    String? error,
    List<ArticleEntity>? articles,
    ArticleEntity? currentArticle,
    List<String>? categories,
  }) {
    return ArticlesState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      error: error ?? this.error,
      articles: articles ?? this.articles,
      currentArticle: currentArticle ?? this.currentArticle,
      categories: categories ?? this.categories,
    );
  }
}
