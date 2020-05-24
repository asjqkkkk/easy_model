import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ModelWidget<T extends Model> extends StatefulWidget {
  final ChildBuilder<T> builder;
  final T model;
  final String modelKey;

  const ModelWidget(
      {Key key, @required this.builder, @required this.model, this.modelKey})
      : super(key: key);

  @override
  _ModelWidgetState createState() => _ModelWidgetState<T>();
}

typedef ChildBuilder<T extends Model> = Widget Function(
    BuildContext context, T model);

class _ModelWidgetState<T extends Model> extends State<ModelWidget<T>> {
  final _StateDelegate _stateDelegate = _StateDelegate();

  @override
  void initState() {
    _initial();
    super.initState();
  }

  @override
  void dispose() {
    _destroy();
    super.dispose();
  }

  void _initial() {
    Model model = widget.model;
    final key = widget.modelKey;
    if (_initialCheck()) model = _findModel();
    _stateDelegate._refreshCallback = _refresh;
    model._stateDelegate = _stateDelegate;
    model.initState();
    key == null
        ? ModelGroup._pushModel(model)
        : ModelGroup._pushModelWithKey(key, model);
  }

  bool _initialCheck() {
    final model = widget.model;
    if (model == null)
      throw FlutterError('Model can not be null during initState');
    final oldModel = _findModel();
    if (oldModel != null) {
      oldModel._createTime++;
      return true;
    }
    return false;
  }

  void _destroy() {
    final model = widget.model;
    final key = widget.modelKey;
    _stateDelegate._refreshCallback = null;
    if (_destroyCheck()) return;
    model._stateDelegate = null;
    model.dispose();
    key == null
        ? ModelGroup._popModel(model)
        : ModelGroup._popModelWithKey(key, model);
  }

  bool _destroyCheck() {
    final model = widget.model;
    if (model == null)
      throw FlutterError('Model can not be null before dispose');
    final oldModel = _findModel();
    if (oldModel == null)
      throw FlutterError(
          'The Model [${model.runtimeType}] has been unRegisted.');
    if (oldModel._createTime > 0) {
      oldModel._createTime--;
      return true;
    }
    return false;
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  T _findModel() => widget.modelKey == null
      ? ModelGroup._findModelWithObj(widget.model)
      : ModelGroup.findModelByKey(widget.modelKey);

  @override
  Widget build(BuildContext context) =>
      widget.builder.call(context, _findModel());

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<ModelWidget>('_widget', widget,
        ifNull: 'no widget'));
    properties.add(ObjectFlagProperty<StatefulElement>('_element', context,
        ifNull: 'not mounted'));
  }
}

class Model {
  _StateDelegate _stateDelegate;
  int _createTime = 0;

  void initState() {}

  void dispose() {}

  @mustCallSuper
  void refresh() {
    _stateDelegate?.refresh();
  }
}

class _StateDelegate {
  VoidCallback _refreshCallback;
  void refresh() => _refreshCallback?.call();
}

class ModelGroup {
  static Map<Type, Model> _map = new HashMap();
  static Map<String, Model> _repeatMap = new HashMap();

  static void _pushModel(Model model) => _map[model.runtimeType] = model;

  static void _pushModelWithKey(String key, Model model) =>
      _repeatMap[key] = model;

  static void _popModel(Model model){
    Model m = _map.remove(model.runtimeType);
    m = null;
  }

  static void _popModelWithKey(String key, Model model){
    Model m = _repeatMap.remove(key);
    m = null;
  }

  static T findModel<T extends Model>() => _map[T];

  static T findModelByKey<T extends Model>(String key) => _repeatMap[key];

  static Model _findModelWithObj<T extends Model>(T t) {
    if (t is! Model) throw FlutterError('The Model Type [$t] is invalid.');
    return _map[t.runtimeType];
  }
}