

   import 'package:flutter/material.dart';
   import 'signin.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  TextEditingController? textController;
  String ErrorMsg;
  String HintText;
  String LabelText;
  IconData fieldIcon;
  bool obscurePass;
  dynamic textInputType;

  CustomTextField({super.key,
    required this.textController,
    required this.ErrorMsg,
    required this.HintText,
    required this.LabelText,
    required this.fieldIcon,
    required this.obscurePass,
    required this.textInputType,

  });


  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}



class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        keyboardType: widget.textInputType,
        controller: widget.textController,
             ///validation of textformfield SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
        validator: (inputString){
          if(inputString==null || inputString.isEmpty)
          {
            return widget.ErrorMsg;
          }
          else if(widget.LabelText=="Confirm password" && signinPassController.text!=signinConfirmPassController.text)  ///signinPassController and signinConfirmPassController controllers are defined globally in signin class thus importing the signin package makes the controllers accessible in this widget
            {
              return "Password doesn't match";
            }
          return null;

        },
             ///Validation of textformfield EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE



        showCursor: true,
        cursorColor: Colors.deepPurple.shade300,
        obscureText: widget.obscurePass,
        obscuringCharacter: "*",
        // cursorHeight: 30,


        ///Decoration SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
        decoration: InputDecoration(

          ///Password obscure or show eye button   SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
    suffixIcon: InkWell(

          onTap: (){
            setState(() {
              if(widget.fieldIcon==Icons.shield || widget.fieldIcon==Icons.remove_red_eye_rounded) {
                if (widget.obscurePass == false)
                {
                  widget.obscurePass = true;
                  widget.fieldIcon=Icons.shield;
                }
                else
                {
                  widget.obscurePass = false;
                  widget.fieldIcon=Icons.remove_red_eye_rounded;
                }
              }

            });

          },
            child: Icon(widget.fieldIcon,
              color: Colors.black,
            ),
          ),

          ///Password obscure or show eye button   EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE


          hintText: widget.HintText,
          label:Text(widget.LabelText,style: TextStyle(color: Colors.black.withOpacity(0.5),),),


          labelStyle: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontWeight: FontWeight.w800
          ),


          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              //style: BorderStyle.solid,
              width: 2.5,
              color: Colors.deepPurple.shade300,
            ),

            borderRadius: BorderRadius.only(topLeft:Radius.circular(10) ,topRight:Radius.circular(10) ,
                bottomLeft:Radius.circular(10) ,bottomRight:Radius.circular(10) ),
          ),

          enabledBorder:  UnderlineInputBorder(
            borderSide: BorderSide(
              //style: BorderStyle.solid,
              width: 2.5,
              color: Colors.deepPurple.shade300,
            ),


          ),

          errorBorder:const UnderlineInputBorder(
            borderSide: BorderSide(
              //style: BorderStyle.solid,
              width: 2.5,
              color: Colors.red,
            ),

            borderRadius: BorderRadius.only(topLeft:Radius.circular(10) ,topRight:Radius.circular(0) ,
                bottomLeft:Radius.circular(0) ,bottomRight:Radius.circular(10) ),
          ),

          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              //style: BorderStyle.solid,
              width: 2.5,
              color: Colors.red,
            ),

            borderRadius: BorderRadius.only(topLeft:Radius.circular(10) ,topRight:Radius.circular(0) ,
                bottomLeft:Radius.circular(0) ,bottomRight:Radius.circular(10) ),
          ),


        ),

        ///Decoration EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
      ),
    );
  }
}