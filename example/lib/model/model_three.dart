import 'package:easy_model/easy_model.dart';

class ModelThree extends Model {
  @override
  void initState() {
    print('${this.runtimeType} initState');
  }

  @override
  void dispose() {
    print('${this.runtimeType} dispose');
  }

  ModelThree() {
    print('${this.runtimeType} create');
  }

  int value = 0;
}
