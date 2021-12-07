import 'package:flutter/material.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/view/jamaah/detail_masjid/detail_masjid.dart';
import 'package:smart_mosque/view/jamaah/detail_masjid/informasi_masjid.dart';
import 'package:smart_mosque/view/jamaah/detail_masjid/inventaris_masjid.dart';
import 'package:smart_mosque/view/jamaah/detail_masjid/jadwalImam_masjid.dart';
import 'package:smart_mosque/view/jamaah/detail_masjid/kegiatan_masjid.dart';
import 'package:smart_mosque/view/jamaah/detail_masjid/keuangan/keuangan_masjid.dart';

class HomeDetailMasjid extends StatefulWidget{
  final int? id;
  final int? index;
  const HomeDetailMasjid({Key? key, required this.id, this.index = 0}) : super (key: key);

  @override
  _HomeDetailMasjidState createState() => _HomeDetailMasjidState();
}

class _HomeDetailMasjidState extends State<HomeDetailMasjid> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this, initialIndex: widget.index??0);
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Informasi'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Jadwal Imam'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Kegiatan'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Inventaris'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Keuangan'),
        ],
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          DetailMasjid(id: widget.id, tab: _tabController),
          InformasiMasjid(id: widget.id, tab: _tabController),
          JadwalImamMasjid(id: widget.id, tab: _tabController),
          KegiatanMasjid(id: widget.id, tab: _tabController),
          InventarisMasjid(id: widget.id, tab: _tabController),
          KeuanganMasjid(id: widget.id, tab: _tabController)
        ],
      ),
    );
  }
}