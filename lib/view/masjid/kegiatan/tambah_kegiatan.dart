import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_mosque/blocs/masjid/kegiatan/tambah_kegiatan/tambah_kegiatan_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/config/router.gr.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/models/jamaah_list_model.dart';
import 'package:smart_mosque/utils/string_helper.dart';
import 'package:smart_mosque/utils/validate_helper.dart';
import 'package:smart_mosque/view/components/custom_button.dart';
import 'package:smart_mosque/view/components/custom_form.dart';
import 'package:smart_mosque/view/components/custom_outline_button.dart';
import 'package:smart_mosque/view/components/error_component.dart';
import 'package:smart_mosque/view/components/loading_com.dart';

class TambahKegiatan extends StatelessWidget{
  const TambahKegiatan({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<TambahKegiatanCubit>()..init(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tambah Kegiatan'),
        ),
        body: BlocConsumer<TambahKegiatanCubit,TambahKegiatanState>(
          listener: (context,state){
            if(state is TambahKegiatanCreating){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if(state is TambahKegiatanCreated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil menambah data kegiatan');
              AutoRouter.of(context).popUntil(ModalRoute.withName(KegiatanRoute.name));
            }else if(state is TambahKegiatanError){
              EasyLoading.dismiss();
              EasyLoading.showError(state.message);
            }
          },
          builder: (context,state){
            if(state is TambahKegiatanLoading){
              return LoadingComp();
            }else if(state is TambahKegiatanFailure){
              return ErrorComponent(onPressed: (){
                context.read<TambahKegiatanCubit>()..init();
              });
            }
            return TambahKegiatanBody(jamaah: context.select((TambahKegiatanCubit bloc) => bloc.jamaah),);
          },
        ),
      ),
    );
  }
}

class TambahKegiatanBody extends StatefulWidget{
  final JamaahListModel? jamaah;
  const TambahKegiatanBody({Key? key, required this.jamaah}) : super (key: key);

  @override
  _TambahKegiatanBodyState createState() => _TambahKegiatanBodyState();
}

class _TambahKegiatanBodyState extends State<TambahKegiatanBody>{
  GlobalKey<FormState> _form = GlobalKey();
  String? jenis;
  String? status_iuran;
  String? status_anggota;
  TextEditingController nama = TextEditingController();
  TextEditingController waktu = TextEditingController();
  TextEditingController tanggal = TextEditingController();
  DateTime now = DateTime.now();
  bool _status_iuran = false;
  bool _anggota = false;
  bool _detail_anggota = false;
  List<String>? donatur = [];
  List<String>? nominal = [];
  List<String>? ket_iuran = [];

