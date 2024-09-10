class Expense {
  final double amount;
  final String description;
  final DateTime date;

  Expense({required this.amount, required this.description, required this.date});




  Map<String,dynamic> toMap(){
  return {
    'amount':amount,
    'description':description,
    'date': date,
  };
}


}


