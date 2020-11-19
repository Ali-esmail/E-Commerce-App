import 'package:flutter/cupertino.dart';

class ModelHud extends ChangeNotifier{
  bool isloading = false;

  changeisLoading(bool value){
    isloading = value;
    notifyListeners();
  }
}