  List<String>? anggota = [];
  List<String>? keterangan = [];

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
                CustomForm(
                    label: "Nama Kegiatan",
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: nama,
                      validator: (value) => validateForm(value?.toString()?? '', label: 'Hari'),
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
                        hintText: 'Pilih waktu kegiatan'
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
                        hintText: 'Pilih tanggal kegiatan'
                    ),
                  ),
                ),
                CustomForm(
                  label: 'Status Iuran',
                  child: DropdownButtonFormField(
                    items: ['Tidak Ada', 'Donatur','Peserta'].map((e) => DropdownMenuItem(
                      child: Text('$e'),
                      value: e,
                    ))
                        .toList(),
                    value: status_iuran,
                    validator: (value) =>
                        validateForm(value.toString(), label: 'Status Iuran'),
                    onChanged: (value) {
                      status_iuran = value.toString();
                      setState(() {
                        if (value =='Donatur'){
                          _status_iuran = true;
                        }else{
                          _status_iuran = false;
                        }
                      });
                    },
                    hint: Text('Pilih status iuran'),
                  ),
                ),
                (_status_iuran == true)?CustomForm(label: '${status_iuran}', child:
                Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: (donatur==null||(donatur?.isEmpty??true))?Text('Jamaah belum ditambahkan',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),):Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: donatur?.map((e) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.jamaah?.results?.where((element) => element.idUser.toString()==e).first.user?.nama} - ${nominal?[donatur?.indexOf(e)??-1]}',
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                        ),
                        IconButton(onPressed: (){
                          int j = donatur?.indexOf(e)??0;
                          donatur?.removeAt(j);
                          nominal?.removeAt(j);
                          ket_iuran?.removeAt(j);
                          setState(() {

                          });
                        }, icon: Icon(Icons.delete),color: Colors.red,)
                      ],
                    )).toList()??[],
                  ),
                )
                ):SizedBox(),
                (_status_iuran == true)?CustomOutlineButton(label: 'Tambah ${status_iuran}', onPressed: (){
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20)),
                    backgroundColor: Colors.white,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) =>
                        SheetIuran(jamaah: widget.jamaah, id: donatur??[],),
                  ).then((value){
                    if(value!=null){
                      int i = (donatur?.indexWhere((element) => element==value['donatur'])??-1);
                      donatur?.add(value['donatur']);
                      nominal?.add(value['nominal']);
                      ket_iuran?.add(value['ket_iuran']);
                      setState(() {
                      });
                    }
                  });
                }, color: bluePrimary): SizedBox(),
                (_anggota == true)?CustomForm(
                  label: 'Jenis Anggota',
                  child: DropdownButtonFormField(
                    items: ['Panitia','Peserta'].map((e) => DropdownMenuItem(
                      child: Text('$e'),
                      value: e,
                    ))
                        .toList(),
                    value: status_anggota,
                    validator: (value) =>
                        validateForm(value.toString(), label: 'Jenis Anggota'),
                    onChanged: (value) {
                      status_anggota = value.toString();
                      setState(() {
                        if(value=='Panitia'){
                          _detail_anggota = true;
                        }else{
                          _detail_anggota = false;
                        }
                      });
                    },
                    hint: Text('Pilih jenis anggota'),
                  ),
                ):SizedBox(),
                (_detail_anggota == true)?CustomOutlineButton(label: 'Tambah Anggota', onPressed: (){
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20)),
                    backgroundColor: Colors.white,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) =>
                        SheetAnggota(jamaah: widget.jamaah, id: anggota??[],),
                  ).then((value){
                    if(value!=null){
                      int i = (anggota?.indexWhere((element) => element==value['anggota'])??-1);
                      anggota?.add(value['anggota']);
                      keterangan?.add(value['keterangan']);
                      setState(() {
                      });
                    }
                  });
                }, color: bluePrimary): SizedBox(),
                SizedBox(height: 10,),
                (_anggota == true)?CustomOutlineButton(
                    label: "Hapus Detail Anggota",
                    onPressed: (){
                      setState(() {
                        if(_anggota == true){
                          _anggota = false;
                          _detail_anggota = false;
                        }
                      });
                    },
                    color: kPrimaryColor):CustomOutlineButton(
                    label: "Tambah Detail Anggota",
                    onPressed: (){
                      setState(() {
                        if(_anggota == false){
                          _anggota = true;
                        }
                      });
                    },
                    color: bluePrimary),
                SizedBox(height: 20,),
                CustomButton(
                    label: 'Simpan',
                    onPressed: (){
                      FocusScope.of(context).unfocus();
                      if(_form.currentState!.validate()){
                        Map data = {
                          'nama' : nama.text,
                          'jenis' : jenis,
                          'waktu' : waktu.text,
                          'tanggal' : tanggal.text,
                          'status_iuran' : status_iuran,
                        };
                        if (_status_iuran){
                          data['donatur'] = donatur;
                          data['nominal'] = nominal;
                          data['ket_iuran'] = ket_iuran;
                        }
                        if(_anggota){
                          data['status_anggota'] = status_anggota;
                          if(_detail_anggota){
                            data['id_user'] = anggota;
                            data['keterangan'] = keterangan;
                          }
                        }
                        context.read<TambahKegiatanCubit>().create(data);
                      }
                    },
                    color: bluePrimary),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom,)
              ],
            ),
          ),
        )
    );
  }
}

class SheetIuran extends StatefulWidget{
  final JamaahListModel? jamaah;
  final List<String> id;
  const SheetIuran({Key? key, required this.jamaah, required this.id}) : super (key: key);

  @override
  _SheetIuranState createState() => _SheetIuranState();
}

