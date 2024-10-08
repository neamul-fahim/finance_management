

import 'dart:io' as io;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_management/models/user_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
// import '../admin_panel/add_product/add_product_pic.dart';
// import '../models/user_data_model.dart';
import 'custom_textFormField.dart';
import 'login.dart';

class SignIN extends StatefulWidget {
  const SignIN({super.key});

  @override
  State<SignIN> createState() => _SignINState();
}

  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  Reference firebaseStorage= FirebaseStorage.instance.ref();
  User? user=FirebaseAuth.instance.currentUser;
  FirebaseAuth _firebaseAuth=FirebaseAuth.instance;

  
  GlobalKey<FormState> _signinKey= GlobalKey<FormState>();
  TextEditingController signinNameController=TextEditingController();
  TextEditingController signinPhoneNumberController=TextEditingController();
  TextEditingController signinEmailController=TextEditingController();
  TextEditingController signinPassController=TextEditingController();
  TextEditingController signinConfirmPassController=TextEditingController();
  TextEditingController signinAddressController=TextEditingController();

  bool isLoadingSignIn = false;
   var proPic;

class _SignINState extends State<SignIN> {
  @override
  Widget build(BuildContext context) {
    double dynamicHeight=MediaQuery.of(context).size.height;
    double dynamicWidth=MediaQuery.of(context).size.width;

    return
      Scaffold(
       body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            ///  Page title SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
            const Padding(
              padding: EdgeInsets.only(top:30,bottom: 0,right: 0,left:0 ),
              child: Text("SIGNIN",style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize:35
              ),),
            ),
            ///  Page title EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

            const SizedBox(
              height: 10,
            ),

            /// profile pic SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
            InkWell(
              onTap:
                  (){
                showDialog(
                    context: context, builder: (_){
                   var width=MediaQuery.of(context).size.width;
                  return AlertDialog(
                   title: Padding(
                         padding: EdgeInsets.only(left:width*0.6),
                        child: IconButton(
                             icon: const Icon(Icons.cancel),
                           onPressed: (){
                           Navigator.of(context).pop();
                               },
                              ),
                                ),
                                 alignment: Alignment.center,
                                 actionsAlignment: MainAxisAlignment.center,

                                     content: const Text("Choose one option to upload image"),
                                     actions: [
                               ElevatedButton.icon(
                                 style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.deepPurple.shade300)),
                                  onPressed:()async{
                                 Navigator.of(context).pop();

                                 final ImagePicker picker = ImagePicker();

                                    final XFile? image = await picker.pickImage(imageQuality: 50,source: ImageSource.camera);
                                    if(image==null) return;

                              setState(() {
                                proPic=io.File(image.path);
                                    });

                                     } ,
                                    icon: const Icon(Icons.camera_alt),
                                        label: const Text("Camera")),
                                      ElevatedButton.icon(
                                       style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.deepPurple.shade300)),
                                  onPressed:()async{
                                   Navigator.of(context).pop();
                                          final ImagePicker picker = ImagePicker();
                                       final XFile? image = await picker.pickImage(imageQuality:50, source:ImageSource.gallery,);
                                       if(image==null) return;

                                   setState(() {
                                    proPic=io.File(image.path);

                                        });
                                          } ,
                                         icon: const Icon(Icons.image),
                                         label: const Text("Gallery")),
                                              ],
                                             );
                                              });
                                              },
              child: Container(
                height: dynamicHeight*0.14,
               width: dynamicWidth*0.4,
               color: Colors.deepPurple,
                child: proPic==null ? Image.asset("assets/images/profilePic.jpg",fit: BoxFit.fill,) : Image.file(proPic,fit:BoxFit.fill),

              ),
            ),
            /// profile pic EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

            Form(
              key:_signinKey,
              child: Column(
                children: [

                  /// Name field  SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
                  CustomTextField(
                    textInputType: TextInputType.text,
                    textController: signinNameController,
                    ErrorMsg: "This field can't be empty",
                    HintText: "Enter your name",
                    LabelText:  "Name",
                    fieldIcon: Icons.person,
                    obscurePass: false,),

                  /// Name field EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE


                  /// Phone number field SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
                  CustomTextField(
                    textInputType: TextInputType.phone,
                    textController: signinPhoneNumberController,
                    ErrorMsg: "This field can't be empty",
                    HintText: "Enter your phone number",
                    LabelText:  "Phone number",
                    fieldIcon: Icons.phone,
                    obscurePass: false,),
                  /// Phone number field EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE


                  /// Email field  SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
                  CustomTextField(
                    textInputType: TextInputType.emailAddress,
                      textController: signinEmailController,
                      ErrorMsg: "This field can't be empty",
                      HintText: "Enter your email",
                      LabelText:  "Email",
                      fieldIcon: Icons.email_rounded,
                      obscurePass: false,),
                  /// Email field EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

                 /// Address field  SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
                  CustomTextField(
                    textInputType: TextInputType.streetAddress,
                      textController: signinAddressController,
                      ErrorMsg: "This field can't be empty",
                      HintText: "Enter your address",
                      LabelText:  "Address",
                      fieldIcon: Icons.add_location_rounded,
                      obscurePass: false,),
                  /// Address field EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

                  ///Password field  SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
                  CustomTextField(
                    textInputType: TextInputType.text,
                      textController: signinPassController,
                      ErrorMsg: "This field can't be empty",
                      HintText: "Enter your password",
                      LabelText:  "Password",
                      fieldIcon: Icons.shield,
                      obscurePass: true,),
                  ///Password field   EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

                  ///Confirm password field   SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
                  CustomTextField(
                    textInputType: TextInputType.text,
                      textController: signinConfirmPassController,
                      ErrorMsg: "This field can't be empty",
                      HintText: "Retype your password",
                      LabelText:  "Confirm password",
                      fieldIcon: Icons.shield,
                      obscurePass: true,),

                  ///Confirm password field  EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

                  /// Signin button  SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
                  Padding(
                    padding: const EdgeInsets.only(left: 0,right:0 ,top: 2,bottom:0 ),
                    child: SizedBox(
                      height: dynamicHeight*0.06,
                      width: dynamicWidth*0.4,
                      child: ElevatedButton(
                          onPressed:() {
                           

                            if(_signinKey.currentState!.validate()){
                                 
                                 if(proPic!=null) {
                                  setState(() {
                                     isLoadingSignIn = true;
                                    });
                                   fireBaseSignin(signinEmailController.text,signinPassController.text,context)
                                   .then((onValue){
                                    setState(() {
                                      isLoadingSignIn = false;
                                    });
                                   });
                                 } else {
                                   Fluttertoast.showToast(msg:"choose a profile picture");
                                 }
                               }

                          },
                          style:ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.deepPurple)) ,
                          child: isLoadingSignIn
                          ?const CircularProgressIndicator()
                          :const Text("Sign in",style: TextStyle(color: Colors.white,fontSize: 25))),
                    ),
                  ),
                  /// Signin button EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE


                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// Asking if the user have an existing account  SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
                        const Text("Have an account?",style: TextStyle(
                          color: Colors.deepOrangeAccent,),
                        ),
                        /// Asking if the user have an existing account  EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE


                            /// Goto login page if have an account  SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
                        InkWell(
                            onTap: (){
                              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const LogIN()));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:BorderRadius.circular(10),
                                  color: Colors.deepOrangeAccent,
                                ),

                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Login"),
                                )
                            )
                        ),
                        /// Goto login page if have an account  EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
                 

                  ///To signup using FirebaseAuth SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
         Future<void> fireBaseSignin(String email,String password,BuildContext context)async {

  _firebaseAuth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim())
  .then((value){
      Fluttertoast.showToast(msg: "Signin successful");
      saveUserData();///saving user data
      loginEmailController.text=signinEmailController.text;///if signup is successful the login page will auto fill with signup values
      loginPassController.text=signinPassController.text;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LogIN()));
  }).catchError((error) {
    Fluttertoast.showToast(timeInSecForIosWeb: 3,msg: error.message);///Here (.message) is a firebase defined message which describes the specific error occurred
  });
  }
            ///To signup using FirebaseAuth  EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE


        /// TO save user sign up data to firestore SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
  Future<void> saveUserData ()async{
    ///profile Pic save SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
    var fireStorePath=firebaseStorage.child("finance-management").child("users").child(user!.uid).child("pics");
    await fireStorePath.putFile(proPic);
    var imgURL=await fireStorePath.getDownloadURL();
    ///profile Pic save EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE


     UserDataModel userDataModel=UserDataModel(
       uid: user!.uid,
       name: signinNameController.text.trim(),
       email: signinEmailController.text.trim(),
       phone: signinPhoneNumberController.text.trim(),
       address: signinAddressController.text.trim(),
       profilePicURL: imgURL.trim(),
     );

    /// user data save SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
        DocumentReference userInfoRef = firebaseFirestore.collection("users").doc(user!.uid).collection("user_info").doc("info");
           await userInfoRef.set(userDataModel.toMap());
    /// user data save EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
     Fluttertoast.showToast(msg: "Data saved successfully");
  }
         ///TO save user sign up data to firestore EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE