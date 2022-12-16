import 'package:firebase_auth/firebase_auth.dart';

String commands = """

!help     : To get emergency medication from nearby hospitals. \n
!date     : Returns the date of the day.\n
!time     : Returns the time.\n

""";

List welcomeMsg() {
  final User user = FirebaseAuth.instance.currentUser;
  String wlcum = "Hi ${user.displayName}, I am Alexa !!!";

  String cmnd = "Type !commands for basic commands";

  return [wlcum, cmnd];
}
