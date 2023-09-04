import 'package:child_finder/model/childrensearch.dart';
import 'package:child_finder/model/matchedchildren.dart';
import 'package:child_finder/themes/lighttheme.dart';
import 'package:child_finder/widget/childInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MatchedChild extends StatefulWidget {
  const MatchedChild({super.key});

  @override
  State<MatchedChild> createState() => _MatchedChildState();
}

class _MatchedChildState extends State<MatchedChild> {
  final List<MatchedChildren> matchedChildrenList = [];

  Stream<List<MatchedChildren>> readComplaints() => FirebaseFirestore.instance
      .collection('lostChild')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => MatchedChildren.fromJson(doc.data()))
          .toList());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() { 
        });
        readComplaints();
      },
      child: Scaffold(
        backgroundColor: lighttheme.colorScheme.background,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("List of all children lost"),
          backgroundColor: lighttheme.appBarTheme.backgroundColor,
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         showSearch(
          //             context: context,
          //             delegate:
          //                 ChildrenSearchDelegate(lostchilds: matchedChildrenList));
          //       },
          //       icon: const Icon(Icons.search))
          // ],
        ),
        body: StreamBuilder(
            stream: readComplaints(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final matchedChildrenList = snapshot.data;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 1,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 30,
                      ),
                      itemCount: matchedChildrenList!.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                                context: ctx,
                                builder: (ctx) => buildPopupDialog(
                                    ctx, index, matchedChildrenList));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: lighttheme.colorScheme.secondary,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                matchedChildrenList[index].image,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: lighttheme.dialogBackgroundColor,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      }),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}