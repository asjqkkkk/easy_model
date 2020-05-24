import 'package:easy_model/easy_model.dart';
import 'package:flutter/cupertino.dart';

class WidgetModel extends Model{

  int value = 666;

  @override
  void initState() {
    print('${this.runtimeType} initState');
  }

  @override
  void dispose() {
    print('${this.runtimeType} dispose');
  }
}