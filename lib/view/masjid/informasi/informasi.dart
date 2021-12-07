import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_mosque/blocs/masjid/informasi/informasi_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/config/router.gr.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/models/informasi_model.dart';
import 'package:smart_mosque/utils/string_helper.dart';
import 'package:smart_mosque/utils/validate_helper.dart';
import 'package:smart_mosque/view/components/custom_button.dart';
import 'package:smart_mosque/view/components/custom_form.dart';
import 'package:smart_mosque/view/components/error_component.dart';
import 'package:smart_mosque/view/components/loading_com.dart';
import 'package:smart_mosque/view/components/no_data.dart';

class Informasi extends StatefulWidget{
  const Informasi({Key? key}) :super (key: key);

  @override
  _InformasiState createState() => _InformasiState();
}

class _InformasiState extends State<Informasi>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<InformasiCubit>()..init(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Informasi Masjid'),
        ),
        body: BlocConsumer<InformasiCubit, InformasiState>(
          listener: (context, state){
            if(state is InformasiCreating){
              EasyLoading.show(status: 'Loading', dismissOnTap: false, maskType: EasyLoadingMaskType.black);
            } else if(state is InformasiCreated) {
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil menambah data informasi');
              AutoRouter.of(context).popAndPush(InformasiRoute());
            }else if (state is InformasiUpdating) {
              EasyLoading.show(status: 'Loading', dismissOnTap: false, maskType: EasyLoadingMaskType.black);
            }else if (state is InformasiUpdated) {
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil merubah data informasi');
              AutoRouter.of(context).popAndPush(InformasiRoute());
            }else if(state is InformasiDeleting){
              EasyLoading.show(status: 'Loading', dismissOnTap: false, maskType: EasyLoadingMaskType.black);
            }else if(state is InformasiDeleted){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil menghapus data informasi');
              AutoRouter.of(context).popAndPush(InformasiRoute());
            }else if(state is InformasiError){
              EasyLoading.dismiss();
              EasyLoading.showError(state.message!);
            }
          },
          builder: (context, state){
            if (state is InformasiFailure){
              return ErrorComponent(onPressed: (){
                context.read<InformasiCubit>().init();
              }, message: state.message,);
            }else if(state is InformasiLoaded){
              return InformasiBody(model: context.select((InformasiCubit cubit) => cubit.model));
            }
            return LoadingComp();
          },
        ),
      ),
    );
  }
}

class InformasiBody extends StatefulWidget{
  final InformasiModel? model;
  const InformasiBody({Key? key, required this.model}) : super (key: key);

  @override
  _InformasiBodyState createState() => _InformasiBodyState();
}

class _InformasiBodyState extends State<InformasiBody>{
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
              builder: (context){
                return TambahInformasi(c:context);
              }
          ).then((value){
            if(value!=null){
              context.read<InformasiCubit>().createInformasi(value);
            }
          });
        },
        label: Text('Tambah'), icon: Icon(Icons.add), backgroundColor: kPrimaryColor,
      ),
      body: RefreshIndicator(
        key: _refresh,
        onRefresh: ()=>context.read<InformasiCubit>().init(),
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
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: (){
                                              showModalBottomSheet(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                                                  ),
                                                  backgroundColor: Colors.white,
                                                  isScrollControlled: true,
                                                  context: context,
                                                  builder: (context) {
                                                    return EditInformasi(model: widget.model, c:context, index:index);
                                                  }
                                              ).then((value) {
                                                if(value!= null){
                                                  context.read<InformasiCubit>().updateInformasi(value);
                                                }
                                              });
                                            },
                                            icon: Icon(Icons.edit, color: bluePrimary,)
                                        ),
                                        IconButton(
                                            onPressed: (){
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
                                                              context.read<InformasiCubit>().deleteInformasi(_id);
                                                              Navigator.pop(context);
                                                            },
                                                            color: kPrimaryColor)
                                                      ],
                                                    ),
                                                  )
                                              );
                                            },
                                            icon: Icon(Icons.delete, color: Colors.red,)
                                        ),
                                      ],
                                    )
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

class TambahInformasi extends StatefulWidget{
  final BuildContext c;
  const TambahInformasi({Key? key, required this.c}) : super (key: key);

  @override
  _TambahInformasiState createState() => _TambahInformasiState();
}

