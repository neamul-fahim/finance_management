import 'package:finance_management/provider/total_income_expense_provider.dart';
import 'package:finance_management/screens/drawer.dart';
import 'package:finance_management/screens/expense_form_screen.dart';
import 'package:finance_management/screens/income_form_screen.dart';
import 'package:finance_management/widget/statistics_report_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _fetchData(); // Fetch data when the page is first loaded
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchData(); // Fetch data when returning to the page
  }

  Future<void> _fetchData() async {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    if (userId.isNotEmpty) {
      await Provider.of<TotalIncomeExpenseProvider>(context, listen: false).fetchTotalIncomeAndExpense(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    
    return Consumer<TotalIncomeExpenseProvider>(
      builder: (context, totalIncomeExpenseProvider, child) {
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
                  width: screenSize.width * 0.4,
                  child: FloatingActionButton(
                    backgroundColor: Colors.deepPurple.shade200,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) => AddIncomeScreen()),
                      );
                    },
                    child: const Text(
                      'Add Income',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: screenSize.width * 0.4,
                  child: FloatingActionButton(
                    backgroundColor: Colors.deepPurple.shade200,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) => AddExpenseScreen()),
                      );
                    },
                    child: const Text(
                      'Add Expense',
                      style: TextStyle(color: Colors.white),
                    ),
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
                      height: screenSize.height * 0.35,
                      width: screenSize.width,
                      decoration: const BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                              Padding(
                                padding: const EdgeInsets.only(top: 25,left: 15),
                                child: InkWell(
                                  onTap: (){
                                    _fetchData();
                                  },
                                  child: Icon(
                                    Icons.refresh,
                                    color: Colors.white,
                                    size: 35,
                                  )),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 25, right: 15),
                                child: InkWell(
                                  onTap: () {
                                    _scaffoldKey.currentState?.openDrawer();
                                  },
                                  child: const Icon(
                                    Icons.menu,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Exin",
                                    style: TextStyle(color: Colors.white, fontSize: 35),
                                  ),
                                  Text(
                                    "Your financial manager",
                                    style: TextStyle(color: Colors.white, fontSize: 15),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: screenSize.height * 0.2,
                      left: 30,
                      right: 30,
                      child: Container(
                        height: screenSize.height * 0.22,
                        width: screenSize.width,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade300,
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, left: 25, right: 25, bottom: 15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        "Net Balance",
                                        style: TextStyle(color: Colors.white, fontSize: 15),
                                      ),
                                      totalIncomeExpenseProvider.isLoading
                                          ? const CircularProgressIndicator()
                                          : Text(
                                              '\$ ${totalIncomeExpenseProvider.totals!.incomeAmount - totalIncomeExpenseProvider.totals!.expenseAmount}',
                                              style: const TextStyle(color: Colors.white, fontSize: 20),
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.arrow_circle_up_outlined,
                                              color: Colors.white.withOpacity(0.6),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: Text(
                                                'Income',
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            totalIncomeExpenseProvider.isLoading
                                                ? const CircularProgressIndicator()
                                                : Text(
                                                    "\$ ${totalIncomeExpenseProvider.totals!.incomeAmount}",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w800,
                                                    ),
                                                  ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.arrow_circle_down_outlined,
                                              color: Colors.white.withOpacity(0.6),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: Text(
                                                'Expense',
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            totalIncomeExpenseProvider.isLoading
                                                ? const CircularProgressIndicator()
                                                : Text(
                                                    "\$ ${totalIncomeExpenseProvider.totals!.expenseAmount}",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w800,
                                                    ),
                                                  ),
                                          ],
                                        )
                                      ],
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
                SizedBox(height: screenSize.height * (0.2 - (0.35 - 0.2))),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: totalIncomeExpenseProvider.isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: screenSize.width,
                          height: screenSize.height * 0.4,
                          child: StatisticsReportWidget(totalIncomeExpenseProvider: totalIncomeExpenseProvider),
                        ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
