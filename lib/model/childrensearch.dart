import 'package:child_finder/model/lostChildern.dart';
import 'package:child_finder/widget/childInfo.dart';
import 'package:flutter/material.dart';

class ChildrenSearchDelegate extends SearchDelegate {
  List<LostChildren> lostchilds;
  ChildrenSearchDelegate({required this.lostchilds});
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<LostChildren> matchQuery = [];
    for (var n in lostchilds) {
      if (n.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(n);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          // leading: ,
          // sub
          title: Text(result.name),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<LostChildren> matchQuery = [];
    for (var n in lostchilds) {
      if (n.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(n);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return InkWell(
          onTap: () async {
            FocusManager.instance.primaryFocus?.unfocus();
            await Future.delayed(
              const Duration(milliseconds: 150),
            );
            if (context.mounted) {
              showDialog(
                context: context,
                builder: (context) => buildPopupDialog(
                  context,
                  index,
                  matchQuery,
                ),
              );
            }
          },
          child: ListTile(
            title: Text(result.name),
          ),
        );
      },
    );
  }
}
