

class UserDataModel {
  final String uid;
  final String name;
  final String  phone;
  final String  email;
  final String  address;
  final String  profilePicURL;



  UserDataModel({required this.uid,required this.name,required this.phone,required this.email,required this.address,required this.profilePicURL});

  ///set method
  Map<String , dynamic > toMap(){
    return{
      "uid":uid,
      "name":name,
      "phone":phone,
       "email":email,
       "address":address,
        "profilePicURL":profilePicURL,
    };
  }

  ///get method
  factory UserDataModel.fromMap(map){
    return UserDataModel(
         uid: map?["uid"],
         name: map?["name"],
         phone: map?["phone"],
         email: map?["email"],
         address: map?["address"],
         profilePicURL: map?["profilePicURL"],
    );
  }


}

