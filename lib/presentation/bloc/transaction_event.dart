import 'package:equatable/equatable.dart';

abstract class TransactionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTransactions extends TransactionEvent {}

class SearchTransactions extends TransactionEvent {
  final String query;
  SearchTransactions(this.query);

  @override
  List<Object?> get props => [query];
}
