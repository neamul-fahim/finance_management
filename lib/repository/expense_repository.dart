import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_management/models/expense.dart';

class ExpenseRepository {
  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Expense>> getAllExpenses(String userId) async {

  final List<Expense> expenses = [];

  try{
  final expensesRef = _firestore.collection("users").doc(userId).collection("expenses");

  final snapshot = await expensesRef.get();
 for (int i=0;i<snapshot.docs.length;i++) {
               expenses.add(Expense.fromMap(snapshot.docs[i]));
                }
              }catch(e){
                   print("*********************************************ERROR***************************************");
                  print(e.toString());
                  }                   

  return expenses;
}

}