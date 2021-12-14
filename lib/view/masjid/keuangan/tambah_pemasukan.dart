import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_mosque/blocs/masjid/keuangan/tambah_pemasukan/tambah_pemasukan_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/config/router.gr.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/models/jamaah_list_model.dart';
import 'package:smart_mosque/utils/validate_helper.dart';
import 'package:smart_mosque/view/components/custom_button.dart';
import 'package:smart_mosque/view/components/custom_form.dart';
import 'package:smart_mosque/view/components/custom_outline_button.dart';
import 'package:smart_mosque/view/components/error_component.dart';
import 'package:smart_mosque/view/components/loading_com.dart';

class TambahPemasukan extends StatelessWidget{
  const TambahPemasukan({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<TambahPemasukanCubit>()..init(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tambah Kegiatan'),
        ),
        body: BlocConsumer<TambahPemasukanCubit,TambahPemasukanState>(
          listener: (context,state){
            if(state is TambahPemasukanCreating){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if(state is TambahPemasukanCreated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil menambah data kegiatan');
              AutoRouter.of(context).popUntil(ModalRoute.withName(KeuanganIndexRoute.name));
            }else if(state is TambahPemasukanError){
              EasyLoading.dismiss();
              EasyLoading.showError(state.message);
            }
          },
          builder: (context,state){
            if(state is TambahPemasukanLoading){
              return LoadingComp();
            }else if(state is TambahPemasukanFailure){
              return ErrorComponent(onPressed: (){
                context.read<TambahPemasukanCubit>()..init();
              });
            }
            return TambahPemasukanBody(jamaah: context.select((TambahPemasukanCubit bloc) => bloc.jamaah),);
          },
        ),
      ),
    );
  }
}

class TambahPemasukanBody extends StatefulWidget{
  final JamaahListModel? jamaah;
  const TambahPemasukanBody({Key? key, required this.jamaah}) : super (key: key);

  @override
  _TambahPemasukanBodyState createState() => _TambahPemasukanBodyState();
}

class _TambahPemasukanBodyState extends State<TambahPemasukanBody>{
  GlobalKey<FormState> _form = GlobalKey();
  TextEditingController nama = TextEditingController();
  String? jenis;
  bool _nominal = false;
  bool _donatur = false;
  TextEditingController nominal = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  List<String>? donatur = [];
  List<String>? an = [];
  List<String>? nominal_donatur = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Tambah Pemasukan", style: TextStyle(fontSize: 18),),
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
                label: 'Jenis',
                child: DropdownButtonFormField(
                  items: ['Donatur','Infak'].map((e) => DropdownMenuItem(
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
                      if (value == 'Donatur'){
                        _nominal = false;
                        _donatur = true;
                      }else{
                        _nominal = true;
                        _donatur = false;
                      }
                    });
                  },
                  hint: Text('Pilih jenis'),
                ),
              ),
              (_nominal == true) ? CustomForm(
                  label: "Nominal",
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: nominal,
                    validator: (value) => validateForm(value?.toString()?? '', label: 'Nominal'),
                    decoration: InputDecoration(
                      hintText: 'Masukkan nama',
                    ),
                  )
              ):SizedBox(),
              (_donatur == true)?CustomForm(label: '${jenis}', child:
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
                        '${widget.jamaah?.results?.where((element) => element.idUser.toString()==e).first.user?.nama} - ${nominal_donatur?[donatur?.indexOf(e)??-1]}',
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                      IconButton(onPressed: (){
                        int j = donatur?.indexOf(e)??0;
                        donatur?.removeAt(j);
                        nominal_donatur?.removeAt(j);
                        an?.removeAt(j);
                        setState(() {

                        });
                      }, icon: Icon(Icons.delete),color: Colors.red,)
                    ],
                  )).toList()??[],
                ),
              )
              ):SizedBox(),
              (_donatur == true)?CustomOutlineButton(label: 'Tambah Anggota', onPressed: (){
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20)),
                  backgroundColor: Colors.white,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) =>
                      SheetPemasukan(jamaah: widget.jamaah, id: donatur??[],),
                ).then((value){
                  if(value!=null){
                    int i = (donatur?.indexWhere((element) => element==value['donatur'])??-1);
                    donatur?.add(value['donatur']);
                    an?.add(value['an']);
                    nominal_donatur?.add(value['nominal_donatur']);
                    setState(() {
                    });
                  }
                });
              }, color: bluePrimary): SizedBox(),
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
                        'keterangan' : keterangan.text,
                        'jenis' : jenis,
                      };
                      if (_donatur){
                        data['donatur'] = donatur;
                        data['an'] = an;
                        data['nominal_donatur'] = nominal_donatur;
                      }else{
                        data['nominal'] = nominal.text;
                      }
                      context.read<TambahPemasukanCubit>().create(data);
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

class SheetPemasukan extends StatefulWidget{
  final JamaahListModel? jamaah;
  final List<String> id;
  const SheetPemasukan({Key? key, required this.jamaah, required this.id}) : super (key: key);

  @override
  _SheetPemasukanState createState() => _SheetPemasukanState();
}

class _SheetPemasukanState extends State<SheetPemasukan>{
  TextEditingController? jamaah = TextEditingController();
  String? id_user;
  String? an;
  String? nominal_donatur;
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
                  nominal_donatur = value;
                },
                decoration: InputDecoration(
                    hintText: 'Masukkan nominal'
                ),
              ),
              ),
              CustomForm(label: 'Nama Inisial', child: TextFormField(
                keyboardType: TextInputType.text,
                onChanged: (value){
                  an = value;
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
                    'nominal_donatur': nominal_donatur,
                    'an':an??'-'
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