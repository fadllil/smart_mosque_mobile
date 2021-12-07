import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_mosque/blocs/jamaah/kegiatan_masjid/kegiatan_masjid_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/models/kegiatan_model.dart';
import 'package:smart_mosque/view/components/error_component.dart';
import 'package:smart_mosque/view/components/loading_com.dart';
import 'package:smart_mosque/view/components/no_data.dart';

class KegiatanMasjid extends StatefulWidget{
  final int? id;
  final TabController tab;
  const KegiatanMasjid({Key? key, required this.id, required this.tab}) : super (key: key);

  @override
  _KegiatanMasjidState createState() => _KegiatanMasjidState();
}

class _KegiatanMasjidState extends State<KegiatanMasjid>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<KegiatanMasjidCubit>()..init(widget.id!),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Informasi'),
          elevation: 0,
        ),
        body: BlocBuilder<KegiatanMasjidCubit, KegiatanMasjidState>(
          builder: (context, state){
            if(state is KegiatanMasjidFailure){
              return ErrorComponent(onPressed: (){
                context.read<KegiatanMasjidCubit>().init(widget.id!);
              }, message: state.message,);
            }else if(state is KegiatanMasjidLoading){
              return LoadingComp();
            }
            return KegiatanMasjidBody(model: context.select((KegiatanMasjidCubit bloc) => bloc.model), id: widget.id,);
          },
        ),
      ),
    );
  }
}

class KegiatanMasjidBody extends StatefulWidget{
  final int? id;
  final KegiatanModel? model;
  const KegiatanMasjidBody({Key? key, required this.id, required this.model}) : super (key: key);

  @override
  _KegiatanMasjidBodyState createState() => _KegiatanMasjidBodyState();
}

class _KegiatanMasjidBodyState extends State<KegiatanMasjidBody>{
  ScrollController _scrollController = ScrollController();
  GlobalKey<RefreshIndicatorState> _refresh = GlobalKey();
  DateTime now = DateTime.now();
  DateFormat formattedDate = DateFormat('yyyy-MM-dd');
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
          onRefresh: ()=>context.read<KegiatanMasjidCubit>().init(widget.id!),
          child: (widget.model?.results?.isEmpty??true)?NoData(message: 'Data belum ada') : SingleChildScrollView(
            controller: _scrollController..addListener(() {

            }),
            child: Container(
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: widget.model?.results?.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index){
                  DateTime? now = widget.model?.results?[index].tanggal;
                  String? _tanggal = DateFormat('dd-MM-yyyy').format(now!);
                  return Column(
                    children: [
                      ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.model?.results?[index].nama??''),
                            Divider(color: Colors.black,),
                            Text(widget.model?.results?[index].jenis??'', style: TextStyle(fontSize: 14),),
                            Text(widget.model?.results?[index].waktu??'', style: TextStyle(fontSize: 14),),
                            Text(_tanggal, style: TextStyle(fontSize: 14),),
                          ],
                        ),
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundColor: bluePrimary,
                          child: Icon(Icons.date_range, color: Colors.white,),
                        ),
                      ),
                      Divider(),
                    ],
                  );},
              ),
            ),
          ),
        ));
  }
}