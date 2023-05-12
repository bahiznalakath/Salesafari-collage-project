import 'package:flutter/material.dart';
import 'package:salesafari/presentation/admin/screens/approvals/approval_tab_bar.dart';
import 'package:salesafari/presentation/admin/screens/feedbacks/feedback_home.dart';
import 'package:salesafari/presentation/admin/screens/view_users/view_tab_bar.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final pages = [
    const ApprovalTabBar(),
    const ViewTabBar(),
    // const FeedbackHome(),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pages[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.lightBlue ,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.verified_outlined, size: 25),
              label: 'Approvals',
              
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_pin_rounded, size: 25),
              label: 'View Users',
            ),
          ],
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
        ),
      ),
    );
  }
}
