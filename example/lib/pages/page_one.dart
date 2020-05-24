import '../common/common.dart';
import 'package:flutter/material.dart';

class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${this.runtimeType}'),
      ),
      body: Center(child: Button(
        onPressed: () {
          push(context, (ctx, model) => PageTwo(), () => ModelTwo());
        },
      )),
    );
  }
}
