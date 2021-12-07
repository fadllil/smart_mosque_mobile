import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_mosque/blocs/masjid/pengurus/pengurus_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/config/router.gr.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/models/pengurus_model.dart';
import 'package:smart_mosque/utils/validate_helper.dart';
import 'package:smart_mosque/view/components/custom_button.dart';
import 'package:smart_mosque/view/components/custom_form.dart';
import 'package:smart_mosque/view/components/error_component.dart';
import 'package:smart_mosque/view/components/loading_com.dart';
import 'package:smart_mosque/view/components/no_data.dart';

class Pengurus extends StatefulWidget{
  const Pengurus({Key? key}) : super (key: key);

  @override
  _PengurusState createState() => _PengurusState();
}

class _PengurusState extends State<Pengurus>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=> locator<PengurusCubit>()..init(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Pengurus Masjid'),
        ),
        body: BlocConsumer<PengurusCubit, PengurusState>(
          listener: (context, state){
            if(state is PengurusCreating){
              EasyLoading.show(status: 'Loading', dismissOnTap: false, maskType: EasyLoadingMaskType.black);
            }else if (state is PengurusCreated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil merubah data pengurus');
              AutoRouter.of(context).popAndPush(PengurusRoute());
            }else if(state is PengurusDeleting){
              EasyLoading.show(status: 'Loading', dismissOnTap: false, maskType: EasyLoadingMaskType.black);
            }else if(state is PengurusDeleted){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil menghapus data pengurus');
              AutoRouter.of(context).popAndPush(PengurusRoute());
            }else if(state is PengurusError){
              EasyLoading.dismiss();
              EasyLoading.showError(state.message!);
            }
          },
          builder: (context, state){
            if (state is PengurusFailure){
              return ErrorComponent(onPressed: (){
                context.read<PengurusCubit>().init();
              }, message: state.message,);
            }else if(state is PengurusLoaded){
              return PengurusBody(model: context.select((PengurusCubit cubit) => cubit.model),);
            }
            return LoadingComp();
          },
        ),
      ),
    );
  }
}

class PengurusBody extends StatefulWidget {
  final PengurusModel? model;
  const PengurusBody({Key? key, required this.model}) : super (key: key);

  @override
  _PengurusBodyState createState() => _PengurusBodyState();
}

class _PengurusBodyState extends State<PengurusBody>{
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
            AutoRouter.of(context).push(TambahPengurusRoute());
          },
          label: Text('Tambah'), icon: Icon(Icons.add), backgroundColor: kPrimaryColor,
      ),
      body: RefreshIndicator(
        key: _refresh,
        onRefresh: ()=>context.read<PengurusCubit>().init(),
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
                        Text(widget.model?.results?[index].nama??''),
                        Text(widget.model?.results?[index].jabatan??'', style: TextStyle(fontSize: 14),),
                        Text(widget.model?.results?[index].alamat??'', style: TextStyle(fontSize: 14),),
                      ],
                    ),
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: bluePrimary,
                      child: Icon(Icons.person, color: Colors.white,),
                    ),
                    trailing: IconButton(icon: Icon(Icons.delete), onPressed: (){
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
                                      Map data = {
                                        'id' : id,
                                      };
                                      context.read<PengurusCubit>().deletePengurus(data);
                                      Navigator.pop(context);
                                    },
                                    color: kPrimaryColor)
                              ],
                            ),
                          ));
                      },
                      color: Colors.red,
                    ),
                    onTap: (){
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                        ),
                        backgroundColor: Colors.white,
                        isScrollControlled: true,
                        context: context,
                        builder: (context){
                          return PengurusUpdate(model: widget.model, c: context, index: index,);
                        }
                      ).then((value){
                        if(value!=null){
                          context.read<PengurusCubit>().updatePengurus(value);
                        }
                      });
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

class PengurusUpdate extends StatefulWidget{
  final PengurusModel? model;
  final BuildContext c;
  final int index;
  const PengurusUpdate({Key? key, required this.model, required this.c, required this.index}) : super (key: key);

  _PengurusUpdateState createState() => _PengurusUpdateState();
}

class _PengurusUpdateState extends State<PengurusUpdate>{
  GlobalKey<FormState> _form = GlobalKey();
  TextEditingController nama = TextEditingController();
  TextEditingController jabatan = TextEditingController();
  TextEditingController alamat = TextEditingController();
  @override
  void initState() {
    super.initState();
    nama.text = widget.model?.results?[widget.index].nama??'';
    jabatan.text = widget.model?.results?[widget.index].jabatan??'';
    alamat.text = widget.model?.results?[widget.index].alamat??'';
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
            Text("Edit Data Pengurus", style: TextStyle(fontSize: 18),),
            CustomForm(
                label: "Nama",
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: nama,
                  validator: (value) => validateForm(value?.toString()?? '', label: 'Nama'),
                  decoration: InputDecoration(
                    hintText: 'Masukkan nama yang ingin dirubah',
                  ),
                )
            ),
            CustomForm(
                label: "Jabatan",
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: jabatan,
                  validator: (value) => validateForm(value?.toString()?? '', label: 'Jabatan'),
                  decoration: InputDecoration(
                    hintText: 'Masukkan jabatan yang ingin dirubah',
                  ),
                )
            ),
            CustomForm(
                label: "Alamat",
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: alamat,
                  validator: (value) => validateForm(value?.toString()?? '', label: 'Alamat'),
                  decoration: InputDecoration(
                    hintText: 'Masukkan alamat yang ingin dirubah',
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
                      'nama' : nama.text,
                      'jabatan' : jabatan.text,
                      'alamat' : alamat.text
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