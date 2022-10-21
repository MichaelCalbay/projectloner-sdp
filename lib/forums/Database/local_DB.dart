import 'package:shared_preferences/shared_preferences.dart';

class LocalDB {
  static Future<List<String>> saveLikeList(
      String postID, List<String>? myLikeList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? newLikeList = myLikeList;
    if (myLikeList == null) {
      newLikeList = <String>[];
      newLikeList.add(postID);
    } else {
      myLikeList.add(postID);
    }
    prefs.setStringList('likeList', newLikeList!);

    return newLikeList;
  }
}
