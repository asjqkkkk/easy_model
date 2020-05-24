import 'package:easy_model/easy_model.dart';
import 'package:flutter/material.dart';

import 'model/all_model.dart';
import 'pages/all_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ModelWidget<ModelOne>(
        builder: (context, model){
          print('页面一重新构建');
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(brightness: model.brightness),
            home: PageOne(),
          );
        },
      model: ModelOne(),
    );
  }
}
