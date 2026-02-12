part of 'article_categories_cubit.dart';

class ArticleCategoriesState extends Equatable {
  const ArticleCategoriesState({
    this.isLoading = false,
    this.isError = false,
    this.error,
    this.categories = const [],
  });

  final bool isLoading;
  final bool isError;
  final String? error;
  final List<String> categories;

  @override
  List<Object?> get props => [
    isLoading,
    isError,
    error,
    categories,
  ];

  ArticleCategoriesState copyWith({
    bool? isLoading,
    bool? isError,
    String? error,
    List<String>? categories,
  }) {
    return ArticleCategoriesState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      error: error ?? this.error,
      categories: categories ?? this.categories,
    );
  }
}
