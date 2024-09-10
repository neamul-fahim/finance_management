import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_management/models/expense.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExpenseRepository {
  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final uid = '18DrbyyxN2f9hqmJ0vCBq6vHkzy2';

  // Future<List<Expense>> getAllExpenses() async {
  //   print('RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR');

  //   final List<Expense> expenses = [];
  //   final expensesRef = _firestore.collection("users").doc(uid).collection("expenses");

  //   final snapshotStream = expensesRef.snapshots();

  //   await for (var snapshot in snapshotStream) {
  //     for (var doc in snapshot.docs) {
  //       expenses.add(Expense.fromMap(doc));
  //     }
  //   }
  //   print('RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR');
  //   // print(expenses);

  //   return expenses;
  // }

  Future<List<Expense>> getAllExpenses(String userId) async {
        print('RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR');

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

  print(expenses);
  return expenses;
}

}