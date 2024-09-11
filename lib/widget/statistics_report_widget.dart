import 'package:finance_management/provider/total_income_expense_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatisticsReportWidget extends StatelessWidget {
  final TotalIncomeExpenseProvider totalIncomeExpenseProvider;
  const StatisticsReportWidget({
  super.key, 
  required this.totalIncomeExpenseProvider});

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    return 
    totalIncomeExpenseProvider.totals!.incomeAmount < 1 && totalIncomeExpenseProvider.totals!.expenseAmount < 1
    ?Center(child: Text('Add some income or expence',style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 20,),))
    :
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
              centerSpaceRadius: screenSize.width * 0.2,
            ),
          ),
        ),
      );
  }
}