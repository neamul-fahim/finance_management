
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_management/models/user_data_model.dart';

class UserDataRepository {
  final _db=FirebaseFirestore.instance;
  // var user=FirebaseAuth.instance.currentUser;

  late UserDataModel _userData;

  Future<dynamic> getFireData(userId) async{
    try {

        DocumentReference userInfoRef = _db.collection("users").doc(userId).collection("user_info").doc("info");

        final tempJson = await userInfoRef.get();
        _userData=UserDataModel.fromMap(tempJson.data());

    }catch(e){
      print("*********************************************ERROR***************************************");
      print(e.toString());
    }
    return _userData;

  }

}