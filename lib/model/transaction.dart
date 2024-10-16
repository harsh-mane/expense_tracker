class Transaction {
  late final String title;
  late final double amount;
  late final DateTime date;

  Transaction({required this.title, required this.amount, required this.date});

  Transaction.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? 'Empty';
    amount = json['amount'] ?? 0;
    date = DateTime.tryParse(json['date']) ?? DateTime.now();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['amount'] = amount;
    data['date'] = date.toString();
    return data;
  }
}
