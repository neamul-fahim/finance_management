import 'package:finance_management/models/total_income_expence.dart';
import 'package:finance_management/repository/total_income_expense_repository.dart';
import 'package:flutter/material.dart';

class TotalIncomeExpenseProvider with ChangeNotifier {
  TotalIncomeExpense? _totals;

  TotalIncomeExpense? get totals => _totals;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final TotalIncomeExpenseRepository _repository = TotalIncomeExpenseRepository();

  // Method to fetch total income and expense
  Future<void> fetchTotalIncomeAndExpense(String userId) async {
    _isLoading = true;
    notifyListeners();
    
    _totals = await _repository.getTotalIncomeAndExpense(userId);

    _isLoading = false;
    notifyListeners();
  }
}
