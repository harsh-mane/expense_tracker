import 'package:expense_tracker/service/pref.dart';
import 'package:expense_tracker/widget/expense_card.dart';
import 'package:flutter/material.dart';

import 'model/transaction.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final List<Transaction> _transactions = Pref.getList();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.sizeOf(context);

    final totalAmount = _transactions.fold(0.0, (prev, e) => prev + e.amount);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        //app bar
        appBar: AppBar(title: const Text("Expense Tracker")),

        //body
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            left: mq.width * .04,
            right: mq.width * .04,
            top: mq.height * .02,
            bottom: mq.height * .1,
          ),

          //column
          child: Column(
            children: [
              //
              Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: mq.height * .02,
                  ),
                  child: Column(
                    children: [
                      //no. of transactions
                      Row(
                        children: [
                          const Icon(Icons.calendar_month_outlined),
                          const SizedBox(width: 8.0),
                          Text("No. of Transactions: ${_transactions.length}",
                              style: const TextStyle(fontSize: 18)),
                        ],
                      ),

                      //
                      const SizedBox(height: 20),

                      //
                      Row(
                        children: [
                          const Icon(Icons.wallet),
                          const SizedBox(width: 8.0),
                          Text("Total Amount: ₹$totalAmount",
                              style: const TextStyle(fontSize: 18)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              //
              Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: mq.height * .02,
                  ),
                  child: Column(
                    children: [
                      // title field
                      TextField(
                        controller: _titleController,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          label: Text('Title'),
                          prefixIcon: Icon(Icons.title_rounded),
                          border: OutlineInputBorder(),
                        ),
                      ),

                      // for adding some space
                      const SizedBox(height: 20),

                      // amount field
                      TextField(
                        controller: _amountController,
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text('Amount'),
                          prefixIcon: Icon(Icons.currency_rupee_rounded),
                          border: OutlineInputBorder(),
                        ),
                      ),

                      //
                      const SizedBox(height: 5),

                      //add transaction
                      ElevatedButton.icon(
                        onPressed: _addTransaction,
                        icon: const Icon(Icons.add),
                        label: const Text("Add Transaction"),
                      ),
                    ],
                  ),
                ),
              ),

              //transactions
              ..._transactions.map((e) => ExpenseCard(
                    transaction: e,
                    deleteTransaction: () {
                      setState(() => _transactions.remove(e));
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addTransaction() async {
    // remove keyboard focus
    FocusScope.of(context).requestFocus(FocusNode());

    if (_amountController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Enter an Amount"),
        ),
      );
    } else {
      setState(() {
        _transactions.add(Transaction(
          title: _titleController.text,
          amount: double.parse(_amountController.text),
          date: DateTime.now(),
        ));
        _titleController.clear();
        _amountController.clear();
      });

      await Pref.storeList(_transactions);
      // Pref.getList();
    }
  }
}
