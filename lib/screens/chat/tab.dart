import 'package:chatty/screens/chat/home.dart';
import 'package:chatty/screens/auth/profile.dart';
import 'package:chatty/screens/chat/users.dart';
import 'package:flutter/material.dart';

import '../../utils/custom_colors.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    const HomeScreen(),
    const UserScreen(),
    const ProfileScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        backgroundColor: CustomColors.backgroundColor,
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
              backgroundColor: CustomColors.backgroundColor,
              icon: Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: CustomColors.backgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: CustomColors.foregroundColor,
                            offset: const Offset(
                              7,
                              7,
                            ),
                            blurRadius: 10,
                            spreadRadius: 1),
                        const BoxShadow(
                            color: CustomColors.whiteColor,
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(
                              -7,
                              -7,
                            ))
                      ]),
                  child: const Icon(Icons.chat_bubble_outline)),
              label: ''),
          BottomNavigationBarItem(
              backgroundColor: CustomColors.backgroundColor,
              icon: Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: CustomColors.backgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: CustomColors.foregroundColor,
                            offset: const Offset(
                              7,
                              7,
                            ),
                            blurRadius: 10,
                            spreadRadius: 1),
                        const BoxShadow(
                            color: CustomColors.whiteColor,
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(
                              -7,
                              -7,
                            ))
                      ]),
                  child: const Icon(Icons.contacts_outlined)),
              label: ''),
          BottomNavigationBarItem(
              backgroundColor: CustomColors.backgroundColor,
              icon: Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: CustomColors.backgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: CustomColors.foregroundColor,
                            offset: const Offset(
                              7,
                              7,
                            ),
                            blurRadius: 10,
                            spreadRadius: 1),
                        const BoxShadow(
                            color: CustomColors.whiteColor,
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(
                              -7,
                              -7,
                            ))
                      ]),
                  child: const Icon(Icons.person_outline)),
              label: ''),
        ],
      ),
    );
  }
}
