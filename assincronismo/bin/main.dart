import 'package:main/exceptions/transaction_exceptions.dart';
import 'package:main/screens/account_screens.dart';
import 'package:main/services/transaction_service.dart';

void main() {
  TransactionService().makeTransaction(idSender: "ID001", idReceiver: "ID002", amount: 5001).catchError((e) {
    print(e.message);
    print("${e.cause.name} possui saldo ${e.cause.balance} menor que ${e.amount + e.taxes}");
  }, test: (error) => error is InsufficientFundsException);
}

// void main() async {
//   // AccountScreens accountScreens = AccountScreens();
//   // accountScreens.initializeStream();
//   // accountScreens.runChatBot();
//   try {
//     await TransactionService().makeTransaction(idSender: "ID001", idReceiver: "ID002", amount: 5001);
//   } on InsufficientFundsException catch (e) {
//     print(e.message);
//     print("${e.cause.name} possui saldo ${e.cause.balance} menor que ${e.amount + e.taxes}");
//   }
// }