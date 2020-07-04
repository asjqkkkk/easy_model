import 'package:easy_model/easy_model.dart';
import 'package:flutter/material.dart';

class GlobalModel extends Model {
  Brightness brightness = Brightness.light;

  @override
  void initState() {
    print('${this.runtimeType} initState');
  }

  @override
  void dispose() {
    print('${this.runtimeType} dispose');
  }

  GlobalModel() {
    print('${this.runtimeType} create');
  }
}
