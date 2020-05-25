import 'package:easy_model/easy_model.dart';
import '../common/common.dart';
import '../model/all_model.dart';
import 'package:flutter/material.dart';

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final modelTwo = ModelGroup.findModel<ModelTwo>();

    return Scaffold(
      appBar: AppBar(
        title: Text('PageTwo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Button(
              onPressed: () {
                push(context, (ctx, model) => PageThree(), () => ModelThree());
              },
            ),
            SizedBox(
              height: 20,
            ),
            ModelWidget<WidgetModel>(
              childBuilder: (ctx, model) => Text(
                'ModelWidget value:${model.value}',
                style: TextStyle(fontSize: 20),
              ),
              modelBuilder: () => WidgetModel(),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'PageTwo value:${modelTwo.value}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Button(
                onPressed: () {
                  final model = ModelGroup.findModel<WidgetModel>();
                  model.value++;
                  model.refresh();
                },
                enableRandomColor: true,
                child: Text('Add ModelWidget value',
                    style: TextStyle(color: Colors.white))),
            Button(
                onPressed: () {
                  modelTwo.value++;
                  modelTwo.refresh();
                },
                enableRandomColor: true,
                child: Text('Add PageTwo value',
                    style: TextStyle(color: Colors.white))),
          ],
        ),
      ),
    );
  }
}
