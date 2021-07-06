import 'package:flutter/material.dart';
import 'package:tangram/util/shape_enum.dart';

class VisibilityShape extends ChangeNotifier {

  List<bool> isHidden;

  VisibilityShape({required this.isHidden});

 set  toggleElement(int index){
    isHidden[index]=!isHidden[index];
    notifyListeners();
  }

bool  get areAllHidden=>isHidden.every((element) => (element==true));

// bool  get areAllVisible=>isHidden.every((element) => (element==false));

}