class _SheetIuranState extends State<SheetIuran>{
  TextEditingController? jamaah = TextEditingController();
  String? id_user;
  String? nominal;
  String? ket_iuran;
  GlobalKey<FormState> _form = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              CustomForm(
                label: 'Nama Jamaah',
                child:  TextFormField(
                  readOnly: true,
                  onTap: (){
                    AutoRouter.of(context).push(CustomOptionWithSearchRoute(options:widget.jamaah?.results
                        ?.map((e)=>{'id':e.idUser.toString(),'nama':'${e.user?.nama}'}).toList() as List,title: 'Pilih Jamaah' ))
                        .then((value){
                      if(value!=null){
                        print(value);
                        Result donaturs = widget.jamaah?.results?.where((element) => element.idUser.toString()==value.toString()).first??Result();
                        jamaah?.text = '${donaturs.user?.nama}';
                        id_user = value.toString();
                        print(jamaah?.text);
                      }
                    });
                  },
                  controller: jamaah,
                  validator: (value) =>
                      validateForm(value.toString(), label: 'Jamaah'),
                  decoration:InputDecoration(
                      hintText: 'Pilih jamaah',
                      suffixIcon: Icon(Icons.arrow_right)
                  ),
                ),
              ),
              CustomForm(label: 'Nominal', child: TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value){
                  nominal = value;
                },
                decoration: InputDecoration(
                    hintText: 'Masukkan nominal'
                ),
              ),
              ),
              CustomForm(label: 'Keterangan', child: TextFormField(
                keyboardType: TextInputType.text,
                onChanged: (value){
                  ket_iuran = value;
                },
                decoration: InputDecoration(
                    hintText: 'Masukkan Keterangan (boleh kosong)'
                ),
              ),
              ),
              SizedBox(height: 20,),
              CustomButton(label: 'Simpan',onPressed: (){
                if(_form.currentState!.validate()){
                  Navigator.pop(context, {
                    'donatur': id_user,
                    'nominal': nominal,
                    'ket_iuran':ket_iuran??'-'
                  });
                }
              },color: bluePrimary,),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom,)
            ],
          ),
        ),
      ),
    );
  }
}

class SheetAnggota extends StatefulWidget{
  final JamaahListModel? jamaah;
  final List<String> id;
  const SheetAnggota({Key? key, required this.jamaah, required this.id}) : super (key: key);

  @override
  _SheetAnggotaState createState() => _SheetAnggotaState();
}

class _SheetAnggotaState extends State<SheetAnggota>{
  TextEditingController? anggota = TextEditingController();
  String? id_user;
  String? keterangan;
  GlobalKey<FormState> _form = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              CustomForm(
                label: 'Nama Anggota',
                child:  TextFormField(
                  readOnly: true,
                  onTap: (){
                    AutoRouter.of(context).push(CustomOptionWithSearchRoute(options:widget.jamaah?.results
                        ?.map((e)=>{'id':e.idUser.toString(),'nama':'${e.user?.nama}'}).toList() as List,title: 'Pilih Warga' ))
                        .then((value){
                      if(value!=null){
                        print(value);
                        Result anggotas = widget.jamaah?.results?.where((element) => element.idUser.toString()==value.toString()).first??Result();
                        anggota?.text = '${anggotas.user?.nama}';
                        id_user = value.toString();
                        print(anggota?.text);
                      }
                    });
                  },
                  controller: anggota,
                  validator: (value) =>
                      validateForm(value.toString(), label: 'Warga'),
                  decoration:InputDecoration(
                      hintText: 'Pilih warga',
                      suffixIcon: Icon(Icons.arrow_right)
                  ),
                ),
              ),
              CustomForm(label: 'Keterangan', child: TextFormField(
                keyboardType: TextInputType.text,
                onChanged: (value){
                  keterangan = value;
                },
                decoration: InputDecoration(
                    hintText: 'Masukkan Keterangan (boleh kosong)'
                ),
              ),
              ),
              SizedBox(height: 20,),
              CustomButton(label: 'Simpan',onPressed: (){
                if(_form.currentState!.validate()){
                  Navigator.pop(context, {
                    'anggota': id_user,
                    'keterangan':keterangan??''
                  });
                }
              },color: bluePrimary,),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom,)
            ],
          ),
        ),
      ),
    );
  }
}