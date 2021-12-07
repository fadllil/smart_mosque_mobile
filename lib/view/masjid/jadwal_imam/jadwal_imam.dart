import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_mosque/blocs/masjid/jadwal-imam/detail/detail_imam_cubit.dart';
import 'package:smart_mosque/blocs/masjid/jadwal-imam/jadwal_imam_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/config/router.gr.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/models/jadwal_imam_model.dart';
import 'package:smart_mosque/utils/validate_helper.dart';
import 'package:smart_mosque/view/components/custom_button.dart';
import 'package:smart_mosque/view/components/custom_form.dart';
import 'package:smart_mosque/view/components/error_component.dart';
import 'package:smart_mosque/view/components/loading_com.dart';
import 'package:smart_mosque/view/components/no_data.dart';

class JadwalImam extends StatefulWidget{
  const JadwalImam({Key? key}) : super (key: key);
  
  @override
  _JadwalImamState createState() => _JadwalImamState();
}

class _JadwalImamState extends State<JadwalImam>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_)=>locator<JadwalImamCubit>()..init(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Jadwal Imam'),
          ),
          body: BlocConsumer<JadwalImamCubit, JadwalImamState>(
            listener: (context, state){
              if(state is JadwalImamCreating){
                EasyLoading.show(status: 'Loading', dismissOnTap: false, maskType: EasyLoadingMaskType.black);
              } else if(state is JadwalImamCreated) {
                EasyLoading.dismiss();
                EasyLoading.showSuccess('Berhasil menambah data jadwal imam');
                AutoRouter.of(context).popAndPush(JadwalImamRoute());
              }else if (state is JadwalImamUpdating) {
                EasyLoading.show(status: 'Loading', dismissOnTap: false, maskType: EasyLoadingMaskType.black);
              }else if (state is JadwalImamUpdated) {
                EasyLoading.dismiss();
                EasyLoading.showSuccess('Berhasil merubah data jadwal imam');
                AutoRouter.of(context).popAndPush(JadwalImamRoute());
              }else if(state is JadwalImamDeleting){
                EasyLoading.show(status: 'Loading', dismissOnTap: false, maskType: EasyLoadingMaskType.black);
              }else if(state is JadwalImamDeleted){
                EasyLoading.dismiss();
                EasyLoading.showSuccess('Berhasil menghapus data jadwal imam');
                AutoRouter.of(context).popAndPush(JadwalImamRoute());
              }else if(state is JadwalImamError){
                EasyLoading.dismiss();
                EasyLoading.showError(state.message!);
              }
            },
            builder: (context, state){
              if (state is JadwalImamFailure){
                return ErrorComponent(onPressed: (){
                  context.read<JadwalImamCubit>().init();
                }, message: state.message,);
              }else if(state is JadwalImamLoaded){
                return JadwalImamBody(model: context.select((JadwalImamCubit cubit) => cubit.model));
              }
              return LoadingComp();
            },
          ),
        ),
    );
  }
}

class JadwalImamBody extends StatefulWidget{
  final JadwalImamModel? model;
  const JadwalImamBody({Key? key, required this.model}) : super (key: key);
  
  @override
  _JadwalImamBodyState createState() => _JadwalImamBodyState();
}

class _JadwalImamBodyState extends State<JadwalImamBody>{
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
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
            ),
            backgroundColor: Colors.white,
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Tambah(c:context);
            }
          ).then((value){
            if(value!=null){
              context.read<JadwalImamCubit>().createJadwal(value);
            }
          });
        },
        label: Text('Tambah'), icon: Icon(Icons.add), backgroundColor: kPrimaryColor,
      ),
      body: RefreshIndicator(
        key: _refresh,
        onRefresh: ()=>context.read<JadwalImamCubit>().init(),
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
                                return Update(model: widget.model, c:context, index:index);
                              }
                          ).then((value) {
                            if (value!=null){
                              context.read<JadwalImamCubit>().updateJadwal(value);
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
                                          context.read<JadwalImamCubit>().deleteJadwal(_id);
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
                    onTap: (){
                      int? id = widget.model?.results?[index].id;
                      AutoRouter.of(context).push(DetailImamRoute(id: id, hari: widget.model?.results?[index].hari));
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

class Tambah extends StatefulWidget{
  final BuildContext c;
  const Tambah({Key? key, required this.c}) : super (key: key);

  @override
  _TambahState createState() => _TambahState();
}

class _TambahState extends State<Tambah>{
  GlobalKey<FormState> _form = GlobalKey();
  TextEditingController hari = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Tambah Hari", style: TextStyle(fontSize: 18),),
            CustomForm(
                label: "Hari",
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: hari,
                  validator: (value) => validateForm(value?.toString()?? '', label: 'Hari'),
                  decoration: InputDecoration(
                    hintText: 'Masukkan hari',
                  ),
                )
            ),
            SizedBox(height: 20,),
            CustomButton(
                label: 'Simpan',
                onPressed: (){
                  FocusScope.of(context).unfocus();
                  if(_form.currentState!.validate()){
                    String _hari = hari.text;
                    Navigator.pop(context, _hari);
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

class Update extends StatefulWidget{
  final JadwalImamModel? model;
  final BuildContext c;
  final int index;
  const Update({Key? key, required this.model, required this.c, required this.index}) : super (key: key);

  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update>{
  GlobalKey<FormState> _form = GlobalKey();
  TextEditingController hari = TextEditingController();
  @override
  void initState() {
    super.initState();
    hari.text = widget.model?.results?[widget.index].hari??'';
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
            Text("Edit Hari", style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            CustomForm(
                label: "Hari",
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: hari,
                  validator: (value) => validateForm(value?.toString()?? '', label: 'Hari'),
                  decoration: InputDecoration(
                    hintText: 'Masukkan hari yang ingin dirubah',
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
                      'hari' : hari.text,
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