import 'package:flutter/material.dart';
import 'package:tangram/util/shape_enum.dart';

class VisibilityShape extends ChangeNotifier {

  List<bool> isSelected;

  VisibilityShape({required this.isSelected});

 set  toggleElement(int index){
    isSelected[index]=!isSelected[index];
    notifyListeners();
  }

bool  get areAllVisible=>isSelected.every((element) => (element==false));

}