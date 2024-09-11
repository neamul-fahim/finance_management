// import 'package:finance_management/screens/drawer.dart';
import 'package:finance_management/provider/total_income_expense_provider.dart';
import 'package:finance_management/screens/drawer.dart';
import 'package:finance_management/screens/expense_form_screen.dart';
import 'package:finance_management/screens/income_form_screen.dart';
import 'package:finance_management/widget/statistics_report_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   HomePage({super.key});

  @override
  Widget build(BuildContext context) {
            Provider.of<TotalIncomeExpenseProvider>(context,listen:false).fetchTotalIncomeAndExpense(FirebaseAuth.instance.currentUser?.uid ?? '');

    Size screenSize = MediaQuery.of(context).size;
    return  Consumer<TotalIncomeExpenseProvider>(builder: (context,totalIncomeExpenseProvider,child){
      // double netBalance = totalIncomeExpenseProvider.totals!.incomeAmount - totalIncomeExpenseProvider.totals!.expenseAmount;
     return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomAppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                      SizedBox(
                        width: screenSize.width*0.4,
        
                        child: FloatingActionButton(
                          backgroundColor:Colors.deepPurple.shade200 ,
                          onPressed:(){
                                Navigator.push(context, MaterialPageRoute(builder:(BuildContext context)=>AddIncomeScreen()));
                          },
                          child: Text('Add Income',style: TextStyle(color: Colors.white),),
                        ),
                      ),
                     SizedBox(
                        width: screenSize.width*0.4,
        
                        child: FloatingActionButton(
                          backgroundColor:Colors.deepPurple.shade200 ,
                          onPressed:(){
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>AddExpenseScreen()));
                          },
                          child: Text('Add Expence',style: TextStyle(color: Colors.white),),
                        ),
                      ),
                      ],
                     ),
      ),
      body: SingleChildScrollView(
        child: Column(
              children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                     height: screenSize.height*0.35,
                     width: screenSize.width,
                        decoration: const BoxDecoration(
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
                                    child: const Icon(Icons.menu,size: 30,color: Colors.white,)),
                                ),
             
                              ],
                            ),
                            const Row(
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
                          height: screenSize.height*0.22,
                          width: screenSize.width,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.shade300,
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                                    Text("Net Balance",style: TextStyle(color: Colors.white,fontSize: 15),),
                                    totalIncomeExpenseProvider.isLoading?
                                    const CircularProgressIndicator()
                                    :
                                    Text('\$ ${totalIncomeExpenseProvider.totals!.incomeAmount - totalIncomeExpenseProvider.totals!.expenseAmount}',style: TextStyle(color: Colors.white,fontSize: 20),),
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
                                                    Icon(Icons.arrow_circle_up_outlined,color: Colors.white.withOpacity(0.6),),
                                                    const Padding(
                                                      padding: EdgeInsets.all(4.0),
                                                      child: Text('Income',style: TextStyle(color: Colors.white,),),
                                                    )
                                                  ],
                                                ),
                                  
                                                 Row(
                                                  children: [
                                                    totalIncomeExpenseProvider.isLoading?
                                                    const CircularProgressIndicator()
                                                    :
                                                    Text("\$ ${totalIncomeExpenseProvider.totals!.incomeAmount}",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w800,),),
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
                                                    const Padding(
                                                      padding: EdgeInsets.all(4.0),
                                                      child: Text('Expense',style: TextStyle(color: Colors.white,),),
                                                    )
                                                  ],
                                                ),
                                  
                                                 Row(
                                                  children: [
                                                    totalIncomeExpenseProvider.isLoading?
                                                    const CircularProgressIndicator()
                                                    :
                                                    Text("\$ ${totalIncomeExpenseProvider.totals!.expenseAmount}",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w800,),),
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
                  
                  
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: 
                    totalIncomeExpenseProvider.isLoading?
                    const CircularProgressIndicator()
                   :
                    Container(
                      width:screenSize.width,
                      height: screenSize.height*0.4,
                      child: StatisticsReportWidget(totalIncomeExpenseProvider: totalIncomeExpenseProvider)),
                  )
             
                    
          ],
             
          
        ),
      ),
         );
    });
    
  }
}