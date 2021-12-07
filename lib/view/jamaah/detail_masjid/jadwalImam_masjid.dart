import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_mosque/blocs/jamaah/informasi_masjid/informasi_masjid_cubit.dart';
import 'package:smart_mosque/blocs/jamaah/jadwal_masjid/jadwal_masjid_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/config/router.gr.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/models/jadwal_imam_model.dart';
import 'package:smart_mosque/view/components/error_component.dart';
import 'package:smart_mosque/view/components/loading_com.dart';
import 'package:smart_mosque/view/components/no_data.dart';

class JadwalImamMasjid extends StatefulWidget{
  final int? id;
  final TabController tab;
  const JadwalImamMasjid({Key? key, required this.id, required this.tab}) : super (key: key);

  @override
  _JadwalImamMasjidState createState() => _JadwalImamMasjidState();
}

class _JadwalImamMasjidState extends State<JadwalImamMasjid>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<JadwalMasjidCubit>()..init(widget.id!),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Informasi'),
          elevation: 0,
        ),
        body: BlocBuilder<JadwalMasjidCubit, JadwalMasjidState>(
          builder: (context, state){
            if(state is JadwalMasjidFailure){
              return ErrorComponent(onPressed: (){
                context.read<JadwalMasjidCubit>().init(widget.id!);
              }, message: state.message,);
            }else if(state is JadwalMasjidLoading){
              return LoadingComp();
            }
            return JadwalImamMasjidBody(model: context.select((JadwalMasjidCubit bloc) => bloc.model), id: widget.id,);
          },
        ),
      ),
    );
  }
}

class JadwalImamMasjidBody extends StatefulWidget{
  final int? id;
  final JadwalImamModel? model;
  const JadwalImamMasjidBody({Key? key, required this.id, required this.model}) : super (key: key);

  @override
  _JadwalImamMasjidBodyState createState() => _JadwalImamMasjidBodyState();
}

class _JadwalImamMasjidBodyState extends State<JadwalImamMasjidBody>{
  ScrollController _scrollController = ScrollController();
  GlobalKey<RefreshIndicatorState> _refresh = GlobalKey();
  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refresh,
        onRefresh: ()=>context.read<JadwalMasjidCubit>().init(widget.id!),
        child: (widget.model?.results?.isEmpty??true)?NoData(message: 'Data belum ada') : SingleChildScrollView(
          controller: _scrollController..addListener(() {

          }),
          child: Container(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: widget.model?.results?.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index)=>Column(
                children: [
                  ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.model?.results?[index].hari??''),
                      ],
                    ),
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: bluePrimary,
                      child: Icon(Icons.calendar_today, color: Colors.white,),
                    ),
                    onTap: (){
                      int? id = widget.model?.results?[index].id;
                      AutoRouter.of(context).push(DetailJadwalImamRoute(id: id, hari: widget.model?.results?[index].hari));
                    },
                  ),
                  Divider()
                ],
              ) ,
            ),
          ),
        ),
      ),
    );
  }
}