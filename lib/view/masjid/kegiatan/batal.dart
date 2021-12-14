import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_mosque/blocs/masjid/kegiatan/kegiatan_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/config/router.gr.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/models/kegiatan_model.dart';
import 'package:smart_mosque/utils/string_helper.dart';
import 'package:smart_mosque/view/components/custom_button.dart';
import 'package:smart_mosque/view/components/error_component.dart';
import 'package:smart_mosque/view/components/loading_com.dart';
import 'package:smart_mosque/view/components/no_data.dart';
import 'package:smart_mosque/view/masjid/kegiatan/proses.dart';

class Batal extends StatefulWidget{
  const Batal({Key? key}) : super (key: key);

  @override
  _BatalState createState() => _BatalState();
}

class _BatalState extends State<Batal>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<KegiatanCubit>()..batal(),
      child: Scaffold(
        body: BlocBuilder<KegiatanCubit, KegiatanState>(
          builder: (context, state){
            if(state is KegiatanFailure){
              return ErrorComponent(onPressed: (){
                context.read<KegiatanCubit>().batal();
              }, message: state.message,);
            }else if(state is KegiatanLoading){
              return LoadingComp();
            }
            return BatalBody(model: context.select((KegiatanCubit bloc) => bloc.model));
          },
        ),
      ),
    );
  }
}

class BatalBody extends StatefulWidget{
  final KegiatanModel? model;
  const BatalBody({Key? key, required this.model}) : super (key: key);

  @override
  _BatalBodyState createState() => _BatalBodyState();
}

class _BatalBodyState extends State<BatalBody>{
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
          onRefresh: ()=>context.read<KegiatanCubit>().batal(),
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
                                              .nama ?? '',
                                            style: TextStyle(fontSize: 18),),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('${widget.model?.results?[index].waktu}'),
                                              Text('${convertDateTime(now!)}'),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Text(widget.model?.results?[index].jenis ?? ''),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          IconButton(icon: Icon(Icons.edit, color: bluePrimary,), onPressed: (){
                                            showModalBottomSheet(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                                ),
                                                backgroundColor: Colors.white,
                                                isScrollControlled: true,
                                                context: context,
                                                builder: (context) {
                                                  return EditKegiatan(c:context, model: widget.model, index:index);
                                                }
                                            ).then((value){
                                              if (value != null){
                                                context.read<KegiatanCubit>().updateKegiatan(value);
                                              }
                                            });
                                          },
                                          ),
                                          IconButton(icon: Icon(Icons.delete, color: Colors.red,), onPressed: (){
                                            int? id = widget.model?.results?[index].id;
                                            showModalBottomSheet(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                                ),
                                                backgroundColor: Colors.white,
                                                isScrollControlled: true,
                                                context: context,
                                                builder: (c) => Container(
                                                  padding: EdgeInsets.all(20),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text('Apakah anda ingin menghapus data?', style: TextStyle(fontSize: 18),),
                                                      SizedBox(height: 20,),
                                                      CustomButton(
                                                          label: 'Hapus',
                                                          onPressed: (){
                                                            FocusScope.of(context).unfocus();
                                                            String? _id = id.toString();
                                                            context.read<KegiatanCubit>().deleteKegiatan(_id);
                                                            Navigator.pop(context);
                                                          },
                                                          color: kPrimaryColor)
                                                    ],
                                                  ),
                                                )
                                            );
                                          },),
                                          (widget.model?.results?[index].anggota?.isEmpty == false) ? IconButton(
                                              onPressed: (){
                                                int? id = widget.model?.results?[index].id;
                                                AutoRouter.of(context).push(AnggotaRoute(id: id!));
                                              },
                                              icon: Icon(Icons.people, color: bluePrimary,)
                                          ) : SizedBox(),
                                          (widget.model?.results?[index].iuran?.isEmpty == false) ? IconButton(
                                              onPressed: (){
                                                int? id = widget.model?.results?[index].id;
                                                AutoRouter.of(context).push(IuranRoute(id: id!));
                                              },
                                              icon: Icon(Icons.money, color: Colors.green,)
                                          ) : SizedBox(),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );},
              ),
            ),
          ),
        ));
  }
}