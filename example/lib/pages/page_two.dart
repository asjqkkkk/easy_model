import 'package:easy_model/easy_model.dart';
import '../util/push_util.dart';
import '../model/all_model.dart';
import 'package:flutter/material.dart';


class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final modelTwo = ModelGroup.findModel<ModelTwo>();
    print('${this.runtimeType}重新build');

    return Scaffold(
      appBar: AppBar(
        title: Text('${this.runtimeType}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                onPressed: () {
                  modelTwo.value++;
                  push(context, (ctx, model) => PageThree(), ModelThree());
                },
                child: Text('下一页')),
            ModelWidget<WidgetModel>(
              builder: (ctx, model) => Text('${model.value}'),
              model: WidgetModel(),
            ),
            FlatButton(
                onPressed: () {
                  final model = ModelGroup.findModel<WidgetModel>();
                  model.value++;
                  modelTwo.value++;
                  modelTwo.refresh();
                },
                child: Text('修改')),
            Text('${modelTwo.value}'),
          ],
        ),
      ),
    );
  }
}


class TestText extends StatefulWidget {
  @override
  _TestTextState createState() => _TestTextState();
}

class _TestTextState extends State<TestText> {

  @override
  void initState() {
    print('创建');
    super.initState();
  }

  @override
  void dispose() {
    print('销毁');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text('啊啊啊啊');
  }
}
