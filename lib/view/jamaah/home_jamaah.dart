import 'package:flutter/material.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/view/jamaah/informasi/informasi_jamaah.dart';
import 'package:smart_mosque/view/jamaah/masjid/masjid_jamaah.dart';
import 'package:smart_mosque/view/jamaah/profil_jamaah.dart';

class HomeJamaah extends StatefulWidget{
  final int? index;
  const HomeJamaah({Key? key, this.index = 0}) : super (key: key);

  @override
  _HomeJamaahState createState() => _HomeJamaahState();
}

class _HomeJamaahState extends State<HomeJamaah> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: widget.index??0);
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
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Informasi'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Masjid'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Pesan'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'User'),
        ],
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [

          InformasiJamaah(tab: _tabController),
          MasjidJamaah(tab: _tabController,),
          Center(child: Text('Pesan'),),
          ProfilJamaah(tab: _tabController),
        ],
      ),
    );
  }
}