import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instagram_clone_app/provides/appprovide.dart';
import 'package:instagram_clone_app/screens/feeds.dart';
import 'package:instagram_clone_app/screens/noification.dart';
import 'package:instagram_clone_app/screens/profile.dart';
import 'package:instagram_clone_app/screens/search.dart';
import 'package:provider/provider.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _currentindex = 0;
  PageController pageController = PageController();

  onPageChange(index) {
    setState(() {
      pageController.animateToPage(index,
          duration: Duration(microseconds: 10), curve: Curves.bounceOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.black,
          backgroundColor: Colors.white,
          currentIndex: _currentindex,
          onTap: (index) {
            setState(() {
              onPageChange(index);
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "search"),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: "notification"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box), label: "account"),
          ]),
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            _currentindex = index;
          });
        },
        children: [
          MyFeeds(),
          MySearch(),
          MyNotification(),
          MyProfile(
            name: appProvider.user,
          ),
        ],
      ),
    );
  }
}
