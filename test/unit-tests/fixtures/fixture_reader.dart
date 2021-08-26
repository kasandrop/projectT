import 'dart:io';

String fixture(String name) => File('test/unit-tests/fixtures/$name').readAsStringSync();
