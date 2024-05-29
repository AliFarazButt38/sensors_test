class CustomComment {
  final String avatar;
  final String userName;
  final String content;
  List<CustomComment> replies;

  CustomComment({
    required this.avatar,
    required this.userName,
    required this.content,
    List<CustomComment>? replies,
  }) : replies = replies ?? [];
}
