
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_management/models/income.dart';
import 'package:finance_management/widget/Add_income_expense_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

class AddIncomeScreen extends StatelessWidget {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController= TextEditingController();
  final TextEditingController sourceController = TextEditingController();


  AddIncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Income'),
                   centerTitle: true,
      ),
      body:  Column(
        children: [
          AddIncomeExpenseForm(
            formKey:formKey ,
            amountController: amountController,
            sourceController: sourceController,
            descriptionController: descriptionController,
            dateController: dateController,
            incomeOrExpense: 'income',
            ),
          ElevatedButton(
                onPressed: () {
                  if(formKey.currentState!.validate()){
                    
                    double amount = double.parse(amountController.text);
                    String source = sourceController.text;
                    String description = descriptionController.text;
                    DateTime date = DateTime.parse(dateController.text);
                   
                    saveIncomeData(amount,source,description,date,context);
                  }
                },
                child: const Text('Add Income'),
              ),
        ],
      )    );
  }
}


Future <void> saveIncomeData ( double amount,String source, String description, DateTime date, BuildContext context) async{

Income income = Income(amount: amount,source: source, description: description, date: date);


try {
   await _db.collection("users").doc(user!.uid).collection("incomes").doc().set(income.toMap());
  // Success message
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Income added successfully')),);

    updateTotalIncome(amount);
} catch (e) {
  // Error handling
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Error adding income: ${e.toString()}')),
  );
}

}


Future <void> updateTotalIncome(double amount)async{

 // Fetch the current total income
    DocumentReference totalIncomeRef = _db.collection("users").doc(user!.uid).collection("total_income").doc("total");
    DocumentSnapshot totalIncomeSnapshot = await totalIncomeRef.get();

    double currentTotalIncome = 0;

    if (totalIncomeSnapshot.exists) {
      // If total_income exists, retrieve it
      currentTotalIncome = totalIncomeSnapshot.get("amount");
    } else {
      // If total_income doesn't exist, initialize it to 0
      await totalIncomeRef.set({"amount": 0});

    }
    

    // Add the new income amount to the total
    double updatedTotalIncome = currentTotalIncome + amount;

    // Update the total income in Firestore
    await totalIncomeRef.update({"amount": updatedTotalIncome});
}