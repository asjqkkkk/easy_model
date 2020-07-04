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
            PartModelWidget<ModelTwo>(
              childBuilder: (ctx, model) => Text(
                'PartModelWidget value:${model.partValue}',
                style: TextStyle(fontSize: 20),
              ),
              partKey: '$ModelTwo',
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'PageTwo value:${modelTwo.pageValue}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Button(
                onPressed: () {
                  modelTwo.partValue++;
                  modelTwo.refreshPart('$ModelTwo');
                },
                enableRandomColor: true,
                child: Text('Add PartModelWidget value',
                    style: TextStyle(color: Colors.white))),
            Button(
                onPressed: () {
                  modelTwo.pageValue++;
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
