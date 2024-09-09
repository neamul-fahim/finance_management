// import 'package:finance_management/screens/drawer.dart';
import 'package:finance_management/screens/drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    return  Scaffold(
      key: _scaffoldKey,
      drawer: CustomAppDrawer(),
      // floatingActionButton: FloatingActionButton(
        
      //   onPressed: () {
      //   _scaffoldKey.currentState?.openDrawer();
      //   },
      //   child: Icon(Icons.menu),
      // ),
      body: Column(
            children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                   height: screenSize.height*0.35,
                   width: screenSize.width,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40),) 

                      ),
                      child: Column(
                        children: [
                          Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 25,right: 15,),
                                child:InkWell(
                                  onTap: (){
                                    _scaffoldKey.currentState?.openDrawer();
                                  },
                                  child: Icon(Icons.menu,size: 30,color: Colors.white,)),
                              ),

                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                  children: [
                                    Text("Exin",style: TextStyle(color: Colors.white,fontSize: 35),),
                                    Text("Your financial manager",style: TextStyle(color: Colors.white,fontSize: 15),),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Positioned( //current balance, income and expence overlaped container
                      top: screenSize.height*0.2,
                      left: 30,
                      right: 30,
                      child: Container(
                        height: screenSize.height*0.2,
                        width: screenSize.width,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade300,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15,left: 25,right: 25,bottom: 15),
                          child: Column(
                            children: [
                                
                              Row(//Current Balance
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column( 
                                    children: [
                                  Text("Current Balance",style: TextStyle(color: Colors.white,fontSize: 15),),
                                  Text("\$ 0",style: TextStyle(color: Colors.white,fontSize: 20),),
                                    ],
                                  ),
                                ],
                              ),
                          
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container( // Income
                                          child: Column(
                                            children: [
                                              Row( // down arrow and text(income)
                                                children: [
                                                  Icon(Icons.arrow_circle_down_outlined,color: Colors.white.withOpacity(0.6),),
                                                  Padding(
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: Text('Income',style: TextStyle(color: Colors.white,),),
                                                  )
                                                ],
                                              ),
                                
                                              Row(
                                                children: [
                                                  Text("\$ 0",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w800,),),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Container( // Expense
                                          child: Column(
                                            children: [
                                              Row( // down arrow and text(expense)
                                                children: [
                                                  Icon(Icons.arrow_circle_down_outlined,color: Colors.white.withOpacity(0.6),),
                                                  Padding(
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: Text('Expense',style: TextStyle(color: Colors.white,),),
                                                  )
                                                ],
                                              ),
                                
                                              Row(
                                                children: [
                                                  Text("\$ 0",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w800,),),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        
                                        
                                      ],
                                    ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                   
                  ],
                ),

                 SizedBox(height: screenSize.height* (0.2-(0.35-0.2)),), // (Positioned Top - (stack first container height - second container height))
                   Text('hiiiiiiiiiiiiiiii'),
        ],

        
      ),
    );
  }
}