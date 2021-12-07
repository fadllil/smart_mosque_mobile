import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_mosque/view/masjid/keuangan/pemasukan.dart';
import 'package:smart_mosque/view/masjid/keuangan/pengeluaran.dart';

class KeuanganIndex extends StatefulWidget{
  const KeuanganIndex({Key? key}) : super (key: key);

  @override
  _KeuanganIndexState createState() => _KeuanganIndexState();
}

class _KeuanganIndexState extends State<KeuanganIndex> with SingleTickerProviderStateMixin{
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
        title: Text('Keuangan'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              text: 'Pemasukan',
            ),
            Tab(
              text: 'Pengeluaran',
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Pemasukan(),
          Pengeluaran()
        ],
      ),
    );
  }
}