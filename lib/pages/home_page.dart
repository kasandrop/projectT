import 'package:flutter/material.dart';
import 'package:tangram/widgets/level_button.dart';
import 'package:tangram/widgets/shadow_text.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    var screenSize = mediaQueryData.size;
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
                  child: GridView.builder(
                    itemCount: 20, //TODO:Temporarily,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.01,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return LevelButton(
                        width: 80.0,
                        height: 60.0,
                        borderRadius: 40.0,
                        text: 'Level ${index + 1}',
                        onTap: () async {
                          // Level newLevel = await gameBloc.setLevel(index + 1);
                          //
                          // // Open the Game page
                          // Navigator.of(context).push(GamePage.route(newLevel));
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
