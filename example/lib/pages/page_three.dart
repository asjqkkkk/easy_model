import 'package:easy_model/easy_model.dart';
import 'package:example/common/common.dart';
import '../model/all_model.dart';
import 'package:flutter/material.dart';

class PageThree extends StatelessWidget {

  final modelThree = ModelGroup.findModel<ModelThree>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${this.runtimeType}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Button(
                onPressed: () {
                  final modelOne = ModelGroup.findModel<ModelOne>();
                  modelOne.brightness = modelOne.brightness == Brightness.light
                      ? Brightness.dark
                      : Brightness.light;
                  modelOne.refresh();
                },
                child: Text('Change ThemeData',
                    style: TextStyle(color: Colors.white))),
            Button(
                onPressed: () {
                  final modelTwo = ModelGroup.findModel<ModelTwo>();
                  modelTwo.value--;
                  modelTwo.refresh();
                },
                child: Text('Reduce PageTwo Value',
                    style: TextStyle(color: Colors.white))),
          ],
        ),
      ),
    );
  }
}
