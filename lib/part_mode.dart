import 'dart:collection';
import 'easy_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class PartModelWidget<T extends Model> extends StatefulWidget {
  final ChildBuilder<T> childBuilder;

  ///use [partKey] with [Model.refreshPart] to refresh [PartModelWidget]
  /// -- which is one part of [ModelWidget]
  final String partKey;

  final String modelKey;

  const PartModelWidget({
    Key key,
    @required this.childBuilder,
    @required this.partKey,
    this.modelKey,
  }) : super(key: key);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<String>('_ModelKey', modelKey,
        ifNull: 'no modelKey'));
    properties.add(ObjectFlagProperty<String>('_PartKey', partKey,
        ifNull: 'no partKey'));
  }

  @override
  _PartModelWidgetState createState() => _PartModelWidgetState<T>();
}

class _PartModelWidgetState<T extends Model> extends State<PartModelWidget<T>> {
  final PartDelegate _delegate = PartDelegate();
  Model _parentModel;

  @override
  void initState() {
    _initial();
    super.initState();
  }

  void _initial() {
    _parentModel = _parentModel ?? _findModel();
    if (_parentModel == null)
      throw FlutterError('$T can not be null before initState');
    _delegate._refreshCallback = _refresh;
    PartModelGroup._pushState(widget.partKey, _delegate);
  }

  @override
  void dispose() {
    _destroy();
    super.dispose();
  }

  void _destroy() {
    _delegate._refreshCallback = null;
    _parentModel = null;
    PartModelGroup._popState(widget.partKey, _delegate);
  }

  T _findModel() => widget.modelKey == null
      ? ModelGroup.findModel<T>()
      : ModelGroup.findModelByKey(widget.modelKey);

  @override
  Widget build(BuildContext context) =>
      widget.childBuilder.call(context, _parentModel);

  void _refresh() {
    if (mounted) setState(() {});
  }
}

class PartDelegate {
  VoidCallback _refreshCallback;
  void refresh() => _refreshCallback?.call();
}

class PartModelGroup {
  static Map<String, Set<PartDelegate>> _stateMap = HashMap();

  static void _pushState(String partKey, PartDelegate delegate) {
    _stateMap[partKey] = _stateMap[partKey] ?? Set<PartDelegate>();
    _stateMap[partKey].add(delegate);
  }

  static void _popState(String partKey, PartDelegate delegate) {
    _stateMap[partKey].remove(delegate);
    if (_stateMap[partKey].isEmpty) _stateMap[partKey] = null;
  }

  static Set<PartDelegate> findStateSet(String partKey) => _stateMap[partKey];
}
