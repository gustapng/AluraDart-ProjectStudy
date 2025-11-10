import 'dart:async';

import 'package:http/http.dart';
import 'dart:convert';

import 'package:main/api_key.dart';

StreamController<String> streamController = StreamController<String>();


void main() {
  StreamSubscription streamSubscription = streamController.stream.listen((String info) {
    print(info);
  },);
  requestData();
  requestDataAsync();
  sendDataAsync({
    "id": "ID011",
    "name": "Maria",
    "lastName": "Teste",
    "balance": 2222.0
  });
}

requestData() {
  String url = "https://gist.githubusercontent.com/gustapng/0544f7f4bd942f47b8af0f91877aec96/raw/e0b4a8abf52bd44aee195ba0143cfee6df8411be/accounts.json";
  Future<Response> futureResponse = get(Uri.parse(url));

  futureResponse.then((Response response) {
    streamController.add("${DateTime.now()} | Requisição de leitura (usando then)");
  });
}

Future<List<dynamic>> requestDataAsync() async {
  String url = "https://gist.githubusercontent.com/gustapng/0544f7f4bd942f47b8af0f91877aec96/raw/e0b4a8abf52bd44aee195ba0143cfee6df8411be/accounts.json";
  Response response = await get(Uri.parse(url));
  streamController.add("${DateTime.now()} | Requisição de leitura (usando async)");
  return json.decode(response.body);
}

sendDataAsync(Map<String, dynamic> MapAccount) async {
  List<dynamic> listAccounts = await requestDataAsync();
  listAccounts.add(MapAccount);
  String content = json.encode(listAccounts);

  String url = "https://api.github.com/gists/0544f7f4bd942f47b8af0f91877aec96";
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
    streamController.add("${DateTime.now()} | Requisição de adição bem sucedida! (${MapAccount["name"]}).");
  } else {
    streamController.add("${DateTime.now()} | Requisição de falhou");
  }
}