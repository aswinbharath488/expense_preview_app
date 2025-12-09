import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/transaction_local_datasource.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionLocalDataSource dataSource;
  TransactionRepositoryImpl(this.dataSource);

  @override
  Future<List<Transaction>> getTransactions() {
    return dataSource.loadJson();
  }
}
