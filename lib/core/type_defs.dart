import 'package:fpdart/fpdart.dart';
import 'package:joga_junto/core/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = Future<void>;