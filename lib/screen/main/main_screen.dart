import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/screen/main/dashboard_screen.dart';
import 'package:esdc_emg/screen/main/employee_screen.dart';
import 'package:esdc_emg/screen/main/message_screen.dart';
import 'package:esdc_emg/screen/main/social_media_screen.dart';
import 'package:esdc_emg/widget/tabbar/esdc_tabbar.dart';
import 'package:esdc_emg/widget/tabbar/main_tab_item.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {

  final int tabLength = 4;
  TabController tabController;
  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: tabLength,
      vsync: this,
    )..addListener(handleTabController);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  void handleTabController() {
    currentTabIndex = tabController.index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          body: AppMainTabBarView(
            controller: tabController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              DashboardScreen(),
              MessageScreen(),
              EmployeeScreen(),
              SocialMediaScreen()
            ],
          ),
          bottomNavigationBar: Container(
            height: 70,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 3,
                  blurRadius: 5,
                ),
              ],
            ),
            child: AppMainTabBar(
              indicatorColor: Colors.white,
              controller: tabController,
              activeBackgroundColor: Colors.white,
              inactiveBackgroundColor: Colors.white,
              indicatorWeight: 0.1,
              labelColor: Styles.purple,
              unselectedLabelColor: Styles.textBlack,
              tabs: [
                MainTabItem(title: 'MyESDC', image: 'asset/image/star.svg', selected: currentTabIndex == 0,),
                MainTabItem(title: 'Messages', image: 'asset/image/mail.svg', selected: currentTabIndex == 1,),
                MainTabItem(title: 'Employees', image: 'asset/image/user.svg', selected: currentTabIndex == 2,),
                MainTabItem(title: 'Social media', image: 'asset/image/sound.svg', selected: currentTabIndex == 3,),
              ],
            ),
          ),
        )
    );
  }
}
