import 'package:equatable/equatable.dart';
import '../../domain/entities/transaction.dart';

class TransactionState extends Equatable {
  final List<Transaction> transactions;
  final bool isLoading;
  final String searchQuery;

  const TransactionState({
    this.transactions = const [],
    this.isLoading = false,
    this.searchQuery = "",
  });

  TransactionState copyWith({
    List<Transaction>? transactions,
    bool? isLoading,
    String? searchQuery,
  }) {
    return TransactionState(
      transactions: transactions ?? this.transactions,
      isLoading: isLoading ?? this.isLoading,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [transactions, isLoading, searchQuery];
}
