
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_management/auth/login.dart';
import 'package:finance_management/auth/signin.dart';
import 'package:finance_management/screens/expense_screen.dart';
import 'package:finance_management/screens/income_screen.dart';
import 'package:finance_management/screens/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomAppDrawer extends StatefulWidget {
  const CustomAppDrawer({super.key,});

  @override
  State<CustomAppDrawer> createState() => _CustomAppDrawerState();
}



class _CustomAppDrawerState extends State<CustomAppDrawer> {
  final _db=FirebaseFirestore.instance;
  var name="Name";
  String imgURL="";
  bool once=false;


  @override
  Widget build(BuildContext context) {



    // print("UUUUUUUUUUUUUUUUUUUUUUU111111111111111111111111111111111111111111111111UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU");
    // print("UUUUUUUUUUUUUUUUUUUUUUUUUUUU${user.toString()}UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU");
      
      
    // Future<void> fun() async{
    //   Map<String, dynamic>? t;
    //   ///profile Pic download link SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
      
    //    try {
    //         String user= FirebaseAuth.instance.currentUser!.uid;

    //      var fireStorePath = firebaseStorage
    //          .child("finance-management").child("users").child(user).child("pics");
    //      imgURL = await fireStorePath.getDownloadURL();


    //      print('------------------------------------------------------------------------------------------------------------------');
    //         print('-------------------${imgURL}---------------------');
    //      ///profile Pic download link EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

    //      final tempJson = await _db.collection("users").doc(user).get();
    //       t = tempJson.data();
    //       print('---------------------${t}----------------------------');
    //    }catch(e){
    //     print('EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE');
    //      Fluttertoast.showToast(msg: e.toString());
    //    }
    //   setState(() {

    //     once=true;
    //     name= t != null ? t["name"]:"Name";
    //   });
    // }
    // if( FirebaseAuth.instance.currentUser!=null && !once) fun();

    double dynamicHeight=MediaQuery.of(context).size.height;
    double dynamicWidth=MediaQuery.of(context).size.width;
    //final File imageFile;
    //XFile ? pick;
   // var pickedImage;
    
            return Container(
              height: dynamicHeight,
              width: dynamicWidth*2/3,
              decoration: BoxDecoration(

                color: Colors.deepPurple.shade300,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Padding(
                padding: const EdgeInsets.only(top: 85.0),
                child: SingleChildScrollView(
                  child: Column(
                    children:[

                      /// Profile pic SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
                      Container(
                        clipBehavior: Clip.hardEdge,
                        height: dynamicWidth*0.3,
                        width: dynamicWidth*0.3,
                            ///:Image.file(finalImageFile!,fit: BoxFit.cover,),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),

                        ),
                        ///child: finalImageFile==null?

                        child: imgURL.isEmpty?Image.asset("assets/images/profilePic.jpg",fit: BoxFit.fill,)
                            :Image.network(imgURL,fit: BoxFit.fill,),
                      ),
                      /// Profile pic EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE


                      Text(name, //appDrawerProvider.appDrawerModelClass.profileName.toString(),
                          style:const TextStyle(fontSize: 20,fontWeight:FontWeight.w400,color: Colors.white, ) ),///User name


                     const SizedBox(
                        height: 60,
                      ),
                      /// Drawer options SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
                      
                      drawerProperty(Icons.arrow_circle_up_outlined, 'All incone',context,()=>const IncomeScreen()),
                      drawerProperty(Icons.arrow_circle_down_outlined, 'All expense',context,()=>const ExpenseScreen()),

                      //drawerProperty(Icons.cloud_rounded, 'Weather',context,()=>Weather()),
                     const Divider(
                        //color: Colors.black,
                        thickness: 1,
                        height: 20,
                          indent: 15,
                        endIndent: 15,
                      ),
                      drawerProperty(Icons.cloud_rounded, 'Signin',context,()=>const SignIN()),
                      drawerProperty(Icons.cloud_rounded, 'Login',context,()=>const LogIN()),
                      drawerProperty(Icons.logout_rounded, 'Logout',context,()=>const HomeScreen()),
                      /// Drawer options EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
                    ],
                  ),
                ),
              ),
            );
  }

 //  XFile? imageXFile;
 // /// File? finalImageFile;
 //  /// File? tempImage;
 //  Future SelectImage(source)async{
 //    final ImagePicker _picker=ImagePicker();
 //    imageXFile= await _picker.pickImage(source: source);
 //
 //    if (imageXFile==null) return;
 //     /// tempImage=File(imageXFile!.path);
 //    setState(() {
 //     /// finalImageFile=tempImage;
 //    });
 //     //return imageFile;
 //   // final XFile? video= await _picker.pickVideo(source: source);
 //
 //  }


   /// Function to determine what action is needed to perform when drawer option is pressed   SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
  Container drawerProperty(IconData drawerOptionIcon,String drawerOptionName,BuildContext context,Widget Function() className){
    return Container(
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () async{
              if(drawerOptionIcon==Icons.logout_rounded)///for logout
              {
                 FirebaseAuth.instance.signOut().then((value) {
                   Fluttertoast.showToast(msg: "loged out");

                   //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("loge out")));


                   Navigator.pop(context); ///to close drawer
                     print("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");




                  //  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  //    return className();///test purpose
                  //  }
                  //  ));

                }).catchError((error){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message)));
                });

              }
              else {
                ///for other drawer options
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return className();///test purpose
                }
                ));
              }

            },
            child: Row(
              children: [
                Icon(drawerOptionIcon,color: Colors.black,size: 28),
                const SizedBox(
                  width: 10,
                ),
                Text(drawerOptionName,style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400

                ),),
              ],
            ),
          ),
        )
    );
  }
/// Function to determine what action is needed to perform when drawer option is pressed EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

}
