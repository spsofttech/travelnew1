import 'package:flutter/material.dart';

import 'package:travelnew_app/utils/constant.dart';
import 'package:travelnew_app/views/home/inbox_screen.dart';
import 'package:travelnew_app/views/humburger_flow/my_account/my_trip_friends.dart';
import 'package:travelnew_app/views/humburger_flow/prima_profile/prima_profile_screen.dart';
import 'package:travelnew_app/views/humburger_flow/upcoming_trips.dart';
import 'package:travelnew_app/views/publish%20your%20trip/publish_your_trip.dart';
import 'package:travelnew_app/widget/custom_tab_indicator.dart';

import '../views/home/home_screen.dart';
import 'my_bottom_navbar.dart';
import 'my_drawer.dart';

class PrimaMyBottomBar extends StatefulWidget {
  const PrimaMyBottomBar({Key? key}) : super(key: key);

  @override
  State<PrimaMyBottomBar> createState() => _PrimaMyBottomBarState();
}

class _PrimaMyBottomBarState extends State<PrimaMyBottomBar> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  final PageStorageBucket bucket = PageStorageBucket();
  TabController? tabController;
  final List<Widget> mainScreens = [
    PrimaProfileScreen(),
    MyTripFriendsScreen(title: 'Friends in vicinity'),
    PublishYourTripScreen(),
    const InboxScreen(),
    Text('')
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      drawer: MyDrawer(),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: TabBarView(
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: mainScreens,
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: BottomAppBar(
          // notchMargin: 8,
          child: TabBar(
              tabs: [
                const Tab(
                  icon: ImageIcon(
                    AssetImage(
                      'assets/images/navbar3.png',
                    ),
                  ),
                ),
                const Tab(icon: Icon(Icons.person_search_sharp)
                    // ImageIcon(
                    //   // AssetImage(
                    //   //   'assets/images/navbar5.png',
                    //   ),
                    ),
                const Tab(
                  icon: ImageIcon(
                    AssetImage(
                      'assets/images/navbar2.png',
                    ),
                  ),
                ),
                const Tab(
                  icon: ImageIcon(
                    AssetImage(
                      'assets/images/navbar4.png',
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) => const MyBottomBar()));
                  },
                  child: const Tab(
                    icon: SizedBox(
                      height: 50,
                      width: 50,
                      child: ImageIcon(
                        AssetImage(
                          'assets/images/navbar1.png',
                        ),
                      ),
                    ),
                  ),
                )
              ],
              labelPadding: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              labelColor: primary,
              unselectedLabelColor: Colors.grey.shade400,
              isScrollable: false,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: const EdgeInsets.all(0.0),
              indicatorColor: primary,
              controller: tabController,
              indicator: const CustomTabIndicator()),
        ),
      ),
    );
  }
}
