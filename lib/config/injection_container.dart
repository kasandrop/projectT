import 'package:get_it/get_it.dart';
import 'package:tangram/blocks/levels.dart';
import 'package:tangram/data/models/level.dart';
import 'package:tangram/data/models/levels.dart';
import 'package:tangram/data/repositories/level_repository.dart';
import 'package:tangram/data/useCases/get_levels_use_case.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async{
  //services

  //repositories

  sl.registerSingleton<LevelsRepository>(
    LevelsRepositoryImpl(),
  );

  //use cases
  sl.registerSingleton<GetLevelsUseCase>(
    GetLevelsUseCase(
      levelsRepository: sl(),
    ),
  );


  var levels=await sl<GetLevelsUseCase>().call();

 sl.registerFactory<LevelsState>( ()=>LevelsState(levels: levels,currentLevelNumber: -1));

  //=========blocks
  sl.registerFactory<LevelsBloc>(()=>
    LevelsBloc(
      initialState: sl(),
      getLevelsUseCase: sl(),
      lastLevelCompleted: 0,
    ),
  );
}
