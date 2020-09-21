import 'package:number_trivial/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:number_trivial/core/usecases/usecase.dart';
import 'package:number_trivial/features/domain/entities/number_trivia.dart';
import 'package:number_trivial/features/domain/repositories/number_trivial_repository.dart';

class GetRandomNumberTrivia implements Usecase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}
