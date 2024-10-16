import 'package:expense_tracker/model/transaction.dart';
import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback deleteTransaction;

  const ExpenseCard(
      {super.key, required this.transaction, required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: deleteTransaction,
            ),

            //
            Text(
              "${transaction.title} ",
            ),
            Text(
              "${transaction.date.day}/${transaction.date.month}/${transaction.date.year}",
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text("₹${transaction.amount.toStringAsFixed(2)}"),
          ],
        ),
      ),
    );
  }
}
