import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_mosque/blocs/masjid/detail/detail_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/config/router.gr.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/models/detail_masjid_model.dart';
import 'package:smart_mosque/utils/validate_helper.dart';
import 'package:smart_mosque/view/components/custom_button.dart';
import 'package:smart_mosque/view/components/custom_form.dart';
import 'package:smart_mosque/view/components/error_component.dart';
import 'package:smart_mosque/view/components/loading_com.dart';

class Detail extends StatefulWidget{
  const Detail({Key? key}) :super (key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<DetailCubit>()..init(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Detail Masjid'),
          elevation: 0,
        ),
        body: BlocConsumer<DetailCubit, DetailState>(
          listener: (context, state){
            if(state is DetailUpdating){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is DetailUpdated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil merubah data');
              AutoRouter.of(context).popAndPush(DetailRoute());
            }else if (state is DetailError){
              EasyLoading.dismiss();
              EasyLoading.showError(state.message!);
            }
          },
          builder: (context, state){
            if(state is DetailFailure){
              return ErrorComponent(onPressed: (){
                context.read<DetailCubit>().init();
              }, message: state.message,);
            }else if(state is DetailLoading){
              return LoadingComp();
            }
            return DetailBody(model: context.select((DetailCubit bloc) => bloc.model));
          },
        ),
      ),
    );
  }
}

class DetailBody extends StatefulWidget{
  final DetailMasjidModel? model;
  const DetailBody({Key? key, required this.model}) : super (key: key);

  @override
  _DetailBodyState createState() => _DetailBodyState();
}

class _DetailBodyState extends State<DetailBody>{
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 20),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40,
                  child: Icon(Icons.person, color: bluePrimary, size: 64,),
                ),
                SizedBox(height: 10,),
                Text('${widget.model?.results?.nama}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
              ],
            ),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text('Alamat'),
                        subtitle: Text('${widget.model?.results?.alamat}'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.phone_android),
                        title: Text('Tipe'),
                        subtitle: Text('${widget.model?.results?.profilMasjid?.tipe}'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.home),
                        title: Text('Luas Bangunan'),
                        subtitle: Text('${widget.model?.results?.profilMasjid?.luasBangunan}'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.home),
                        title: Text('Luas Tanah'),
                        subtitle: Text('${widget.model?.results?.profilMasjid?.luasTanah}'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.home),
                        title: Text('Status Tanah'),
                        subtitle: Text('${widget.model?.results?.profilMasjid?.statusTanah}'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.home),
                        title: Text('Tahun Berdiri'),
                        subtitle: Text('${widget.model?.results?.profilMasjid?.tahunBerdiri}'),
                      ),
                    ],
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: bluePrimary,
                  child: ListTile(
                    onTap: (){
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                          ),
                          backgroundColor: Colors.white,
                          isScrollControlled: true,
                          context: context,
                          builder: (context){
                            return EditDetail(model: widget.model,c:context);
                          }
                      ).then((value){
                        if(value!=null){
                          context.read<DetailCubit>().update(value);
                        }
                      });
                    },
                    leading: CircleAvatar(radius: 20, backgroundColor: Colors.white, child: Icon(Icons.edit, color: bluePrimary,),),
                    title: Text('Edit', style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class EditDetail extends StatefulWidget{
  final DetailMasjidModel? model;
  final BuildContext c;
  const EditDetail({Key? key, required this.model, required this.c}) : super (key: key);

  @override
  _EditDetailState createState() => _EditDetailState();
}

class _EditDetailState extends State<EditDetail>{
  GlobalKey<FormState> _form = GlobalKey();
  TextEditingController nama = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController tipe = TextEditingController();
  TextEditingController luas_bangunan = TextEditingController();
  TextEditingController luas_tanah = TextEditingController();
  TextEditingController status_tanah = TextEditingController();
  TextEditingController tahun_berdiri = TextEditingController();
  @override
  void initState() {
    super.initState();
    nama.text = widget.model?.results?.nama ?? '';
    alamat.text = widget.model?.results?.alamat ?? '';
    tipe.text = widget.model?.results?.profilMasjid?.tipe ?? '';
    luas_bangunan.text = widget.model?.results?.profilMasjid?.luasBangunan ?? '';
    luas_tanah.text = widget.model?.results?.profilMasjid?.luasTanah ?? '';
    status_tanah.text = widget.model?.results?.profilMasjid?.statusTanah ?? '';
    tahun_berdiri.text = widget.model?.results?.profilMasjid?.tahunBerdiri ?? '';
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
              Text("Edit Detail Masjid", style: TextStyle(fontSize: 18),),
              SizedBox(height: 10,),
              CustomForm(
                  label: "Nama",
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: nama,
                    validator: (value) => validateForm(value?.toString()?? '', label: 'Nama Masjid'),
                    decoration: InputDecoration(
                      hintText: 'Masukkan Nama Masjid',
                    ),
                  )
              ),
              CustomForm(
                  label: "Alamat",
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 2,
                    controller: alamat,
                    validator: (value) => validateForm(value?.toString()?? '', label: 'Alamat Masjid'),
                    decoration: InputDecoration(
                      hintText: 'Masukkan Alamat Masjid',
                    ),
                  )
              ),
              CustomForm(
                  label: "Tipe",
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: tipe,
                    validator: (value) => validateForm(value?.toString()?? '', label: 'Tipe Masjid'),
                    decoration: InputDecoration(
                      hintText: 'Masukkan Tipe Masjid',
                    ),
                  )
              ),
              CustomForm(
                  label: "Luas Bangunan",
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: luas_bangunan,
                    validator: (value) => validateForm(value?.toString()?? '', label: 'Luas Bangunan Masjid'),
                    decoration: InputDecoration(
                      hintText: 'Luas Bangunan Masjid',
                    ),
                  )
              ),
              CustomForm(
                  label: "Luas Tanah",
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: luas_tanah,
                    validator: (value) => validateForm(value?.toString()?? '', label: 'Luas Bangunan Tanah'),
                    decoration: InputDecoration(
                      hintText: 'Luas Tanah Masjid',
                    ),
                  )
              ),
              CustomForm(
                  label: "Status Tanah",
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: status_tanah,
                    validator: (value) => validateForm(value?.toString()?? '', label: 'Status Tanah Masjid'),
                    decoration: InputDecoration(
                      hintText: 'Status Tanah Masjid',
                    ),
                  )
              ),
              CustomForm(
                  label: "Tahun Berdiri",
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: tahun_berdiri,
                    validator: (value) => validateForm(value?.toString()?? '', label: 'Tahun Berdiri Masjid'),
                    decoration: InputDecoration(
                      hintText: 'Tahun Beridir Masjid',
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
                        'id' : widget.model?.results?.id,
                        'nama' : nama.text,
                        'alamat' : alamat.text,
                        'tipe' : tipe.text,
                        'luas_bangunan' : luas_bangunan.text,
                        'luas_tanah' : luas_tanah.text,
                        'status_tanah' : status_tanah.text,
                        'tahun_berdiri' : tahun_berdiri.text
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