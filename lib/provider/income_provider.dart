import 'package:finance_management/models/income.dart';
import 'package:finance_management/repository/income_repository.dart';
import 'package:flutter/material.dart';

class IncomeProvider extends ChangeNotifier {

  final IncomeRepository _incomeRepository;

  List<Income> _incomes = [];

  List<Income> get incomes => _incomes;

  IncomeProvider(this._incomeRepository);

  Future<void> loadIncomes(String userId) async {
    try {
        print('PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP');

      final incomes = await _incomeRepository.getAllIncome(userId);
      _incomes = incomes;
      notifyListeners();
    } catch (e) {
      print("Error loading incomes: $e");
    }
  }
}