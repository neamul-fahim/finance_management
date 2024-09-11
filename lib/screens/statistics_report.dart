import 'package:finance_management/provider/total_income_expense_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatisticsReport extends StatelessWidget {
  const StatisticsReport({super.key});


  final double totalIncome = 10000;
  final double totalExpenses = 5000;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

      Provider.of<TotalIncomeExpenseProvider>(context,listen:false).fetchTotalIncomeAndExpense(FirebaseAuth.instance.currentUser?.uid ?? '');

    double netBalance = totalIncome - totalExpenses;

    return Consumer<TotalIncomeExpenseProvider>(builder: (context,totalIncomeExpenseProvider,child){
     return  Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.deepPurple,
        ),
        centerTitle: true,
        title: const Text(
          'Statistics Report',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: 
      Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: PieChart(
            // Animation Duration
            swapAnimationDuration: const Duration(milliseconds: 700),
            swapAnimationCurve: Curves.easeInOutQuint,
            PieChartData(
              sections: [
                PieChartSectionData(
                  color: Colors.green,
                  value: totalIncomeExpenseProvider.totals!.incomeAmount,
                  title: 'Income',
                  radius: 50,
                  titleStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                PieChartSectionData(
                  color: Colors.red,
                  value: totalIncomeExpenseProvider.totals!.expenseAmount,
                  title: 'Expenses',
                  radius: 50,
                  titleStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                PieChartSectionData(
                  color: Colors.blue,
                  value: (totalIncomeExpenseProvider.totals!.incomeAmount-totalIncomeExpenseProvider.totals!.expenseAmount).abs(),
                  title: 'Net Balance',
                  radius: 50,
                  titleStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
              sectionsSpace: 10,
              centerSpaceRadius: screenSize.width * 0.3,
            ),
          ),
        ),
      ),
    );

    });
    
     }
}
