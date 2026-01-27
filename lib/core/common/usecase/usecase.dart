import 'package:dartz/dartz.dart';
import 'package:period_tracker/core/errors/failures.dart';

abstract interface class UseCaseWithoutParams<SuccessType> {
  Future<Either<Failure, SuccessType>> call();
}

abstract interface class UseCaseWithParams<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}
