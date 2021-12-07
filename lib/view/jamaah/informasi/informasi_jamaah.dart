import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_mosque/blocs/jamaah/informasi_jamaah/informasi_jamaah_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/models/informasi_jamaah_model.dart';
import 'package:smart_mosque/utils/string_helper.dart';
import 'package:smart_mosque/view/components/error_component.dart';
import 'package:smart_mosque/view/components/loading_com.dart';
import 'package:smart_mosque/view/components/no_data.dart';
import 'package:smart_mosque/view/jamaah/informasi/diikuti.dart';
import 'package:smart_mosque/view/jamaah/informasi/semua.dart';

class InformasiJamaah extends StatefulWidget{
  final TabController tab;
  const InformasiJamaah({Key? key, required this.tab}) :super (key: key);

  @override
  _InformasiJamaahState createState() => _InformasiJamaahState();
}

class _InformasiJamaahState extends State<InformasiJamaah> with SingleTickerProviderStateMixin{
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
          Diikuti(),
        ],
      ),
    );
  }
}