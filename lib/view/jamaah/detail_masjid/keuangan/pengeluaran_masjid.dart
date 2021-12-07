import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_mosque/blocs/jamaah/keuangan_masjid/pengeluaran_masjid/pengeluaran_masjid_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/models/pengeluaran_model.dart';
import 'package:smart_mosque/view/components/error_component.dart';
import 'package:smart_mosque/view/components/loading_com.dart';
import 'package:smart_mosque/view/components/no_data.dart';

class PengeluaranMasjid extends StatefulWidget{
  final int? id;
  const PengeluaranMasjid({Key? key, required this.id}) : super (key: key);

  @override
  _PengeluaranMasjidState createState() => _PengeluaranMasjidState();
}

class _PengeluaranMasjidState extends State<PengeluaranMasjid>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<PengeluaranMasjidCubit>()..init(widget.id!),
      child: Scaffold(
        body: BlocBuilder<PengeluaranMasjidCubit, PengeluaranMasjidState>(
          builder: (context, state){
            if(state is PengeluaranMasjidFailure){
              return ErrorComponent(onPressed: (){
                context.read<PengeluaranMasjidCubit>().init(widget.id!);
              }, message: state.message,);
            }else if (state is PengeluaranMasjidLoaded){
              return PengeluaranMasjidBody(model: context.select((PengeluaranMasjidCubit cubit) => cubit.model), id: widget.id,);
            }
            return LoadingComp();
          },
        ),
      ),
    );
  }
}

class PengeluaranMasjidBody extends StatefulWidget{
  final int? id;
  final PengeluaranModel? model;
  const PengeluaranMasjidBody({Key? key, required this.id, required this.model}) : super (key: key);

  @override
  _PengeluaranMasjidBodyState createState() => _PengeluaranMasjidBodyState();
}

class _PengeluaranMasjidBodyState extends State<PengeluaranMasjidBody>{
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
            onRefresh: ()=> context.read<PengeluaranMasjidCubit>().init(widget.id!),
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