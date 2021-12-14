import 'package:flutter/material.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/view/masjid/dashboard_masjid.dart';
import 'package:smart_mosque/view/masjid/profil.dart';

class HomeMasjid extends StatefulWidget{
  final int? index;
  const HomeMasjid({Key? key, this.index = 0}) : super (key: key);
  
  @override
  _HomeMasjidState createState() => _HomeMasjidState();
}

class _HomeMasjidState extends State<HomeMasjid> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.index??0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kPrimaryColor,
        onTap: (index){
          _tabController.index = index;
          setState(() {

          });
        },
        currentIndex: _tabController.index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'User'),
        ],
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          DashboardMasjid(tab: _tabController,),
          Profil(tab: _tabController),
        ],
      ),
    );
  }
}