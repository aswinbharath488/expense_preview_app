import '../../domain/entities/transaction.dart';

class TransactionModel extends Transaction {
  TransactionModel({
    required super.id,
    required super.title,
    required super.category,
    required super.amount,
    required super.date,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      amount: (json['amount']).toDouble(),
      date: DateTime.parse(json['date']),
    );
  }
}
