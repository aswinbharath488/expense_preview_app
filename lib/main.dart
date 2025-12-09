import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/datasources/transaction_local_datasource.dart';
import 'data/repositories/transaction_repository_impl.dart';
import 'domain/usecases/get_transactions.dart';
import 'presentation/bloc/transaction_bloc.dart';
import 'presentation/pages/expense_page.dart';

void main() {
  final repo = TransactionRepositoryImpl(TransactionLocalDataSource());

  runApp(MyApp(repo: repo));
}

class MyApp extends StatelessWidget {
  final TransactionRepositoryImpl repo;
  const MyApp({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TransactionBloc(GetTransactions(repo)),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Expense Preview",
        home: ExpensePage(),
      ),
    );
  }
}
