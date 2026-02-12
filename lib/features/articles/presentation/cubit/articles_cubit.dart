import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:periodility/features/articles/domain/entities/article_entity.dart';
import 'package:periodility/features/articles/domain/usecases/get_article_usecase.dart';
import 'package:periodility/features/articles/domain/usecases/get_articles_usecase.dart';

part 'articles_state.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  ArticlesCubit({
    required GetArticleUseCase getArticleUseCase,
    required GetArticlesUseCase getArticlesUseCase,
  }) : _getArticleUseCase = getArticleUseCase,
       _getArticlesUseCase = getArticlesUseCase,
       super(const ArticlesState());

  final GetArticleUseCase _getArticleUseCase;
  final GetArticlesUseCase _getArticlesUseCase;

  Future<void> getArticles() async {
    emit(state.copyWith(isLoading: true));
    final result = await _getArticlesUseCase();

    result.fold(
      (left) {
        emit(
          state.copyWith(
            isLoading: false,
            isError: true,
            error: left.message,
          ),
        );
      },
      (articles) => emit(
        state.copyWith(
          isLoading: false,
          articles: articles,
        ),
      ),
    );
  }

  Future<void> getArticle({required String id}) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getArticleUseCase(id: id);

    result.fold(
      (left) {
        emit(
          state.copyWith(
            isLoading: false,
            isError: true,
            error: left.message,
          ),
        );
      },
      (article) => emit(
        state.copyWith(
          isLoading: false,
          currentArticle: article,
        ),
      ),
    );
  }
}
