
import 'package:finance_management/provider/expense_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({Key? key}) : super(key: key);

  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  @override
  void initState() {
    super.initState();
    final expenseProvider = Provider.of<ExpenseProvider>(context, listen: false);
    expenseProvider.loadExpenses(FirebaseAuth.instance.currentUser?.uid ?? '');
  }
  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Your Expenses'),
        iconTheme: const IconThemeData(
          color: Colors.deepPurple
        ),
        ),
      body: ListView.builder(
        itemCount: expenseProvider.expenses.length,
        itemBuilder: (context, index) {
          final expense = expenseProvider.expenses[index];
          return Card(
            child: ListTile(
              title: Text('Amount: ${expense.amount}'),
              subtitle: Text('Description: ${expense.description}'),
              trailing: Text('Date: ${expense.date.toLocal().toString()}'),
            ),
          );
        },
      ),
    );
  }
}

