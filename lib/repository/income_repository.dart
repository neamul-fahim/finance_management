import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_management/models/income.dart';

class IncomeRepository {
  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Income>> getAllIncome(String userId) async {

  final List<Income> incomes = [];

  try{
  final incomesRef = _firestore.collection("users").doc(userId).collection("incomes");

  final snapshot = await incomesRef.get();
 for (int i=0;i<snapshot.docs.length;i++) {
               incomes.add(Income.fromMap(snapshot.docs[i]));
                }
              }catch(e){
                   print("*********************************************ERROR***************************************");
                  print(e.toString());
                  }             

      print('iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
      print(incomes);                  

  return incomes;
}

}