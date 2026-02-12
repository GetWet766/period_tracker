import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:periodility/features/articles/domain/usecases/get_categories_usecase.dart';

part 'article_categories_state.dart';

class ArticleCategoriesCubit extends Cubit<ArticleCategoriesState> {
  ArticleCategoriesCubit({
    required GetCategoriesUseCase getCategoriesUseCase,
  }) : _getCategoriesUseCase = getCategoriesUseCase,
       super(const ArticleCategoriesState());

  final GetCategoriesUseCase _getCategoriesUseCase;

  Future<void> getCategories() async {
    emit(state.copyWith(isLoading: true));
    final result = await _getCategoriesUseCase();

    result.fold(
      (left) {
        emit(
          state.copyWith(isLoading: false, isError: true, error: left.message),
        );
      },
      (categories) => emit(
        state.copyWith(
          isLoading: false,
          categories: categories,
        ),
      ),
    );
  }
}
