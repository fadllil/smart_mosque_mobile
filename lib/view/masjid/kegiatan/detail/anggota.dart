import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_mosque/blocs/masjid/kegiatan/anggota/kegiatan_anggota_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/config/router.gr.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/models/detail_anggota_model.dart';
import 'package:smart_mosque/view/components/error_component.dart';
import 'package:smart_mosque/view/components/loading_com.dart';
import 'package:smart_mosque/view/components/no_data.dart';

class Anggota extends StatefulWidget{
  final int id;
  const Anggota({Key? key, required this.id}) : super (key: key);

  @override
  _AnggotaState createState() => _AnggotaState();
}

class _AnggotaState extends State<Anggota>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<KegiatanAnggotaCubit>()..init(widget.id.toString()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Detail Anggota Kegiatan'),
        ),
        body: BlocConsumer<KegiatanAnggotaCubit, KegiatanAnggotaState>(
          listener: (context, state){
            if(state is KegiatanAnggotaUpdating){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is KegiatanAnggotaUpdated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil merubah data');
              AutoRouter.of(context).popAndPush(AnggotaRoute(id: widget.id));
            }else if (state is KegiatanAnggotaError){
              EasyLoading.dismiss();
              EasyLoading.showError(state.message);
            }
          },
          builder: (context, state){
            if(state is KegiatanAnggotaFailure){
              return ErrorComponent(onPressed: (){
                context.read<KegiatanAnggotaCubit>().init(widget.id.toString());
              }, message: state.message,);
            }else if(state is KegiatanAnggotaLoading){
              return LoadingComp();
            }
            return AnggotaBody(model: context.select((KegiatanAnggotaCubit bloc) => bloc.model), id: widget.id,);
          },
        ),
      ),
    );
  }
}

class AnggotaBody extends StatefulWidget{
  final int id;
  final DetailAnggotaModel? model;
  const AnggotaBody({Key? key, required this.id, required this.model}) : super (key: key);

  @override
  _AnggotaBodyState createState() => _AnggotaBodyState();
}

class _AnggotaBodyState extends State<AnggotaBody>{
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
        onRefresh: ()=>context.read<KegiatanAnggotaCubit>().init(widget.id.toString()),
        child: (widget.model?.results?.detailAnggota?.isEmpty??true)?NoData(message: 'Data belum ada') : SingleChildScrollView(
          controller: _scrollController..addListener(() {

          }),
          child: Container(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
                itemCount: widget.model?.results?.detailAnggota?.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index){
                  return Column(
                    children: [
                      InkWell(
                        onTap: (){

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
                                        Text(widget.model?.results?.detailAnggota?[index]
                                            .user?.nama ?? '',
                                          style: TextStyle(fontSize: 18),),
                                        Divider(),
                                        Text(widget.model?.results?.detailAnggota?[index].keterangan ?? ''),
                                      ]
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
        ),
      ),
    );
  }
}