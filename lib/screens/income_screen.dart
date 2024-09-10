
import 'package:finance_management/provider/income_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class IncomeScreen extends StatefulWidget {
  const IncomeScreen({Key? key}) : super(key: key);

  @override
  _IncomeScreenState createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  @override
  void initState() {
    super.initState();
    final incomeProvider = Provider.of<IncomeProvider>(context, listen: false);
    incomeProvider.loadIncomes(FirebaseAuth.instance.currentUser?.uid ?? '');
  }
  @override
  Widget build(BuildContext context) {
    final incomeProvider = Provider.of<IncomeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Your Incomes'),
        iconTheme: const IconThemeData(
          color: Colors.deepPurple
        ),
        ),
      body: ListView.builder(
        itemCount: incomeProvider.incomes.length,
        itemBuilder: (context, index) {
          final income = incomeProvider.incomes[index];
          return Card(
            child: ListTile(
  title: Text('Amount: ${income.amount}'),
  subtitle: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Description: ${income.description}'),
      Text('Source: ${income.source}'), // Add the source here
    ],
  ),
  trailing: Text('Date: ${income.date.toLocal().toString()}'),
)

          );
        },
      ),
    );
  }
}

