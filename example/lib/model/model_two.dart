import 'package:easy_model/easy_model.dart';

class ModelTwo extends Model {
  @override
  void initState() {
    print('${this.runtimeType} initState');
  }

  @override
  void dispose() {
    print('${this.runtimeType} dispose');
  }

  ModelTwo() {
    print('${this.runtimeType} create');
  }

  int pageValue = 0;
  int partValue = 0;
}
