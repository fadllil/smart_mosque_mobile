import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_mosque/blocs/jamaah/keuangan_masjid/pemasukan_masjid/pemasukan_masjid_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/models/pemasukan_model.dart';
import 'package:smart_mosque/view/components/error_component.dart';
import 'package:smart_mosque/view/components/loading_com.dart';
import 'package:smart_mosque/view/components/no_data.dart';

class PemasukanMasjid extends StatefulWidget{
  final int? id;
  const PemasukanMasjid({Key? key, required this.id}) : super (key: key);

  @override
  _PemasukanMasjidState createState() => _PemasukanMasjidState();
}

class _PemasukanMasjidState extends State<PemasukanMasjid>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<PemasukanMasjidCubit>()..init(widget.id!),
      child: Scaffold(
        body: BlocBuilder<PemasukanMasjidCubit, PemasukanMasjidState>(
          builder: (context, state){
            if(state is PemasukanMasjidFailure){
              return ErrorComponent(onPressed: (){
                context.read<PemasukanMasjidCubit>().init(widget.id!);
              }, message: state.message,);
            }else if (state is PemasukanMasjidLoaded){
              return PemasukanMasjidBody(model: context.select((PemasukanMasjidCubit cubit) => cubit.model), id: widget.id,);
            }
            return LoadingComp();
          },
        ),
      ),
    );
  }
}

class PemasukanMasjidBody extends StatefulWidget{
  final int? id;
  final PemasukanModel? model;
  const PemasukanMasjidBody({Key? key, required this.id, required this.model}) : super (key: key);

  @override
  _PemasukanMasjidBodyState createState() => _PemasukanMasjidBodyState();
}

class _PemasukanMasjidBodyState extends State<PemasukanMasjidBody>{
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
            onRefresh: ()=> context.read<PemasukanMasjidCubit>().init(widget.id!),
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
                    DateTime? now = widget.model?.results?[index].createdAt;
                    String? _tanggal = DateFormat('dd-MM-yyyy').format(now!);
                    return Column(
                      children: [
                        ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.model?.results?[index].nama??''),
                              Divider(color: Colors.black,),
                              Text(widget.model?.results?[index].nominal.toString()??'', style: TextStyle(fontSize: 14),),
                              Text(widget.model?.results?[index].keterangan??'', style: TextStyle(fontSize: 14),),
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
            )
        )
    );
  }
}