import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_mosque/blocs/masjid/jadwal-imam/detail/detail_imam_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/config/router.gr.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/models/detail_jadwal_imam_model.dart';
import 'package:smart_mosque/utils/validate_helper.dart';
import 'package:smart_mosque/view/components/custom_button.dart';
import 'package:smart_mosque/view/components/custom_form.dart';
import 'package:smart_mosque/view/components/error_component.dart';
import 'package:smart_mosque/view/components/loading_com.dart';
import 'package:smart_mosque/view/components/no_data.dart';

class DetailImam extends StatefulWidget{
  final int? id;
  final String? hari;
  const DetailImam({Key? key, required this.id, required this.hari}) : super (key: key);
  
  @override
  _DetailImamState createState() => _DetailImamState();
}

class _DetailImamState extends State<DetailImam>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<DetailImamCubit>()..init(widget.id!),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Detail Jadwal Imam > ${widget.hari}'),
        ),
        body: BlocConsumer<DetailImamCubit, DetailImamState>(
          listener: (context, state){
            if(state is DetailImamCreating){
              EasyLoading.show(status: 'Loading', dismissOnTap: false, maskType: EasyLoadingMaskType.black);
            } else if(state is DetailImamCreated) {
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil menambah data jadwal imam');
              AutoRouter.of(context).popAndPush(DetailImamRoute(id: widget.id, hari: widget.hari));
            }else if (state is DetailImamUpdating){
              EasyLoading.show(status: 'Loading', dismissOnTap: false, maskType: EasyLoadingMaskType.black);
            } else if (state is DetailImamUpdated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil merubah data jadwal imam');
              AutoRouter.of(context).popAndPush(DetailImamRoute(id: widget.id, hari: widget.hari));
            }else if(state is DetailImamDeleting){
              EasyLoading.show(status: 'Loading', dismissOnTap: false, maskType: EasyLoadingMaskType.black);
            }else if(state is DetailImamDeleted){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil menghapus data jadwal imam');
              AutoRouter.of(context).popAndPush(DetailImamRoute(id: widget.id, hari: widget.hari));
            }else if(state is DetailImamError){
              EasyLoading.dismiss();
              EasyLoading.showError(state.message!);
            }
          },
          builder: (context, state){
            if (state is DetailImamFailure){
              return ErrorComponent(onPressed: (){
                context.read<DetailImamCubit>().init(widget.id!);
              }, message: state.message,);
            }else if(state is DetailImamLoaded){
              return DetailImamBody(model: context.select((DetailImamCubit cubit) => cubit.model), id: widget.id,);
            }
            return LoadingComp();
          },
        ),
      ),
    );
  }
}

class DetailImamBody extends StatefulWidget{
  final int? id;
  final DetailJadwalImamModel? model;
  const DetailImamBody({Key? key, required this.model, this.id}) : super (key: key);
  
  @override
  _DetailImamBodyState createState() => _DetailImamBodyState();
}

class _DetailImamBodyState extends State<DetailImamBody>{
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
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                ),
              backgroundColor: Colors.white,
              isScrollControlled: true,
              context: context,
              builder: (context){
                  return TambahDetail(c:context, id: widget.id!);
              }
            ).then((value){
              if(value!=null){
                context.read<DetailImamCubit>().createJadwalImam(value);
              }
            });
          },
    label: Text('Tambah'), icon: Icon(Icons.add), backgroundColor: kPrimaryColor,
      ),
      body: RefreshIndicator(
        key: _refresh,
        onRefresh: ()=>context.read<DetailImamCubit>().init(widget.id!),
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    IconButton(icon: Icon(Icons.edit, color: bluePrimary,), onPressed: (){
                      showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                      ),
                      backgroundColor: Colors.white,
                      isScrollControlled: true,
                      context: context,
                      builder: (context){
                        return EditDetail(model: widget.model, c:context, index:index);
                      }
                      ).then((value) {
                        if(value!= null){
                          context.read<DetailImamCubit>().updateJadwalImam(value);
                        }
                      });
                      },
                      ),
                      IconButton(icon: Icon(Icons.delete), onPressed: (){
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
                                  context.read<DetailImamCubit>().deleteJadwalImam(_id);
                                  Navigator.pop(context);
                                },
                                color: kPrimaryColor)
                              ],
                            ),
                          ));
                        },
                        color: Colors.red,
                      ),
                    ],
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

