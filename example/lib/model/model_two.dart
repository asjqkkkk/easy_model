import 'package:easy_model/easy_model.dart';

class ModelTwo extends Model{

  @override
  void initState() {
    print('${this.runtimeType} initState');
  }

  @override
  void dispose() {
    print('${this.runtimeType} dispose');
  }


  int value = 100;
}