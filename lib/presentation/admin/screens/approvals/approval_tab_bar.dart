import 'package:flutter/material.dart';
import 'package:salesafari/core/colors/Colors.dart';
import 'package:salesafari/core/colors/importedTheme.dart';
import 'package:salesafari/presentation/admin/screens/approvals/seller_approval.dart';
import 'package:salesafari/presentation/admin/screens/approvals/seller_edit_approval.dart';

class ApprovalTabBar extends StatefulWidget {
  const ApprovalTabBar({super.key});

  @override
  State<ApprovalTabBar> createState() => _ApprovalTabBarState();
}

class _ApprovalTabBarState extends State<ApprovalTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            title: Text(
              'Admin Dashboard',
              style: titleTextStyle,
            ),
            actions: [
              IconButton(
                iconSize: 35,
                onPressed: () {
                  Navigator.pushNamed(context, 'adminprofile');
                },
                icon: const Icon(
                  Icons.admin_panel_settings_rounded,
                ),
              ),
            ],
            // ignore: prefer_const_constructors
            bottom:TabBar(tabs: 
             [
              Tab(child: Text('Seller Approvals',style: facilityTextStyle,),),
              Tab(child: Text('Changes Approvals',style: facilityTextStyle,),),
            ]
            ),
          ),
          body:const TabBarView(
            children: [
              SellerApprovalPage(),
              SellerEditsPage()
            ]
            ),
      ),
    );
  }
}