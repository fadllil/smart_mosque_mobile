import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_mosque/blocs/jamaah/inventaris_masjid/inventaris_masjid_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/models/inventaris_model.dart';
import 'package:smart_mosque/view/components/error_component.dart';
import 'package:smart_mosque/view/components/loading_com.dart';
import 'package:smart_mosque/view/components/no_data.dart';

class InventarisMasjid extends StatefulWidget{
  final int? id;
  final TabController tab;
  const InventarisMasjid({Key? key, required this.id, required this.tab}) : super (key: key);

  @override
  _InventarisMasjidState createState() => _InventarisMasjidState();
}

class _InventarisMasjidState extends State<InventarisMasjid>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<InventarisMasjidCubit>()..init(widget.id!),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Informasi'),
          elevation: 0,
        ),
        body: BlocBuilder<InventarisMasjidCubit, InventarisMasjidState>(
          builder: (context, state){
            if(state is InventarisMasjidFailure){
              return ErrorComponent(onPressed: (){
                context.read<InventarisMasjidCubit>().init(widget.id!);
              }, message: state.message,);
            }else if(state is InventarisMasjidLoading){
              return LoadingComp();
            }
            return InventarisMasjidBody(model: context.select((InventarisMasjidCubit bloc) => bloc.model), id: widget.id,);
          },
        ),
      ),
    );
  }
}

class InventarisMasjidBody extends StatefulWidget{
  final int? id;
  final InventarisModel? model;
  const InventarisMasjidBody({Key? key, required this.id, required this.model}) : super (key: key);

  @override
  _InventarisMasjidBodyState createState() => _InventarisMasjidBodyState();
}

class _InventarisMasjidBodyState extends State<InventarisMasjidBody>{
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
          onRefresh: ()=>context.read<InventarisMasjidCubit>().init(widget.id!),
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
                  return Column(
                    children: [
                      ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.model?.results?[index].nama??''),
                            Divider(color: Colors.black,),
                            Text(widget.model?.results?[index].jumlah.toString()??'', style: TextStyle(fontSize: 14),),
                            Text(widget.model?.results?[index].keterangan??'', style: TextStyle(fontSize: 14),),
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