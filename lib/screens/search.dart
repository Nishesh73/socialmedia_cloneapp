import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class MySearch extends StatefulWidget {
  const MySearch({super.key});

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        child: Container(height: 500.0, child: buildFloatingSearchBar()),
      ),
    ));
  }

  Widget buildFloatingSearchBar() {
    String? searchquery;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        searchquery = query;
        // Call your model, bloc, controller here.on changed jastai ho yo
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
              color: Colors.white,
              elevation: 4.0,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .where("name", isEqualTo: searchquery)
                    .snapshots(),
                builder: (context, snapshot) {
                  return Container(
                    height: 30.0,
                    child: ListView(
                      children: snapshot.data!.docs.map((result) {
                        return Container(
                          height: 20.0,
                          child: Column(
                            children: [
                              Text(result["name"].toString()),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              )),
        );
      },
    );
  }
}
