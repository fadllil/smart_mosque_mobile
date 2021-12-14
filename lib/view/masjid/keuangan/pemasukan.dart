import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:smart_mosque/blocs/masjid/keuangan/pemasukan/pemasukan_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/config/router.gr.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/models/pemasukan_model.dart';
import 'package:smart_mosque/utils/validate_helper.dart';
import 'package:smart_mosque/view/components/custom_button.dart';
import 'package:smart_mosque/view/components/custom_form.dart';
import 'package:smart_mosque/view/components/error_component.dart';
import 'package:smart_mosque/view/components/loading_com.dart';
import 'package:smart_mosque/view/components/no_data.dart';

class Pemasukan extends StatefulWidget{
  const Pemasukan({Key? key}) : super (key: key);

  @override
  _PemasukanState createState() => _PemasukanState();
}

class _PemasukanState extends State<Pemasukan>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<PemasukanCubit>()..init(),
      child: Scaffold(
        body: BlocConsumer<PemasukanCubit, PemasukanState>(
          listener: (context, state){
            if(state is PemasukanCreating){
              EasyLoading.show(status: 'Loading', dismissOnTap: false, maskType: EasyLoadingMaskType.black);
            }else if (state is PemasukanCreated) {
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil menambah data pemasukan');
              AutoRouter.of(context).popAndPush(KeuanganIndexRoute());
            }else if (state is PemasukanUpdating){
              EasyLoading.show(status: 'Loading', dismissOnTap: false, maskType: EasyLoadingMaskType.black);
            }else if (state is PemasukanUpdated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil merubah data pemasukan');
              AutoRouter.of(context).popAndPush(KeuanganIndexRoute());
            }else if(state is PemasukanError){
              EasyLoading.dismiss();
              EasyLoading.showError(state.message!);
            }
          },
          builder: (context, state){
            if(state is PemasukanFailure){
              return ErrorComponent(onPressed: (){
                context.read<PemasukanCubit>().init();
              }, message: state.message,);
            }else if (state is PemasukanLoaded){
              return PemasukanBody(model: context.select((PemasukanCubit cubit) => cubit.model));
            }
            return LoadingComp();
          },
        ),
      ),
    );
  }
}

class PemasukanBody extends StatefulWidget{
  final PemasukanModel? model;
  const PemasukanBody({Key? key, required this.model}) : super (key: key);

  @override
  _PemasukanBodyState createState() => _PemasukanBodyState();
}

class _PemasukanBodyState extends State<PemasukanBody>{
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
            AutoRouter.of(context).push(TambahPemasukanRoute()).then((value) => context.read<PemasukanCubit>().init());
          },
          label: Text('Tambah'), icon: Icon(Icons.add), backgroundColor: kPrimaryColor,
        ),
      body: RefreshIndicator(
      key: _refresh,
      onRefresh: ()=> context.read<PemasukanCubit>().init(),
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
                            return EditPemasukan(model:widget.model, c:context, index:index);
                          }
                      ).then((value) {
                        if(value!=null){
                          context.read<PemasukanCubit>().updatePemasukan(value);
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

class EditPemasukan extends StatefulWidget{
  final PemasukanModel? model;
  final BuildContext c;
  final int index;
  const EditPemasukan({Key? key, required this.model, required this.c, required this.index}) : super (key: key);

  @override
  _EditPemasukanState createState() => _EditPemasukanState();
}

class _EditPemasukanState extends State<EditPemasukan>{
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