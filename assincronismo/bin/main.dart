import 'package:main/screens/account_screens.dart';

void main() {
  AccountScreens accountScreens = AccountScreens();
  accountScreens.initializeStream();
  accountScreens.runChatBot();
}