export '../model/all_model.dart';
export '../pages/all_pages.dart';
import 'package:easy_model/easy_model.dart';
import 'package:flutter/material.dart';

void push<T extends Model>(BuildContext context, ChildBuilder widget, T model){
  Navigator.of(context).push(new MaterialPageRoute(builder: (ctx){
    return ModelWidget(builder: widget, model: model,);
  }));
}