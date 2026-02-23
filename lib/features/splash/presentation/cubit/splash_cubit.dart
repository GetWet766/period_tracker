import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:periodility/core/dependencies/injection.dart';
import 'package:periodility/core/services/ad_service.dart';
import 'package:periodility/features/articles/presentation/cubit/article_categories_cubit.dart';
import 'package:periodility/features/articles/presentation/cubit/articles_cubit.dart';
import 'package:periodility/features/cycle/presentation/cubit/cycle_cubit.dart';
import 'package:periodility/features/cycle/presentation/cubit/daily_logs_cubit.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'splash_state.dart';
part 'splash_cubit.freezed.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({
    required this.adService,
    required this.articleCategoriesCubit,
    required this.articlesCubit,
    required this.cycleCubit,
    required this.dailyLogsCubit,
  }) : super(const SplashState.initial());

  final AdService adService;
  final ArticlesCubit articlesCubit;
  final ArticleCategoriesCubit articleCategoriesCubit;
  final CycleCubit cycleCubit;
  final DailyLogsCubit dailyLogsCubit;

  Future<void> initApplication() async {
    emit(const SplashState.loading());

    sl<Talker>().log('Starting initApplication...');
    await Future.wait([
      adService.init(),
      cycleCubit.init(),
      articlesCubit.getArticles(),
      articleCategoriesCubit.getCategories(),
      // dailyLogsCubit.init(),
    ]);
    sl<Talker>().log('initApplication completed');

    emit(const SplashState.completed());
  }
}
