import 'package:finance_management/models/expense.dart';
import 'package:finance_management/repository/expense_repository.dart';
import 'package:flutter/material.dart';

class ExpenseProvider extends ChangeNotifier {

  final ExpenseRepository _expenseRepository;

  List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  ExpenseProvider(this._expenseRepository);

  Future<void> loadExpenses(String userId) async {
    try {
        print('PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP');

      final expenses = await _expenseRepository.getAllExpenses(userId);
      _expenses = expenses;
      notifyListeners();
    } catch (e) {
      print("Error loading expenses: $e");
    }
  }
}