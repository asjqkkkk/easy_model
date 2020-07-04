import 'package:easy_model/easy_model.dart';
import 'package:flutter/material.dart';

import 'model/all_model.dart';
import 'pages/all_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModelWidget<GlobalModel>(
      childBuilder: (context, model) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(brightness: model.brightness),
          home: PageOne(),
        );
      },
      modelBuilder: () => GlobalModel(),
    );
  }
}