class _TambahInformasiState extends State<TambahInformasi>{
  GlobalKey<FormState> _form = GlobalKey();
  TextEditingController judul = TextEditingController();
  TextEditingController isi = TextEditingController();
  TextEditingController tanggal = TextEditingController();
  TextEditingController waktu = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  @override
  void initState() {
    super.initState();
    keterangan.text = '-';
  }
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Tambah Informasi", style: TextStyle(fontSize: 18),),
              SizedBox(height: 10,),
              CustomForm(
                  label: "Judul Informasi",
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: judul,
                    validator: (value) => validateForm(value?.toString()?? '', label: 'Judul Informasi'),
                    decoration: InputDecoration(
                      hintText: 'Masukkan Judul Informasi',
                    ),
                  )
              ),
              CustomForm(
                  label: "Isi Informasi",
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 6,
                    controller: isi,
                    validator: (value) => validateForm(value?.toString()?? '', label: 'Isi Informasi'),
                    decoration: InputDecoration(
                      hintText: 'Masukkan Isi Informasi',
                    ),
                  )
              ),
              CustomForm(
                label: 'Waktu',
                child: TextFormField(
                  controller: waktu,
                  validator: (value)=>validateForm(value.toString(), label: 'Waktu'),
                  readOnly: true,
                  onTap: (){
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then((value){
                      if(value!=null){
                        waktu.text = value.format(context);
                      }
                    });
                  },
                  decoration: InputDecoration(
                      hintText: 'Pilih waktu'
                  ),
                ),
              ),
              CustomForm(
                label: 'Tanggal Kegiatan',
                child: TextFormField(
                  controller: tanggal,
                  validator: (value)=>validateForm(value.toString(), label: 'Tanggal'),
                  readOnly: true,
                  onTap: (){
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      firstDate: DateTime(2000),
                    ).then((value){
                      if(value!=null){
                        tanggal.text = dbDateFormat(value);
                      }
                    });
                  },
                  decoration: InputDecoration(
                      hintText: 'Pilih tanggal'
                  ),
                ),
              ),
              CustomForm(
                  label: "Keterangan",
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: keterangan,
                    validator: (value) => validateForm(value?.toString()?? '', label: 'Keterangan'),
                    decoration: InputDecoration(
                      hintText: 'Keterangan',
                    ),
                  )
              ),
              SizedBox(height: 20,),
              CustomButton(
                  label: 'Tambah',
                  onPressed: (){
                    FocusScope.of(context).unfocus();
                    if(_form.currentState!.validate()){
                      Map data = {
                        'judul' : judul.text,
                        'isi' : isi.text,
                        'waktu' : waktu.text,
                        'tanggal' : tanggal.text,
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
      ),
    );
  }
}

class EditInformasi extends StatefulWidget{
  final InformasiModel? model;
  final BuildContext c;
  final int index;
  const EditInformasi({Key? key, required this.model, required this.c, required this.index}) : super (key: key);

  @override
  _EditInformasiState createState() => _EditInformasiState();
}

class _EditInformasiState extends State<EditInformasi>{
  GlobalKey<FormState> _form = GlobalKey();
  TextEditingController judul = TextEditingController();
  TextEditingController isi = TextEditingController();
  TextEditingController tanggal = TextEditingController();
  TextEditingController waktu = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  @override
  void initState() {
    super.initState();
    DateTime? tgl = widget.model?.results?[widget.index].tanggal;
    judul.text = widget.model?.results?[widget.index].judul ?? '';
    isi.text = widget.model?.results?[widget.index].isi ?? '';
    waktu.text = widget.model?.results?[widget.index].waktu ?? '';
    tanggal.text = dbDateFormat(tgl!);
    keterangan.text = widget.model?.results?[widget.index].keterangan ?? '';
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Edit Informasi", style: TextStyle(fontSize: 18),),
              SizedBox(height: 10,),
              CustomForm(
                  label: "Judul Informasi",
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: judul,
                    validator: (value) => validateForm(value?.toString()?? '', label: 'Judul Informasi'),
                    decoration: InputDecoration(
                      hintText: 'Masukkan Judul Informasi',
                    ),
                  )
              ),
              CustomForm(
                  label: "Isi Informasi",
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 6,
                    controller: isi,
                    validator: (value) => validateForm(value?.toString()?? '', label: 'Isi Informasi'),
                    decoration: InputDecoration(
                      hintText: 'Masukkan Isi Informasi',
                    ),
                  )
              ),
              CustomForm(
                label: 'Waktu',
                child: TextFormField(
                  controller: waktu,
                  validator: (value)=>validateForm(value.toString(), label: 'Waktu'),
                  readOnly: true,
                  onTap: (){
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then((value){
                      if(value!=null){
                        waktu.text = value.format(context);
                      }
                    });
                  },
                  decoration: InputDecoration(
                      hintText: 'Pilih waktu'
                  ),
                ),
              ),
              CustomForm(
                label: 'Tanggal Kegiatan',
                child: TextFormField(
                  controller: tanggal,
                  validator: (value)=>validateForm(value.toString(), label: 'Tanggal'),
                  readOnly: true,
                  onTap: (){
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      firstDate: DateTime(2000),
                    ).then((value){
                      if(value!=null){
                        tanggal.text = dbDateFormat(value);
                      }
                    });
                  },
                  decoration: InputDecoration(
                      hintText: 'Pilih tanggal'
                  ),
                ),
              ),
              CustomForm(
                  label: "Keterangan",
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: keterangan,
                    validator: (value) => validateForm(value?.toString()?? '', label: 'Keterangan'),
                    decoration: InputDecoration(
                      hintText: 'Keterangan',
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
                        'judul' : judul.text,
                        'isi' : isi.text,
                        'waktu' : waktu.text,
                        'tanggal' : tanggal.text,
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
      ),
    );
  }
}