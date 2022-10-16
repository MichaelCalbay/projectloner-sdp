class ForumsPostData{

  late final String userName;
  late final String userThumbnail;
  late final int postTimeStamp;
  late final String postContent;
  late final String postImage;
  late final int postLikeCounter;
  late final int postCommentCounter;

  ForumsPostData(
      { required this.userName,
        required this.userThumbnail,
        required this.postTimeStamp,
        required this.postContent,
        required this.postImage,
        required this.postLikeCounter,
        required this.postCommentCounter
      });
}