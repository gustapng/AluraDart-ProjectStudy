import 'dart:async';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:main/api_key.dart';
import 'package:main/models/account.dart';

class AccountService {
  StreamController<String> _streamController = StreamController<String>();
  Stream<String> get streamInfos => _streamController.stream;
  String url = "https://api.github.br/gists/0544f7f4bd942f47b8af0f91877aec96";

  Future<List<Account>> getAll() async {
    Response response = await get(Uri.parse(url));
    _streamController.add("${DateTime.now()} | Requisição de leitura (usando async)");

    Map<String, dynamic> MapResponse = json.decode(response.body);
    List<dynamic> listDynamic = json.decode(MapResponse["files"]["accounts.json"]["content"]);

    List<Account> listAccounts = [];

    for (dynamic dyn in listDynamic) {
      Map<String, dynamic> mapAccount = dyn as Map<String, dynamic>;
      Account account = Account.fromMap(mapAccount);
      listAccounts.add(account);
    }

    return listAccounts;
  }

  addAccount(Account account) async {
  List<Account> listAccounts = await getAll();
  listAccounts.add(account);
  
  List<Map<String, dynamic>> listContent = [];
  for (Account account in listAccounts) {
    listContent.add(account.toMap());
  }
  
  String content = json.encode(listContent);

  Response response = await post(Uri.parse(url), headers: {
    "Authorization" : "Bearer $githubApiKey"
  }, body: json.encode({
    "description": "account.json",
    "public": true,
    "files": {
      "accounts.json": {
        "content": content,
      }
    }
  }),);

  if (response.statusCode.toString()[0] == "2") {
    _streamController.add("${DateTime.now()} | Requisição de adição bem sucedida! (${account.name}).");
  } else {
    _streamController.add("${DateTime.now()} | Requisição de falhou (${account.name}).");
  }
}
}

  // StreamSubscription streamSubscription = streamController.stream.listen((String info) {
  //   print(info);
  // },);
  // requestData();
  // requestDataAsync();
  // sendDataAsync({
  //   "id": "ID011",
  //   "name": "Maria",
  //   "lastName": "Teste",
  //   "balance": 2222.0
  // });