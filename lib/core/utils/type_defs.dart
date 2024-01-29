import 'package:fpdart/fpdart.dart';
import 'package:reddit/core/utils/failure.dart';
/// FutureEither to handle failure and success cases
typedef FutureEither<T> = Future<Either<Failure, T>>;

/// FutureVoid to handle failure and void cases
typedef FutureVoid = FutureEither<void>;