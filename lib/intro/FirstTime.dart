import 'package:shared_preferences/shared_preferences.dart';

class FirstTime{
Future < int > getOnce() async {
    int ? intValue;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String

    if (prefs.getInt("initScreen") == null) {
      intValue = 0;
    } else {
      intValue = prefs.getInt("initScreen");
    }

    return intValue!;
  }

  Future once(int num) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //initScreen
    await prefs.setInt("initScreen", num);

    int initScreen = (prefs.getInt("initScreen")) !;
    print('initScreen ${initScreen}');
    // return initScreen;
  }
}