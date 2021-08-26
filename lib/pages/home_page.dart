import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triangram/blocs/Levels/levels.dart';
import 'package:triangram/util/constants.dart';
import 'package:triangram/util/logger.dart';
import 'package:triangram/util/top_level_functions.dart';
import 'package:triangram/widgets/level_button.dart';
import 'package:triangram/widgets/shadow_text.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    var screenSize = mediaQueryData.size;
    // log.d('screen size   width:${screenSize.width}   height: ${screenSize.height}');
    var levelsWidth = -100.0 + screenSize.width;
    return Scaffold(
      body: WillPopScope(
        // No way to get back
        onWillPop: () async => false,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ShadowedText(
                  text: 'by Marcin Wasilewski',
                  color: Colors.white,
                  fontSize: 12.0,
                  offset: Offset(1.0, 1.0),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  width: levelsWidth,
                  height: levelsWidth,
                  child:
                      BlocBuilder<LevelsBloc, LevelsState>(builder: (context, LevelsState state) {
                    return GridView.builder(
                      itemCount: state.numberOfLevels, //TODO:Temporarily,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.01,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return LevelButton(
                          width: 80.0,
                          height: 60.0,
                          text: 'Level ${index + 1}',
                          onTap: () {
                            BlocProvider.of<LevelsBloc>(context).add(
                              CurrentLevel(
                                levelPosition: index,
                              ),
                            );
                            Navigator.of(context).pushNamed(Routes.game);
                          },
                        );
                      },
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
