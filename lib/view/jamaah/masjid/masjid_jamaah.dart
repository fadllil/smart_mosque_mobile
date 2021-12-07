import 'package:flutter/material.dart';
import 'package:smart_mosque/view/jamaah/masjid/diikuti.dart';
import 'package:smart_mosque/view/jamaah/masjid/semua.dart';

class MasjidJamaah extends StatefulWidget{
  final TabController tab;
  const MasjidJamaah({Key? key, required this.tab}) : super (key: key);

  @override
  _MasjidJamaahState createState() => _MasjidJamaahState();
}

class _MasjidJamaahState extends State<MasjidJamaah> with SingleTickerProviderStateMixin{
  late TabController? _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Smart Mosque'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              text: 'Semua',
            ),
            Tab(
              text: 'Diikuti',
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Semua(),
          Diikuti()
        ],
      ),
    );
  }
}