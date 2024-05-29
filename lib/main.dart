import 'package:flutter/material.dart';
import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';

import 'model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  List<CustomComment> mainComments = [
    // CustomComment(
    //   avatar: 'null',
    //   userName: 'null',
    //   content: 'Main Comment',
    //   replies: [
    //     CustomComment(avatar: 'null', userName: 'null', content: 'Reply 1'),
    //     CustomComment(avatar: 'null', userName: 'null', content: 'Reply 2'),
    //   ],
    // ),
    // CustomComment(avatar: 'null', userName: 'null', content: 'Another Main Comment'),
  ];

  void _addMainComment(String content) {
    setState(() {
      mainComments.add(CustomComment(avatar: 'null', userName: 'User', content: content));
    });
  }

  void _addReply(int mainCommentIndex, String content) {
    setState(() {
      mainComments[mainCommentIndex].replies.add(CustomComment(avatar: 'null', userName: 'User', content: content));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: mainComments.length,
              itemBuilder: (context, index) {
                final mainComment = mainComments[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: CommentTreeWidget<CustomComment, CustomComment>(
                    mainComment,
                    mainComment.replies,
                    treeThemeData: TreeThemeData(lineColor: Colors.blue[500]!, lineWidth: 3),
                    avatarRoot: (context, data) => PreferredSize(
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey,
                        backgroundImage: AssetImage('assets/avatar_2.png'),
                      ),
                      preferredSize: Size.fromRadius(18),
                    ),
                    avatarChild: (context, data) => PreferredSize(
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.grey,
                        backgroundImage: AssetImage('assets/avatar_1.png'),
                      ),
                      preferredSize: Size.fromRadius(12),
                    ),
                    contentChild: (context, data) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'dangngocduc',
                                  style: Theme.of(context).textTheme.caption?.copyWith(
                                      fontWeight: FontWeight.w600, color: Colors.black),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  '${data.content}',
                                  style: Theme.of(context).textTheme.caption?.copyWith(
                                      fontWeight: FontWeight.w300, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          // DefaultTextStyle(
                          //   style: Theme.of(context).textTheme.caption!.copyWith(
                          //       color: Colors.grey[700], fontWeight: FontWeight.bold),
                          //   child: Padding(
                          //     padding: EdgeInsets.only(top: 4),
                          //     child: Row(
                          //       children: [
                          //         SizedBox(
                          //           width: 8,
                          //         ),
                          //         Text('Like'),
                          //         SizedBox(
                          //           width: 24,
                          //         ),
                          //         GestureDetector(
                          //           onTap: () {
                          //             // Show a text field to add a reply
                          //             showDialog(
                          //               context: context,
                          //               builder: (context) {
                          //                 final replyController = TextEditingController();
                          //                 return AlertDialog(
                          //                   title: Text('Add a Reply'),
                          //                   content: TextField(
                          //                     controller: replyController,
                          //                     decoration: InputDecoration(
                          //                       hintText: 'Reply...',
                          //                     ),
                          //                   ),
                          //                   actions: [
                          //                     TextButton(
                          //                       onPressed: () {
                          //                         if (replyController.text.isNotEmpty) {
                          //                           _addReply(index, replyController.text);
                          //                         }
                          //                         Navigator.of(context).pop();
                          //                       },
                          //                       child: Text('Post'),
                          //                     ),
                          //                   ],
                          //                 );
                          //               },
                          //             );
                          //           },
                          //           child: Text('Reply'),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      );
                    },
                    contentRoot: (context, data) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'user',
                                  style: Theme.of(context).textTheme.caption!.copyWith(
                                      fontWeight: FontWeight.w600, color: Colors.black),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  '${data.content}',
                                  style: Theme.of(context).textTheme.caption!.copyWith(
                                      fontWeight: FontWeight.w300, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          DefaultTextStyle(
                            style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors.grey[700], fontWeight: FontWeight.bold),
                            child: Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text('Like'),
                                  SizedBox(
                                    width: 24,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // Show a text field to add a reply
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          final replyController = TextEditingController();
                                          return AlertDialog(
                                            title: Text('Add a Reply'),
                                            content: TextField(
                                              controller: replyController,
                                              decoration: InputDecoration(
                                                hintText: 'Reply...',
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  if (replyController.text.isNotEmpty) {
                                                    _addReply(index, replyController.text);
                                                  }
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Post'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Text('Reply'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Add a main comment...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _addMainComment(_controller.text);
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

