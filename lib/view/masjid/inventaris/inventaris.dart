import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_mosque/blocs/masjid/inventaris/inventaris_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/config/router.gr.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/models/inventaris_model.dart';
import 'package:smart_mosque/utils/validate_helper.dart';
import 'package:smart_mosque/view/components/custom_button.dart';
import 'package:smart_mosque/view/components/custom_form.dart';
import 'package:smart_mosque/view/components/error_component.dart';
import 'package:smart_mosque/view/components/loading_com.dart';
import 'package:smart_mosque/view/components/no_data.dart';

class Inventaris extends StatefulWidget{
  const Inventaris({Key? key}) : super (key: key);

  @override
  _InventarisState createState() => _InventarisState();
}

class _InventarisState extends State<Inventaris>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<InventarisCubit>()..init(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Inventaris Masjid'),
        ),
        body: BlocConsumer<InventarisCubit, InventarisState>(
          listener: (context, state){
            if(state is InventarisCreating){
              EasyLoading.show(status: 'Loading', dismissOnTap: false, maskType: EasyLoadingMaskType.black);
            }else if (state is InventarisCreated) {
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil menambah data inventaris');
              AutoRouter.of(context).popAndPush(InventarisRoute());
            }else if (state is InventarisUpdating){
              EasyLoading.show(status: 'Loading', dismissOnTap: false, maskType: EasyLoadingMaskType.black);
            }else if (state is InventarisUpdated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil merubah data inventaris');
              AutoRouter.of(context).popAndPush(InventarisRoute());
            }else if(state is InventarisDeleting){
              EasyLoading.show(status: 'Loading', dismissOnTap: false, maskType: EasyLoadingMaskType.black);
            }else if(state is InventarisDeleted){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil menghapus data inventaris');
              AutoRouter.of(context).popAndPush(InventarisRoute());
            }else if(state is InventarisError){
              EasyLoading.dismiss();
              EasyLoading.showError(state.message!);
            }
          },
          builder: (context, state){
            if(state is InventarisFailure){
              return ErrorComponent(onPressed: (){
                context.read<InventarisCubit>().init();
              }, message: state.message,);
            }else if (state is InventarisLoaded){
              return InventarisBody(model: context.select((InventarisCubit cubit) => cubit.model));
            }
            return LoadingComp();
          },
        ),
      ),
    );
  }
}

class InventarisBody extends StatefulWidget{
  final InventarisModel? model;
  const InventarisBody({Key? key, required this.model}) : super (key: key);

  @override
  _InventarisBodyState createState() => _InventarisBodyState();
}

class _InventarisBodyState extends State<InventarisBody>{
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
                  return TambahInventaris(c: context);
                }
            ).then((value) {
              if (value!=null){
                context.read<InventarisCubit>().createInventaris(value);
            }
            });
          },
          label: Text('Tambah'), icon: Icon(Icons.add), backgroundColor: kPrimaryColor,
        ),
        body: RefreshIndicator(
          key: _refresh,
          onRefresh: ()=>context.read<InventarisCubit>().init(),
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
                                  builder: (c) {
                                    return EditInventaris(model: widget.model, c: context, index:index);
                                  }
                              ).then((value) {
                                if(value!= null){
                                  context.read<InventarisCubit>().updateInventaris(value);
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
                                              context.read<InventarisCubit>().deleteInventaris(_id);
                                              Navigator.pop(context);
                                            },
                                            color: kPrimaryColor)
                                      ],
                                    ),
                                  )
                              );
                            },)
                          ],
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

class TambahInventaris extends StatefulWidget{
  final BuildContext c;
  const TambahInventaris({Key? key, required this.c}) : super (key: key);

  @override
  _TambahInventarisState createState() => _TambahInventarisState();
}

class _TambahInventarisState extends State<TambahInventaris>{
  GlobalKey<FormState> _form = GlobalKey();
  TextEditingController nama = TextEditingController();
  TextEditingController jumlah = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  @override
  void initState() {
    super.initState();
    keterangan.text = '-';
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
            Text("Tambah Inventaris", style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            CustomForm(
                label: "Nama",
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: nama,
                  validator: (value) => validateForm(value?.toString()?? '', label: 'Nama'),
                  decoration: InputDecoration(
                    hintText: 'Masukkan nama',
                  ),
                )
            ),
            CustomForm(
                label: "Jumlah",
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: jumlah,
                  validator: (value) => validateForm(value?.toString()?? '', label: 'Jumlah'),
                  decoration: InputDecoration(
                    hintText: 'Masukkan jumlah',
                  ),
                )
            ),
            CustomForm(
                label: "Keterangan",
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: keterangan,
                  validator: (value) => validateForm(value?.toString()?? '', label: 'Keterangan'),
                  decoration: InputDecoration(
                    hintText: 'Masukkan keterangan',
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
                      'nama' : nama.text,
                      'jumlah' : jumlah.text,
                      'keterangan' : keterangan.text
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

class EditInventaris extends StatefulWidget{
  final InventarisModel? model;
  final BuildContext c;
  final int index;
  const EditInventaris({Key? key, required this.model, required this.c, required this.index}) : super (key: key);

  @override
  _EditInventarisState createState() => _EditInventarisState();
}

class _EditInventarisState extends State<EditInventaris>{
  GlobalKey<FormState> _form = GlobalKey();
  TextEditingController nama = TextEditingController();
  TextEditingController jumlah = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  @override
  void initState() {
    super.initState();
    nama.text = widget.model?.results?[widget.index].nama.toString() ?? '';
    jumlah.text = widget.model?.results?[widget.index].jumlah.toString() ?? '';
    keterangan.text = widget.model?.results?[widget.index].keterangan.toString() ?? '';
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
            Text("Edit Inventaris", style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
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
                label: "Jumlah",
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: jumlah,
                  validator: (value) => validateForm(value?.toString()?? '', label: 'Jumlah'),
                  decoration: InputDecoration(
                    hintText: 'Masukkan jumlah yang ingin dirubah',
                  ),
                )
            ),
            CustomForm(
                label: "Keterangan",
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: keterangan,
                  validator: (value) => validateForm(value?.toString()?? '', label: 'Keterangan'),
                  decoration: InputDecoration(
                    hintText: 'Masukkan keterangan yang ingin dirubah',
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
                      'jumlah' : jumlah.text,
                      'keterangan' : keterangan.text
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