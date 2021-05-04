import 'dart:io';

import 'package:tangram/resources/resources.dart';
import 'package:test/test.dart';

void main() {
  test('images assets test', () {
    expect(true, File(Images.rectangleWithoutTriangle).existsSync());
    expect(true, File(Images.rectangleWithTriangle).existsSync());
    expect(true, File(Images.trapez).existsSync());
    expect(true, File(Images.triangle).existsSync());
  });
}
