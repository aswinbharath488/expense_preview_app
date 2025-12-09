import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/transaction_bloc.dart';
import '../bloc/transaction_event.dart';
import '../bloc/transaction_state.dart';
import '../widgets/expense_tile.dart';
import '../widgets/empty_view.dart';
import '../../core/constants/colors.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  final TextEditingController searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TransactionBloc>().add(LoadTransactions());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          "Expense Preview",
          style: TextStyle(color: AppColors.textPrimary),
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: searchCtrl,
              onChanged: (v) {
                context.read<TransactionBloc>().add(SearchTransactions(v));
              },
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.searchBg,
                hintText: "Search expenses...",
                hintStyle: const TextStyle(color: AppColors.textSecondary),
                prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // List
          Expanded(
            child: BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.income),
                  );
                }

                if (state.transactions.isEmpty) {
                  return const EmptyView();
                }

                return ListView.builder(
                  itemCount: state.transactions.length,
                  itemBuilder: (_, i) =>
                      ExpenseTile(data: state.transactions[i]),
                );
              },
            ),
          ),
        ],
      ),

      // Floating Button (Dark styled)
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.income,
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: AppColors.card,
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (_) => const AddTransactionSheet(),
          );
        },
      ),
    );
  }
}

class AddTransactionSheet extends StatelessWidget {
  const AddTransactionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final titleCtrl = TextEditingController();
    final amtCtrl = TextEditingController();
    final catCtrl = TextEditingController();

    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        20,
        20,
        MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Add Transaction",
              style: TextStyle(
                fontSize: 18,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 14),

          _textField("Title", titleCtrl),
          const SizedBox(height: 12),
          _textField("Amount", amtCtrl, inputType: TextInputType.number),
          const SizedBox(height: 12),
          _textField("Category", catCtrl),

          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.income,
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              print({
                "title": titleCtrl.text,
                "amount": amtCtrl.text,
                "category": catCtrl.text,
              });
              Navigator.pop(context);
            },
            child: const Text("Submit"),
          )
        ],
      ),
    );
  }

  Widget _textField(String hint, TextEditingController ctrl,
      {TextInputType inputType = TextInputType.text}) {
    return TextField(
      controller: ctrl,
      keyboardType: inputType,
      style: const TextStyle(color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textSecondary),
        filled: true,
        fillColor: AppColors.searchBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
