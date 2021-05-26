import 'package:multiple_result/multiple_result.dart';
import 'package:smart_porta/features/core/failures/failure.dart';

abstract class AsyncUseCase<Type, Params> {
  Future<Result<Failure, Type>> call(Params params);
}