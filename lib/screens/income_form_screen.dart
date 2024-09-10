
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_management/models/expense.dart';
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

Income expense = Income(amount: amount,source: source, description: description, date: date);


try {
  await _db.collection("users").doc(user!.uid).collection("incomes").doc().set(expense.toMap());
  // Success message
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Income added successfully')),
  );
} catch (e) {
  // Error handling
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Error adding income: ${e.toString()}')),
  );
}

}