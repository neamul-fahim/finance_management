import 'package:finance_management/models/user_data_model.dart';
import 'package:finance_management/repository/user_data_repository.dart';
import 'package:flutter/material.dart';

class UserDataProvider with ChangeNotifier{
  UserDataModel? _userData ;

  UserDataModel? get userData => _userData;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

 final  UserDataRepository _userDataRepository =UserDataRepository();

   Future<void> getUserData(userId) async{
    _isLoading = true;
    notifyListeners();
     
     _userData = await _userDataRepository.getFireData(userId);
     _isLoading = false;
     notifyListeners();

   }


}