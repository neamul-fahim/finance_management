import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    return  Scaffold(
      body: Column(
            children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                   height: screenSize.height*0.35,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50),) 

                      ),
                    ),

                    Positioned(
                      top: screenSize.height*0.2,
                      left: 20,
                      right: 20,
                      child: Container(
                        height: screenSize.height*0.2,
                        width: screenSize.width,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade300,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    )
                  ],
                )

    ],
      ),
    );
  }
}