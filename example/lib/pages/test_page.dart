import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final Data data = Data();
  TestWidget testWidget;

  @override
  void initState() {
    testWidget = TestWidget(
      value: data.value,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测试'),
      ),
      body: Center(
        child: FlatButton(
            onPressed: () {
              setState(() {
                data.value++;
              });
            },
            child: testWidget),
      ),
    );
  }
}

class Data {
  int value = 0;
}

class TestWidget extends StatelessWidget {
  final int value;

  const TestWidget({Key key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('$value');
  }
}
