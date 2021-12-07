import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_mosque/blocs/jamaah/informasi_masjid/informasi_masjid_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/models/informasi_model.dart';
import 'package:smart_mosque/utils/string_helper.dart';
import 'package:smart_mosque/view/components/error_component.dart';
import 'package:smart_mosque/view/components/loading_com.dart';
import 'package:smart_mosque/view/components/no_data.dart';

class InformasiMasjid extends StatefulWidget{
  final int? id;
  final TabController tab;
  const InformasiMasjid({Key? key, required this.id, required this.tab}) : super (key: key);

  @override
  _InformasiMasjidState createState() => _InformasiMasjidState();
}

class _InformasiMasjidState extends State<InformasiMasjid>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<InformasiMasjidCubit>()..init(widget.id!),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Informasi'),
          elevation: 0,
        ),
        body: BlocBuilder<InformasiMasjidCubit, InformasiMasjidState>(
          builder: (context, state){
            if(state is InformasiMasjidFailure){
              return ErrorComponent(onPressed: (){
                context.read<InformasiMasjidCubit>().init(widget.id!);
              }, message: state.message,);
            }else if(state is InformasiMasjidLoading){
              return LoadingComp();
            }
            return InformasiMasjidBody(model: context.select((InformasiMasjidCubit bloc) => bloc.model), id: widget.id,);
          },
        ),
      ),
    );
  }
}

class InformasiMasjidBody extends StatefulWidget{
  final int? id;
  final InformasiModel? model;
  const InformasiMasjidBody({Key? key, required this.id, required this.model}) : super (key: key);

  @override
  _InformasiMasjidBodyState createState() => _InformasiMasjidBodyState();
}

class _InformasiMasjidBodyState extends State<InformasiMasjidBody>{
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
          onRefresh: ()=>context.read<InformasiMasjidCubit>().init(widget.id),
          child: (widget.model?.results?.isEmpty??true)?NoData(message: 'Data belum ada') : SingleChildScrollView(
            controller: _scrollController..addListener(() {
            }),
            child: Container(
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                  itemCount: widget.model?.results?.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    DateTime? tgl = widget.model?.results?[index].tanggal;
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {

                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: kPrimaryColor,
                                      child: Icon(
                                        Icons.perm_device_information,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Expanded(
                                    flex: 8,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(widget.model?.results ? [index]
                                                .judul ?? '',
                                              style: TextStyle(fontSize: 18),),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('${convertDateTime(tgl!)}'),
                                                Text(widget.model?.results?[index].waktu ?? ''),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                        Text(widget.model?.results?[index].isi ?? ''),
                                        Divider(),
                                        Text(widget.model?.results?[index].keterangan ?? ''),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }
              ),
            ),
          )
      ),
    );
  }
}