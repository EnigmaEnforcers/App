import 'package:child_finder/themes/lighttheme.dart';
import 'package:flutter/material.dart';

class AllChildren extends StatefulWidget {
  const AllChildren({super.key});

  @override
  State<AllChildren> createState() => _AllChildrenState();
}

class _AllChildrenState extends State<AllChildren> {
  final List<Map> myProducts =
      List.generate(20, (index) => {"id": index, "name": "Product $index"})
          .toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lighttheme.colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("List of all children lost"),
        backgroundColor: lighttheme.appBarTheme.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: myProducts.length,
            itemBuilder: (BuildContext ctx, index) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: lighttheme.colorScheme.secondary,
                    borderRadius: BorderRadius.circular(15)),
                child: Text(
                  myProducts[index]["name"],
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }),
      ),
    );
  }
}
