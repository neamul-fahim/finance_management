
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_management/models/expense.dart';
import 'package:finance_management/widget/Add_income_expense_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

class AddExpenseScreen extends StatefulWidget {

  AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController amountController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController dateController= TextEditingController();

  final TextEditingController _ = TextEditingController();

   bool isLoadingAddExpence = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Expense'),
                   centerTitle: true,
      ),
      body:  Column(
        children: [
          AddIncomeExpenseForm(
            formKey:formKey ,
            amountController: amountController,
            sourceController: _ ,
            descriptionController: descriptionController,
            dateController: dateController,
            incomeOrExpense: 'expence',
            ),
          ElevatedButton(
                onPressed: () {
                  setState(() {
                    isLoadingAddExpence = true;
                  });
                  if(formKey.currentState!.validate()){
                    
                    double amount = double.parse(amountController.text);
                    String description = descriptionController.text;
                    DateTime date = DateTime.parse(dateController.text);
                   
                    saveExpenseData(amount,description,date,context)
                    .then((v){
                     setState(() {
                       isLoadingAddExpence=false;
                       amountController.text = '';
                    descriptionController.text = '';
                    dateController.text = '';

                     });
                    });
                  }
                },
                child: isLoadingAddExpence
                ? const CircularProgressIndicator()
                :const Text('Add Expense'),
              ),
        ],
      )    );
  }
}


Future <void> saveExpenseData ( double amount, String description, DateTime date, BuildContext context) async{

Expense expense = Expense(amount: amount, description: description, date: date);


try {
  await _db.collection("users").doc(user!.uid).collection("expenses").doc().set(expense.toMap());
  // Success message
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Expense added successfully')),);

    updateTotalExpense(amount);
} catch (e) {
  // Error handling
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Error adding expense: ${e.toString()}')),
  );
}

}


Future <void> updateTotalExpense(double amount)async{

 // Fetch the current total income
    DocumentReference totalExpenseRef = _db.collection("users").doc(user!.uid).collection("total_expense").doc("total");
    DocumentSnapshot totalExpenseSnapshot = await totalExpenseRef.get();

    double currentTotalExpense = 0;

    if (totalExpenseSnapshot.exists) {
      // If total_income exists, retrieve it
      currentTotalExpense = totalExpenseSnapshot.get("amount");
    } else {
      // If total_income doesn't exist, initialize it to 0
      await totalExpenseRef.set({"amount": 0});

    }
    

    // Add the new income amount to the total
    double updatedTotalExpense = currentTotalExpense + amount;

    // Update the total income in Firestore
    await totalExpenseRef.update({"amount": updatedTotalExpense});
}