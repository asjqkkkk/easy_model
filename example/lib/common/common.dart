export '../model/all_model.dart';
export '../pages/all_pages.dart';
import 'dart:math';

import 'package:easy_model/easy_model.dart';
import 'package:flutter/material.dart';

void push<T extends Model>(BuildContext context, ChildBuilder<T> widget,
    ModelBuilder<T> modelBuilder) {
  Navigator.of(context).push(new MaterialPageRoute(builder: (ctx) {
    return ModelWidget<T>(
      childBuilder: widget,
      modelBuilder: modelBuilder,
    );
  }));
}

class Button extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final bool enableRandomColor;

  const Button(
      {Key key, this.onPressed, this.child, this.enableRandomColor = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: enableRandomColor ? randomColor : Theme.of(context).primaryColor,
      child: child ?? Text('Next Page', style: TextStyle(color: Colors.white)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      onPressed: onPressed,
    );
  }
}

Color get randomColor =>
    Colors.primaries[Random().nextInt(Colors.primaries.length)];