class TambahDetail extends StatefulWidget{
  final int id;
  final BuildContext c;
  const TambahDetail({Key? key, required this.c, required this.id}) : super (key: key);

  @override
  _TambahDetailState createState() => _TambahDetailState();
}

class _TambahDetailState extends State<TambahDetail>{
  GlobalKey<FormState> _form = GlobalKey();
  TextEditingController jadwal = TextEditingController();
  TextEditingController nama = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Tambah Jadwal Imam", style: TextStyle(fontSize: 18),),
            CustomForm(
                label: "Jadwal",
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: jadwal,
                  validator: (value) => validateForm(value?.toString()?? '', label: 'Jadwal'),
                  decoration: InputDecoration(
                    hintText: 'Masukkan jadwal yang ingin dirubah',
                  ),
                )
            ),
            CustomForm(
                label: "Nama Imam",
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: nama,
                  validator: (value) => validateForm(value?.toString()?? '', label: 'Nama'),
                  decoration: InputDecoration(
                    hintText: 'Masukkan nama imam yang ingin dirubah',
                  ),
                )
            ),
            SizedBox(height: 20,),
            CustomButton(
                label: 'Simpan',
                onPressed: (){
                  FocusScope.of(context).unfocus();
                  if(_form.currentState!.validate()){
                    Map data = {
                      'id_jadwal_imam' : widget.id,
                      'jadwal' : jadwal.text,
                      'nama' : nama.text,
                    };
                    Navigator.pop(context, data);
                  }
                },
                color: bluePrimary),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom,)
          ],
        ),
      ),
    );
  }
}

class EditDetail extends StatefulWidget{
  final DetailJadwalImamModel? model;
  final BuildContext c;
  final int index;
  const EditDetail({Key? key, required this.model, required this.c, required this.index});

  @override
  _EditDetailState createState() => _EditDetailState();
}

class _EditDetailState extends State<EditDetail>{
  GlobalKey<FormState> _form = GlobalKey();
  TextEditingController jadwal = TextEditingController();
  TextEditingController nama = TextEditingController();
  @override
  void initState() {
    super.initState();
    jadwal.text = widget.model?.results?[widget.index].jadwal??'';
    nama.text = widget.model?.results?[widget.index].nama??'';
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Jadwal Imam", style: TextStyle(fontSize: 18),),
            CustomForm(
                label: "Jadwal",
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: jadwal,
                  validator: (value) => validateForm(value?.toString()?? '', label: 'Jadwal'),
                  decoration: InputDecoration(
                    hintText: 'Masukkan jadwal yang ingin dirubah',
                  ),
                )
            ),
            CustomForm(
                label: "Nama Imam",
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: nama,
                  validator: (value) => validateForm(value?.toString()?? '', label: 'Nama Imam'),
                  decoration: InputDecoration(
                    hintText: 'Masukkan nama imam yang ingin dirubah',
                  ),
                )
            ),
            SizedBox(height: 20,),
            CustomButton(
                label: 'Simpan',
                onPressed: (){
                  FocusScope.of(context).unfocus();
                  if(_form.currentState!.validate()){
                    Map data = {
                      'id' : widget.model?.results?[widget.index].id,
                      'jadwal' : jadwal.text,
                      'nama' : nama.text,
                    };
                    Navigator.pop(context, data);
                  }
                },
                color: bluePrimary),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom,)
          ],
        ),
      ),
    );
  }
}