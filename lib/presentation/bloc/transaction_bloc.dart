import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_transactions.dart';
import '../../domain/entities/transaction.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetTransactions getTransactions;
  List<Transaction> _fullData = [];

  TransactionBloc(this.getTransactions) : super(const TransactionState()) {
    on<LoadTransactions>(_loadData);
    on<SearchTransactions>(_searchData);
  }

  Future<void> _loadData(
      LoadTransactions event, Emitter<TransactionState> emit) async {
    emit(state.copyWith(isLoading: true));
    _fullData = await getTransactions();
    emit(state.copyWith(transactions: _fullData, isLoading: false));
  }

  void _searchData(
      SearchTransactions event, Emitter<TransactionState> emit) {
    final query = event.query.toLowerCase();
    final filtered = _fullData
        .where((e) => e.title.toLowerCase().contains(query))
        .toList();

    emit(state.copyWith(transactions: filtered, searchQuery: event.query));
  }
}
