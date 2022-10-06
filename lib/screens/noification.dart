

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyNotification extends StatefulWidget {
  const MyNotification({super.key});

  @override
  State<MyNotification> createState() => _MyNotificationState();
}

class _MyNotificationState extends State<MyNotification> {
  @override
  Widget build(BuildContext context) {
    return Center
    (
      child: Text("notification"),
    );
  }
}