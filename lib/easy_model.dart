import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ModelWidget<T extends Model> extends StatefulWidget {
  final ChildBuilder<T> childBuilder;
  final ModelBuilder<T> modelBuilder;
  final String modelKey;

  const ModelWidget(
      {Key key,
      @required this.childBuilder,
      @required this.modelBuilder,
      this.modelKey})
      : super(key: key);

  @override
  _ModelWidgetState createState() => _ModelWidgetState<T>();
}

typedef ChildBuilder<T extends Model> = Widget Function(
    BuildContext context, T model);

typedef ModelBuilder<T extends Model> = T Function();

class _ModelWidgetState<T extends Model> extends State<ModelWidget<T>> {
  final _StateDelegate _stateDelegate = _StateDelegate();
  Model _model;

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
    _model = _model ?? _findModel() ?? widget.modelBuilder.call();
    final key = widget.modelKey;
    _initialCheck(_model);
    _stateDelegate._refreshCallback = _refresh;
    _model._stateDelegate = null;
    _model._stateDelegate = _stateDelegate;
    if (_model._createTime == 0) _model.initState();
    key == null
        ? ModelGroup._pushModel(_model)
        : ModelGroup._pushModelWithKey(key, _model);
  }

  bool _initialCheck(Model model) {
    if (model == null)
      throw FlutterError('Model can not be null during initState');
    Model oldModel = _findModel();
    if (oldModel != null) {
      oldModel._createTime++;
      _model = oldModel;
      oldModel = null;
      return true;
    }
    return false;
  }

  void _destroy() {
    final key = widget.modelKey;
    _stateDelegate._refreshCallback = null;
    if (_destroyCheck()) return;
    _model._stateDelegate = null;
    _model.dispose();
    key == null
        ? ModelGroup._popModel(_model)
        : ModelGroup._popModelWithKey(key, _model);
  }

  bool _destroyCheck() {
    if (_model == null)
      throw FlutterError('Model $T can not be null before dispose');
    if (_model._createTime > 0) {
      _model._createTime--;
      return true;
    }
    return false;
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  T _findModel() => widget.modelKey == null
      ? ModelGroup.findModel<T>()
      : ModelGroup.findModelByKey(widget.modelKey);

  @override
  Widget build(BuildContext context) =>
      widget.childBuilder.call(context, _model);

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

  static void _popModel(Model model) {
    Model m = _map.remove(model.runtimeType);
    m = null;
    model = null;
  }

  static void _popModelWithKey(String key, Model model) {
    Model m = _repeatMap.remove(key);
    m = null;
    model = null;
  }

  static T findModel<T extends Model>() => _map[T];

  static T findModelByKey<T extends Model>(String key) => _repeatMap[key];
}
