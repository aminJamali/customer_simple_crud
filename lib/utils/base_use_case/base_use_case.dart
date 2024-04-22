import 'package:dartz/dartz.dart';

import '../../shared/models/exception_model.dart';

abstract class BaseUseCase<R, P> {
  Future<Either<ExceptionModel, R>> call(final P params);
}
