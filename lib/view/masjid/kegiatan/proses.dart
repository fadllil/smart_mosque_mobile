import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:smart_mosque/blocs/masjid/kegiatan/kegiatan_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/config/router.gr.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/models/kegiatan_model.dart';
import 'package:smart_mosque/utils/string_helper.dart';
import 'package:smart_mosque/utils/validate_helper.dart';
import 'package:smart_mosque/view/components/custom_button.dart';
import 'package:smart_mosque/view/components/custom_form.dart';
import 'package:smart_mosque/view/components/error_component.dart';
import 'package:smart_mosque/view/components/loading_com.dart';
import 'package:smart_mosque/view/components/no_data.dart';

class Proses extends StatefulWidget{
  const Proses({Key? key}) :super (key: key);

  @override
  _ProsesState createState() => _ProsesState();
}

class _ProsesState extends State<Proses>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<KegiatanCubit>()..proses(),
      child: Scaffold(
        body: BlocConsumer<KegiatanCubit, KegiatanState>(
          listener: (context, state){
            if(state is KegiatanCreating){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is KegiatanCreated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil menambah data');
              AutoRouter.of(context).popAndPush(KegiatanRoute());
            }else if(state is KegiatanUpdating){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is KegiatanUpdated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil merubah data');
              AutoRouter.of(context).popAndPush(KegiatanRoute());
            }else if(state is KegiatanUpdatingStatus){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is KegiatanUpdatedStatus){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil merubah status');
              AutoRouter.of(context).popAndPush(KegiatanRoute());
            }else if(state is KegiatanDeleting){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is KegiatanDeleted){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil menghapus kegiatan');
              AutoRouter.of(context).popAndPush(KegiatanRoute());
            }else if (state is KegiatanError){
              EasyLoading.dismiss();
              EasyLoading.showError(state.message);
            }
          },
          builder: (context, state){
            if(state is KegiatanFailure){
              return ErrorComponent(onPressed: (){
                context.read<KegiatanCubit>().proses();
              }, message: state.message,);
            }else if(state is KegiatanLoading){
              return LoadingComp();
            }
            return ProsesBody(model: context.select((KegiatanCubit bloc) => bloc.model));
          },
        ),
      ),
    );
  }
}

class ProsesBody extends StatefulWidget{
  final KegiatanModel? model;
  const ProsesBody({Key? key, required this.model}) : super (key: key);

  @override
  _ProsesBodyState createState() => _ProsesBodyState();
}

class _ProsesBodyState extends State<ProsesBody>{
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
            AutoRouter.of(context).push(TambahKegiatanRoute()).then((value) => context.read<KegiatanCubit>().proses());
          },
          label: Text('Tambah'), icon: Icon(Icons.add), backgroundColor: kPrimaryColor,
        ),
        body: RefreshIndicator(
          key: _refresh,
          onRefresh: ()=>context.read<KegiatanCubit>().proses(),
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

class EditKegiatan extends StatefulWidget{
  final BuildContext c;
  final KegiatanModel? model;
  final int index;
  const EditKegiatan({Key? key, required this.c, required this.model, required this.index}) : super (key: key);

  @override
  _EditKegiatanState createState() => _EditKegiatanState();
}

class _EditKegiatanState extends State<EditKegiatan>{
  GlobalKey<FormState> _form = GlobalKey();
  String? jenis;
  TextEditingController nama = TextEditingController();
  TextEditingController waktu = TextEditingController();
  TextEditingController tanggal = TextEditingController();
  DateTime now = DateTime.now();
  DateFormat formattedDate = DateFormat('yyyy-MM-dd');
  @override
  void initState() {
    super.initState();
    nama.text = widget.model?.results?[widget.index].nama.toString() ?? '';
    jenis = widget.model?.results?[widget.index].jenis.toString() ?? '';
    waktu.text = widget.model?.results?[widget.index].waktu.toString() ?? '';
    String newTgl = DateFormat('y-MM-dd').format(now);
    tanggal.text = newTgl;
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
              Text("Edit Hari", style: TextStyle(fontSize: 18),),
              SizedBox(height: 10,),
              CustomForm(
                  label: "Nama Kegiatan",
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: nama,
                    validator: (value) => validateForm(value?.toString()?? '', label: 'Nama Kegiatan'),
                    decoration: InputDecoration(
                      hintText: 'Masukkan nama kegiatan yang ingin dirubah',
                    ),
                  )
              ),
              CustomForm(
                label: 'Jenis Kegiatan',
                child: DropdownButtonFormField(
                  items: ['Kegiatan Harian','Lainnya'].map((e) => DropdownMenuItem(
                    child: Text('$e'),
                    value: e,
                  ))
                      .toList(),
                  value: jenis,
                  validator: (value) =>
                      validateForm(value.toString(), label: 'Jenis'),
                  onChanged: (value) {
                    jenis = value.toString();
                    setState(() {

                    });
                  },
                  hint: Text('Pilih jenis kegiatan'),
                ),
              ),
              CustomForm(
                label: 'Waktu Kegiatan',
                child: TextFormField(
                  controller: waktu,
                  validator: (value)=>validateForm(value.toString(), label: 'Waktu Kegiatan'),
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
                      hintText: 'Pilih tanggal kwitansi'
                  ),
                ),
              ),
              CustomForm(
                label: 'Tanggal Kegiatan',
                child: TextFormField(
                  controller: tanggal,
                  validator: (value)=>validateForm(value.toString(), label: 'Tanggal Kegiatan'),
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
                      hintText: 'Pilih tanggal kwitansi'
                  ),
                ),
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
                        'jenis' : jenis,
                        'waktu' : waktu.text,
                        'tanggal' : tanggal.text
                      };
                      Navigator.pop(context, data);
                    }
                  },
                  color: bluePrimary)
            ],
          ),
        ),
      ),
    );
  }
}