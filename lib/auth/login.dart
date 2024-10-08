
import 'package:finance_management/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'signin.dart';
import 'custom_textFormField.dart';

class LogIN extends StatefulWidget {
  const LogIN({super.key});

  @override
  State<LogIN> createState() => _LogINState();
}

   final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  final GlobalKey<FormState> _loginKey=GlobalKey<FormState>();
  final TextEditingController loginEmailController=TextEditingController();
   final TextEditingController loginPassController=TextEditingController();
   bool isLoadingLogIn =false;

class _LogINState extends State<LogIN> {

  var isHover=true;
  var transform;

  @override
  Widget build(BuildContext context) {

    double dynamicHeight=MediaQuery.of(context).size.height;
    double dynamicWidth=MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,elevation: 0.0,iconTheme: const IconThemeData(color: Colors.deepPurple),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _loginKey,
          child: Column(
            children: [
              /// Page title SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
              const Padding(
                padding:  EdgeInsets.only(top:120 ,bottom: 0,right: 0,left:0 ),
                child: Text("LOGIN",style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize:35
                ),),
              ),
              /// Page title EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

              const SizedBox(
                height: 30,
              ),

              ///Email field  SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
              SizedBox(
                height:  dynamicHeight*0.15,

                width: dynamicHeight*0.9999,

                child: CustomTextField(
                  textInputType: TextInputType.emailAddress,
                  textController: loginEmailController,
                  ErrorMsg: "This field can't be empty",
                  HintText: "Enter your email",
                  LabelText:  "Email",
                  fieldIcon: Icons.email_rounded,
                  obscurePass: false,),
              ),
              ///Email field EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

              ///Password field   SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
              SizedBox(
                height:  dynamicHeight*0.15,
                width: dynamicHeight*0.9999,

                child: CustomTextField(
                  textInputType: TextInputType.text,
                  textController: loginPassController,
                  ErrorMsg: "This field can't be empty",
                  HintText: "Enter your password",
                  LabelText:  "Password",
                  fieldIcon: Icons.shield,
                  obscurePass: true,),
              ),
              ///Password field  EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

              ///Login button SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
              isHover?
              Padding(
                padding: const EdgeInsets.only(left: 0,right:0 ,top: 2,bottom:0 ),
                child: MouseRegion(
                  onEnter: (event)=>onHover(true),
                  onExit: (event)=>onHover(false),
                  child: SizedBox(
                    height: dynamicHeight*0.06,
                    width: dynamicWidth*0.4,
                    child: ElevatedButton(

                        style:ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.deepPurple)) ,
                        onPressed:() {
                          if(_loginKey.currentState!.validate()){
                             setState(() {
                                     isLoadingLogIn = true;
                                    });
                            fireBaseLogin(loginEmailController.text, loginPassController.text, context)
                            .then((onValue){
                              setState(() {
                                     isLoadingLogIn = false;
                                    });

                            });
                          }
                        },
                        child: isLoadingLogIn
                        ? const CircularProgressIndicator()
                        :const Text("LOGIN",style: TextStyle(color: Colors.white,fontSize: 25))),
                  ),
                ),
              ):
              Padding(
                padding: const EdgeInsets.only(left: 0,right:0 ,top: 2,bottom:0 ),
                child: MouseRegion(
                  onEnter: (event)=>onHover(true),
                  onExit: (event)=>onHover(false),
                  child: AnimatedContainer(
                    color: Colors.red,
                    duration: const Duration(milliseconds: 200),
                    transform: transform,
                    height: dynamicHeight*0.06,
                    width: dynamicWidth*0.095,
                    child: const Center(child: Text("LOGIN")),
                  ),
                ),
              ),
              ///Login button EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// Asking if the user have an existing account  SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
                    const Text("Don't have an account?",style: TextStyle(
                      color: Colors.deepOrangeAccent,),),
                    /// Asking if the user have an existing account  EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

                    /// Goto signin page if don't have an account  SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
                    InkWell(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SignIN()));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius:BorderRadius.circular(10),
                              color: Colors.deepOrangeAccent,
                            ),

                            child: const Padding(
                              padding:  EdgeInsets.all(8.0),
                              child:  Text("SIGNIN"),
                            )
                        )
                    ),
                    /// Goto signin page if don't have an account  EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
  onHover(bool hover){
    final anim=Matrix4.identity()..translate(200,0,0);
    setState(() {
      if(hover==true) {
        if (_loginKey.currentState!.validate() == true){
          isHover = true;}
        else {
          isHover = false;
              transform=anim;
        }
      }
       else{transform=Matrix4.identity();}
    });
  }
}

   Future <void> fireBaseLogin(String email,String password,BuildContext context)async{
  if(_loginKey.currentState!.validate()) {}
  {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(), password: password.trim()).then((value) {
      Fluttertoast.showToast(msg: 'Login successful');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));

    }).catchError((error){
      Fluttertoast.showToast(timeInSecForIosWeb: 3,msg: error.message);///Here (.message) is a firebase defined message which describes the specific error occurred
    });
  }
}
