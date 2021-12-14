import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:smart_mosque/blocs/masjid/kegiatan/kegiatan_cubit.dart';
import 'package:smart_mosque/blocs/masjid/pengurus/pengurus_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/config/router.gr.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/models/kegiatan_model.dart';
import 'package:smart_mosque/utils/preference_helper.dart';
import 'package:smart_mosque/utils/string_helper.dart';
import 'package:smart_mosque/utils/validate_helper.dart';
import 'package:smart_mosque/view/components/custom_button.dart';
import 'package:smart_mosque/view/components/custom_form.dart';
import 'package:smart_mosque/view/components/error_component.dart';
import 'package:smart_mosque/view/components/loading_com.dart';
import 'package:smart_mosque/view/components/no_data.dart';
import 'package:smart_mosque/view/masjid/kegiatan/batal.dart';
import 'package:smart_mosque/view/masjid/kegiatan/proses.dart';
import 'package:smart_mosque/view/masjid/kegiatan/selesai.dart';

class Kegiatan extends StatefulWidget{
  const Kegiatan({Key? key}) : super (key: key);
  
  @override
  _KegiatanState createState() => _KegiatanState();
}

class _KegiatanState extends State<Kegiatan> with SingleTickerProviderStateMixin{
  late TabController? _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Kegiatan'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              text: 'Belum Terlaksana',
            ),
            Tab(
              text: 'Selesai',
            ),
            Tab(
              text: 'Batal',
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Proses(),
          Selesai(),
          Batal()
        ],
      ),
    );
  }
}