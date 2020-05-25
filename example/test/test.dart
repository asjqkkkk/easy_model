import 'dart:collection';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('testMapLeackMemory', () {
    Map map = HashMap<int, Data>();
    map[0] = Data();

    Data data = map[0];
    data.value += 10;

    Data newData = map[0];
    newData.value += 10;
    print('新的:${newData?.value}    旧的:${data?.value}    原本:${map[0]}');
  });

  test('testListLeackMemory', () {
    Data data = Data();
    data.value += 10;

    Data newData = data;
    data = null;

    print('旧的:${data?.value}   新的:${newData?.value}');
  });
}

class Data {
  int value = 0;

  @override
  String toString() {
    return 'Data{value: $value}';
  }
}
