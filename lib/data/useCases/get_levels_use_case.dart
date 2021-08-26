import 'package:triangram/data/models/levels.dart';
import 'package:triangram/data/repositories/level_repository.dart';

class GetLevelsUseCase {
  final LevelsRepository levelsRepository;

  GetLevelsUseCase({
    required this.levelsRepository,
  });

  Future<Levels> call() async {
    return await levelsRepository.getLevels();
  }
}
