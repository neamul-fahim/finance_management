import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_management/models/total_income_expence.dart';


class TotalIncomeExpenseRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<TotalIncomeExpense?> getTotalIncomeAndExpense(String userId) async {
    try {
      DocumentReference totalIncomeRef = _db.collection("users").doc(userId).collection("total_income").doc("total");
      DocumentSnapshot totalIncomeSnapshot = await totalIncomeRef.get();
      double totalIncome = totalIncomeSnapshot.exists
          ? totalIncomeSnapshot.get("amount")
          : 0.0;

      DocumentReference totalExpenseRef = _db.collection("users").doc(userId).collection("total_expense").doc("total");
      DocumentSnapshot totalExpenseSnapshot = await totalExpenseRef.get();
      double totalExpense = totalExpenseSnapshot.exists
          ? totalExpenseSnapshot.get("amount")
          : 0.0;

      return TotalIncomeExpense(incomeAmount: totalIncome, expenseAmount: totalExpense);
    } catch (e) {
      print('Error fetching total income and expense: ${e.toString()}');
      return null; 
    }
  }
}
