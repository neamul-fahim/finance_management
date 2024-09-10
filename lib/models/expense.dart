import 'package:cloud_firestore/cloud_firestore.dart';

class Expense {
  final double amount;
  final String description;
  final DateTime date;

  Expense({required this.amount, required this.description, required this.date});



  factory Expense.fromMap(DocumentSnapshot<Map<String,dynamic>> snap) {

     final _ = snap.id;
     final data = snap.data();

    return Expense(
      amount: data?['amount'], 
      description: data?['description'], 
      date: (data!['date'] as Timestamp).toDate(),
      );
  }

  Map<String,dynamic> toMap(){
  return {
    'amount':amount,
    'description':description,
    'date': date,
  };
}


}


