import 'package:child_finder/model/matchedchildren.dart';
import 'package:child_finder/widget/matchedinfo.dart';
import 'package:flutter/material.dart';

class MatchedChildrenSearchDelegate extends SearchDelegate {
  List<MatchedChildren> matchedChild;
  MatchedChildrenSearchDelegate({required this.matchedChild});
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<MatchedChildren> matchQuery = [];
    for (var n in matchedChild) {
      if (n.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(n);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result.name),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<MatchedChildren> matchQuery = [];
    for (var n in matchedChild) {
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
            if (!context.mounted) {
              return;
            }
            showDialog(
                context: context,
                builder: (context) =>
                    buildMatchedPopupDialog(context, index, matchQuery));
          },
          child: ListTile(
            title: Text(result.name),
          ),
        );
      },
    );
  }
}
