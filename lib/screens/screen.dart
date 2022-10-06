
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MySearch extends StatefulWidget {
  const MySearch({super.key});

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Text("search kar yar"),
    );
  }
}