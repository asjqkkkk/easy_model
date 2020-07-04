import 'package:flutter_test/flutter_test.dart';

import 'package:easy_model/easy_model.dart';

void main() {
  test('adds one to input values', () {
    Model one = Model();
    Model two = Model();
    Set<Model> set = Set();
    set.add(one);
    set.add(two);
    print(set.length);
  });
}

class Model {}
