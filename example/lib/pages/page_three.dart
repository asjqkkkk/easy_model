import 'package:easy_model/easy_model.dart';
import '../model/all_model.dart';
import 'package:flutter/material.dart';

import 'test_page.dart';

class PageThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final modelThree = ModelGroup.findModel<ModelThree>();

    return Scaffold(
      appBar: AppBar(title: Text('${this.runtimeType}'),),
      body: Center(
        child: FlatButton(onPressed: (){
//          Navigator.push(context, new MaterialPageRoute(builder: (ctx){
//            return TestPage();
//          }));
          final modelOne = ModelGroup.findModel<ModelOne>();
          modelThree.value++;
          modelOne.brightness = modelOne.brightness == Brightness.light ? Brightness.dark : Brightness.light;
          modelOne.refresh();
        }, child: Text('刷新:${modelThree.value}')),
      ),
    );
  }
}
