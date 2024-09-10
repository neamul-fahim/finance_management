
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_management/models/expense.dart';
import 'package:finance_management/widget/Add_income_expense_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

class AddExpenseScreen extends StatelessWidget {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController= TextEditingController();


  AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Expense'),
                   centerTitle: true,
      ),
      body:  Column(
        children: [
          AddIncomeExpenseForm(formKey:formKey ,amountController: amountController,descriptionController: descriptionController,dateController: dateController,),
          ElevatedButton(
                onPressed: () {
                  if(formKey.currentState!.validate()){
                    
                    double amount = double.parse(amountController.text);
                    String description = descriptionController.text;
                    DateTime date = DateTime.parse(dateController.text);
                   
                    saveExpenseData(amount,description,date,context);
                  }
                },
                child: Text('Add Expense'),
              ),
        ],
      )    );
  }
}


Future <void> saveExpenseData ( double amount, String description, DateTime date, BuildContext context) async{

Expense expense = Expense(amount: amount, description: description, date: date);
// print('=============================================================================================================================');
// print('=============================================================================================================================');
// print(expense);


try {
  await _db.collection("users").doc(user!.uid).collection("expenses").doc().set(expense.toMap());
  // Success message
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Expense added successfully')),
  );
} catch (e) {
  // Error handling
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Error adding expense: ${e.toString()}')),
  );
}

}