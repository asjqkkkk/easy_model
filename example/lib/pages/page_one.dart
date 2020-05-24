import 'package:example/util/push_util.dart';
import 'package:flutter/material.dart';


class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${this.runtimeType}'),),
      body: Center(
        child: FlatButton(onPressed: (){
//          Navigator.push(context, new MaterialPageRoute(builder: (ctx) => PageTwo()));
          push(context, (ctx, model) => PageTwo(), ModelTwo());
        }, child: Text('下一页')),
      ),
    );
  }

}
