import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class AddIncomeExpenseForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController amountController;
  final TextEditingController descriptionController;
  final TextEditingController dateController;


  const AddIncomeExpenseForm({super.key,
    required this.formKey,
    required this.amountController,
    required this.descriptionController,
    required this.dateController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount'),
                validator: (input){
                 if(input == null || input.isEmpty){
                  return "Field can't be null";
                 }
                 return null;
                },

              ),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (input){
                if(input==null || input.isEmpty){
                  return "Field can't be null";
                }
                return null;
                },
              ),
              TextFormField(
              controller: dateController,
              decoration: const InputDecoration(labelText: 'Date'),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  // Use DateFormat to format the picked date correctly
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  dateController.text = formattedDate;
                }
              },
              validator: (input) {
                if (input == null || input.isEmpty) {
                  return "Field can't be null";
                }
                return null;
              },
            ),
              
            ],
          ),
        ),
      );
  }
}