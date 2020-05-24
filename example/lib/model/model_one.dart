import 'package:easy_model/easy_model.dart';
import 'package:flutter/material.dart';

class ModelOne extends Model{



  @override
  void initState() {
    print('${this.runtimeType} initState');
  }

  @override
  void dispose() {
    print('${this.runtimeType} dispose');
  }

  void notify(){
    refresh();
    print('${this.runtimeType} 刷新啦');
  }

  Brightness brightness = Brightness.light;

  ModelOne(){
    print('${this.runtimeType}重新创建');
  }
}