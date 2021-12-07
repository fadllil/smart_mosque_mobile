import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_mosque/blocs/jamaah/keuangan_masjid/pemasukan_masjid/pemasukan_masjid_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/view/components/error_component.dart';
import 'package:smart_mosque/view/components/loading_com.dart';
import 'package:smart_mosque/view/jamaah/detail_masjid/keuangan/pemasukan_masjid.dart';
import 'package:smart_mosque/view/jamaah/detail_masjid/keuangan/pengeluaran_masjid.dart';

class KeuanganMasjid extends StatefulWidget{
  final int? id;
  final TabController tab;
  const KeuanganMasjid({Key? key, required this.id, required this.tab}) : super (key: key);

  @override
  _KeuanganMasjidState createState() => _KeuanganMasjidState();
}

class _KeuanganMasjidState extends State<KeuanganMasjid> with SingleTickerProviderStateMixin{
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
          PemasukanMasjid(id: widget.id,),
          PengeluaranMasjid(id: widget.id,)
        ],
      ),
    );
  }
}