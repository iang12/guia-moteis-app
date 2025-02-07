import 'package:dartz/dartz.dart';

import '../../../core/errors/errors.dart';
import '../domain/models/motels_result_model.dart';

abstract class MotelRepository {
  Future<Either<Failure, MotelsResultModel>> getMotels();
}
