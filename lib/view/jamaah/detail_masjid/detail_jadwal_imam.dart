import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_mosque/blocs/jamaah/jadwal_masjid/detail/detail_jadwal_masjid_cubit.dart';
import 'package:smart_mosque/blocs/jamaah/jadwal_masjid/jadwal_masjid_cubit.dart';
import 'package:smart_mosque/blocs/masjid/jadwal-imam/detail/detail_imam_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/models/detail_jadwal_imam_model.dart';
import 'package:smart_mosque/view/components/error_component.dart';
import 'package:smart_mosque/view/components/loading_com.dart';
import 'package:smart_mosque/view/components/no_data.dart';

class DetailJadwalImam extends StatefulWidget{
  final int? id;
  final String? hari;
  const DetailJadwalImam({Key? key, required this.id, required this.hari}) : super (key: key);

  @override
  _DetailJadwalImamState createState() => _DetailJadwalImamState();
}

class _DetailJadwalImamState extends State<DetailJadwalImam>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<DetailJadwalMasjidCubit>()..init(widget.id!),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Detail Jadwal Imam > ${widget.hari}'),
        ),
        body: BlocBuilder<DetailJadwalMasjidCubit, DetailJadwalMasjidState>(
          builder: (context, state){
            if (state is DetailJadwalMasjidFailure){
              return ErrorComponent(onPressed: (){
                context.read<DetailJadwalMasjidCubit>().init(widget.id!);
              }, message: state.message,);
            }else if(state is DetailJadwalMasjidLoaded){
              return DetailJadwalImamBody(model: context.select((DetailJadwalMasjidCubit cubit) => cubit.model), id: widget.id,);
            }
            return LoadingComp();
          },
        ),
      ),
    );
  }
}

class DetailJadwalImamBody extends StatefulWidget{
  final int? id;
  final DetailJadwalImamModel? model;
  const DetailJadwalImamBody({Key? key, required this.model, this.id}) : super (key: key);

  @override
  _DetailJadwalImamBodyState createState() => _DetailJadwalImamBodyState();
}

class _DetailJadwalImamBodyState extends State<DetailJadwalImamBody>{
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
          onRefresh: ()=>context.read<DetailJadwalMasjidCubit>().init(widget.id!),
          child: (widget.model?.results?.isEmpty??true)?NoData(message: 'Data belum ada') : SingleChildScrollView(
            controller: _scrollController..addListener(() {

            }),
            child: Container(
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                  itemCount: widget.model?.results?.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Column(
                    children: [
                      ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.model?.results?[index].jadwal??''),
                            Text(widget.model?.results?[index].nama??''),
                          ],
                        ),
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundColor: bluePrimary,
                          child: Icon(Icons.timer, color: Colors.white,),
                        ),
                      ),
                      Divider()
                    ],
                  )
              ),
            ),
          ),
        ));
  }
}