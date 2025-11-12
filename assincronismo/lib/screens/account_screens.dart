import 'dart:io';

import 'package:http/http.dart';
import 'package:main/models/account.dart';
import 'package:main/services/account_service.dart';

class AccountScreens {
  AccountService _accountService = AccountService();

  void initializeStream() {
    _accountService.streamInfos.listen((event) {
      print(event);
    });
  }

  void runChatBot() async {
    print("Bom dia! Eu sou o Lewis, assistente do Banco d'Ouro!");
    print("Que bom te ter aqui com a gente.\n");

    bool isRunning = true;
    while (isRunning) {
      print("Como eu posso te ajudar? (digite o número desejado)");
      print("1 - Ver todas sua contas.");
      print("2 - Adicionar nova conta.");
      print("3 - Sair\n");

      String? input = stdin.readLineSync();
      if (input != null) {
        switch (input) {
          case "1":
            {
              await _getAllAccounts();
              break;
            }
          case "2":
            {
              await _addExampleAccount();
              break;
            }
          case "3":
            {
              isRunning = false;
              print("Te vejo na proxima.");
              break;
            }
          default:
            {
              print("Não entendi, tente novamente.");
            }
        }
      }
    }
  }

  _getAllAccounts() async {
    try {
      List<Account> listAccounts = await _accountService.getAll();
      print(listAccounts);
    } on ClientException catch (clientException) {
      print("Não foi possível alcançar o servidor.");
      print("Tente novamente mais tarde.");
      print(clientException.message);
      print(clientException.uri);
    } on Exception {
      print("Não consegui recuperar os dados da conta.");
      print("Tente novamente mais tarde.");
    } finally {
      print("${DateTime.now()} - Ocorreu uma tentativa de consulta.");
    }
  }

  _addExampleAccount() async {
    try {
      Account example = Account(id: "12345", name: "Teste", lastName: "Testando", balance: 123.654, accountType: "Brigadeiro");
      await _accountService.addAccount(example);
    } on Exception {
      print("Ocorreu um erro ao tentar adicionar");
    }
  }
}