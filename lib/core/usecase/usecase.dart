import 'package:dartz/dartz.dart';

import 'package:equatable/equatable.dart';
import 'package:fleekhr/core/error/failure.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

// Used when a use case doesn't require any parameters.
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}