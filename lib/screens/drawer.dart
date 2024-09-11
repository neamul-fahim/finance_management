
import 'package:finance_management/auth/login.dart';
import 'package:finance_management/provider/user_data_provider.dart';
import 'package:finance_management/screens/expense_screen.dart';
import 'package:finance_management/screens/income_screen.dart';
import 'package:finance_management/screens/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CustomAppDrawer extends StatefulWidget {
  const CustomAppDrawer({super.key,});

  @override
  State<CustomAppDrawer> createState() => _CustomAppDrawerState();
}



class _CustomAppDrawerState extends State<CustomAppDrawer> {
  // final _db=FirebaseFirestore.instance;
  // var name="Name";
  // String imgURL="";
  // bool once=false;


  @override
  Widget build(BuildContext context) {

    
    double dynamicHeight=MediaQuery.of(context).size.height;
    double dynamicWidth=MediaQuery.of(context).size.width;

    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    Provider.of<UserDataProvider>(context,listen: false).getUserData(userId);

        return Consumer<UserDataProvider>(builder: (context,userDataProvider,child){
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

                        child: 
                        
                            userDataProvider.isLoading || (userDataProvider.isLoading == false && userDataProvider.userData!.uid.isEmpty)
                            ?Image.asset("assets/images/profilePic.jpg",fit: BoxFit.fill,)
                            :Image.network(userDataProvider.userData!.profilePicURL,fit: BoxFit.fill,),
                      ),
                      /// Profile pic EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE


                      Text(
                        userDataProvider.isLoading || (userDataProvider.isLoading == false && userDataProvider.userData!.uid.isEmpty)
                        ? 'Name'
                        :
                        userDataProvider.userData!.name, //appDrawerProvider.appDrawerModelClass.profileName.toString(),
                        style:const TextStyle(fontSize: 20,fontWeight:FontWeight.w400,color: Colors.white, ) ),///User name


                     const SizedBox(
                        height: 60,
                      ),
                      /// Drawer options SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS

                      drawerProperty(Icons.arrow_circle_up_outlined, 'All income',context,()=>const IncomeScreen()),
                      drawerProperty(Icons.arrow_circle_down_outlined, 'All expense',context,()=>const ExpenseScreen()),

                      //drawerProperty(Icons.cloud_rounded, 'Weather',context,()=>Weather()),
                     const Divider(
                        //color: Colors.black,
                        thickness: 1,
                        height: 20,
                          indent: 15,
                        endIndent: 15,
                      ),
                      // drawerProperty(Icons.cloud_rounded, 'Signin',context,()=>const SignIN()),
                      // drawerProperty(Icons.cloud_rounded, 'Login',context,()=>const LogIN()),
                      drawerProperty(Icons.logout_rounded, 'Logout',context,()=>const HomeScreen()),
                      /// Drawer options EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
                    ],
                  ),
                ),
              ),
            );
        });
            
  }



   /// Function to determine what action is needed to perform when drawer option is pressed   SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
  Container drawerProperty(IconData drawerOptionIcon,String drawerOptionName,BuildContext context,Widget Function() className){
    return Container(
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () async{
              if(drawerOptionIcon==Icons.logout_rounded){ // for logout
                 FirebaseAuth.instance.signOut()
                 .then((value) {
                   Fluttertoast.showToast(msg: "loged out");
                    
                   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>LogIN()));
                  //  Navigator.pop(context); ///to close drawer

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
                Icon(drawerOptionIcon,color: Colors.white,size: 28),
                const SizedBox(
                  width: 10,
                ),
                Text(drawerOptionName,style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,

                ),),
              ],
            ),
          ),
        )
    );
  }
/// Function to determine what action is needed to perform when drawer option is pressed EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

}
