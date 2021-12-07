import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:smart_mosque/blocs/masjid/keuangan/pengeluaran/pengeluaran_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/config/router.gr.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/models/pengeluaran_model.dart';
import 'package:smart_mosque/utils/validate_helper.dart';
import 'package:smart_mosque/view/components/custom_button.dart';
import 'package:smart_mosque/view/components/custom_form.dart';
import 'package:smart_mosque/view/components/error_component.dart';
import 'package:smart_mosque/view/components/loading_com.dart';
import 'package:smart_mosque/view/components/no_data.dart';

class Pengeluaran extends StatefulWidget{
  const Pengeluaran({Key? key}) : super (key: key);

  @override
  _PengeluaranState createState() => _PengeluaranState();
}

class _PengeluaranState extends State<Pengeluaran>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<PengeluaranCubit>()..init(),
      child: Scaffold(
        body: BlocConsumer<PengeluaranCubit, PengeluaranState>(
          listener: (context, state){
            if(state is PengeluaranCreating){
              EasyLoading.show(status: 'Loading', dismissOnTap: false, maskType: EasyLoadingMaskType.black);
            }else if (state is PengeluaranCreated) {
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil menambah data pengeluaran');
              AutoRouter.of(context).popAndPush(KeuanganIndexRoute());
            }else if (state is PengeluaranUpdating){
              EasyLoading.show(status: 'Loading', dismissOnTap: false, maskType: EasyLoadingMaskType.black);
            }else if (state is PengeluaranUpdated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil merubah data pengeluaran');
              AutoRouter.of(context).popAndPush(KeuanganIndexRoute());
            }else if(state is PengeluaranError){
              EasyLoading.dismiss();
              EasyLoading.showError(state.message!);
            }
          },
          builder: (context, state){
            if(state is PengeluaranFailure){
              return ErrorComponent(onPressed: (){
                context.read<PengeluaranCubit>().init();
              }, message: state.message,);
            }else if (state is PengeluaranLoaded){
              return PengeluaranBody(model: context.select((PengeluaranCubit cubit) => cubit.model));
            }
            return LoadingComp();
          },
        ),
      ),
    );
  }
}

class PengeluaranBody extends StatefulWidget{
  final PengeluaranModel? model;
  const PengeluaranBody({Key? key, required this.model}) : super (key: key);

  @override
  _PengeluaranBodyState createState() => _PengeluaranBodyState();
}

class _PengeluaranBodyState extends State<PengeluaranBody>{
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
                  return TambahPengeluaran(c:context);
                }
            ).then((value) {
              if(value!=null){
                context.read<PengeluaranCubit>().createPengeluaran(value);
              }
            });
          },
          label: Text('Tambah'), icon: Icon(Icons.add), backgroundColor: kPrimaryColor,
        ),
        body: RefreshIndicator(
            key: _refresh,
            onRefresh: ()=> context.read<PengeluaranCubit>().init(),
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
                          trailing: IconButton(icon: Icon(Icons.edit, color: bluePrimary,), onPressed: (){
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                ),
                                backgroundColor: Colors.white,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return EditPengeluaran(model:widget.model, c:context, index:index);
                                }
                            ).then((value) {
                              if(value!=null){
                                context.read<PengeluaranCubit>().updatePengeluaran(value);
                              }
                            });
                          },
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

class TambahPengeluaran extends StatefulWidget{
  final BuildContext c;
  const TambahPengeluaran({Key? key, required this.c}) : super (key: key);

  @override
  _TambahPengeluaranState createState() => _TambahPengeluaranState();
}

class _TambahPengeluaranState extends State<TambahPengeluaran>{
  GlobalKey<FormState> _form = GlobalKey();
  TextEditingController nama = TextEditingController();
  TextEditingController nominal = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Tambah Pengeluaran", style: TextStyle(fontSize: 18),),
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
                label: "Nominal",
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: nominal,
                  validator: (value) => validateForm(value?.toString()?? '', label: 'Nominal'),
                  decoration: InputDecoration(
                    hintText: 'Masukkan nama',
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
                    hintText: 'Masukkan nama',
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
                      'nominal' : nominal.text,
                      'keterangan' : keterangan.text,
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

class EditPengeluaran extends StatefulWidget{
  final PengeluaranModel? model;
  final BuildContext c;
  final int index;
  const EditPengeluaran({Key? key, required this.model, required this.c, required this.index});

  @override
  _EditPengeluaranState createState() => _EditPengeluaranState();
}

class _EditPengeluaranState extends State<EditPengeluaran>{
  GlobalKey<FormState> _form = GlobalKey();
  TextEditingController nama = TextEditingController();
  TextEditingController nominal = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  @override
  void initState() {
    super.initState();
    nama.text = widget.model?.results?[widget.index].nama.toString() ?? '';
    nominal.text = widget.model?.results?[widget.index].nominal.toString() ?? '';
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
            Text("Edit Pemasukan", style: TextStyle(fontSize: 18),),
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
                label: "Nominal",
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: nominal,
                  validator: (value) => validateForm(value?.toString()?? '', label: 'Nama'),
                  decoration: InputDecoration(
                    hintText: 'Masukkan nominal yang ingin dirubah',
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
                      'nominal' : nominal.text,
                      'keterangan' : keterangan.text,
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