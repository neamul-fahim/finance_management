import 'package:cloud_firestore/cloud_firestore.dart';

class Income {
  final double amount;
  final String source;
  final String description;
  final DateTime date;

  Income({required this.amount, required this.source, required this.description, required this.date});

  
  factory Income.fromMap(DocumentSnapshot<Map<String,dynamic>> snap) {

     final _ = snap.id;
     final data = snap.data();

    return Income(
      amount: data?['amount'], 
      source: data?['source'],
      description: data?['description'], 
      date: (data!['date'] as Timestamp).toDate(),
      );
  }

  Map<String,dynamic> toMap(){
  return {
    'amount':amount,
    'source': source,
    'description':description,
    'date': date,
  };
}

}
