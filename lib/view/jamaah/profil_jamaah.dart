import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_mosque/blocs/auth/authentication_cubit.dart';
import 'package:smart_mosque/blocs/jamaah/profil_jamaah/profil_jamaah_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/models/profil_jamaah_model.dart';
import 'package:smart_mosque/utils/validate_helper.dart';
import 'package:smart_mosque/view/components/custom_form.dart';
import 'package:smart_mosque/view/components/custom_outline_button.dart';
import 'package:smart_mosque/view/components/error_component.dart';
import 'package:smart_mosque/view/components/loading_com.dart';

class ProfilJamaah extends StatefulWidget{
  final TabController tab;
  const ProfilJamaah({Key? key, required this.tab}) : super (key: key);

  @override
  _ProfilJamaahState createState() => _ProfilJamaahState();
}

class _ProfilJamaahState extends State<ProfilJamaah>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<ProfilJamaahCubit>()..init(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profil'),
          elevation: 0,
        ),
        body: BlocConsumer<ProfilJamaahCubit, ProfilJamaahState>(
          listener: (context, state){
            if(state is ProfilJamaahUpdating){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is ProfilJamaahUpdated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil merubah profil');
            }else if (state is ProfilJamaahError){
              EasyLoading.dismiss();
              EasyLoading.showError(state.message!);
            }
          },
          builder: (context, state){
            if(state is ProfilJamaahFailure){
              return ErrorComponent(onPressed: context.read<ProfilJamaahCubit>().init,message: state.message,);
            }else if(state is ProfilJamaahLoading){
              return LoadingComp();
            }
            return ProfilJamaahBody(model: context.select((ProfilJamaahCubit bloc) => bloc.profilJamaahModel),);
          },
        ),
      ),
    );
  }
}

class ProfilJamaahBody extends StatefulWidget{
  final ProfilJamaahModel model;
  const ProfilJamaahBody({Key? key, required this.model}) : super (key: key);

  @override
  _ProfilJamaahBodyState createState() => _ProfilJamaahBodyState();
}

class _ProfilJamaahBodyState extends State<ProfilJamaahBody>{
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
                Text('${widget.model.results?.nama}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                Text('${widget.model.results?.email}', style: TextStyle(color: Colors.white),),
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
                        leading: Icon(Icons.phone_android),
                        title: Text('No Hp'),
                        subtitle: Text('${widget.model.results?.jamaah?.noHp}'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.home),
                        title: Text('Alamat'),
                        subtitle: Text('${widget.model.results?.jamaah?.alamat}'),
                      ),
                    ],
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: kSecondaryColor,
                  child: ListTile(
                    leading: CircleAvatar(radius:20,child: Icon(Icons.edit,color: kSecondaryColor,),backgroundColor: Colors.white,),
                    title: Text('Ubah Data',style: TextStyle(color: Colors.white),),
                    onTap: (){
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20)),
                          backgroundColor: Colors.white,
                          isScrollControlled: true,
                          context: context,
                          builder: (context){
                            return SheetProfil(model: widget.model,c: context,);
                          }
                      ).then((value){
                        if(value!=null){
                          context.read<ProfilJamaahCubit>().update(value);
                        }
                      });
                    },
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: Colors.red,
                  child: ListTile(
                    onTap: (){
                      context.read<AuthenticationCubit>().logout();
                    },
                    leading: CircleAvatar(radius: 20, backgroundColor: Colors.white, child: Icon(Icons.logout, color: Colors.red,),),
                    title: Text('Logout', style: TextStyle(color: Colors.white),),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SheetProfil extends StatefulWidget{
  final ProfilJamaahModel model;
  final BuildContext c;
  const SheetProfil({Key? key, required this.model, required this.c}) : super (key: key);

  @override
  _SheetProfilState createState() => _SheetProfilState();
}

class _SheetProfilState extends State<SheetProfil>{
  TextEditingController? nama = TextEditingController();
  TextEditingController? email = TextEditingController();
  TextEditingController? no_hp = TextEditingController();
  TextEditingController? alamat = TextEditingController();
  GlobalKey<FormState> _form = GlobalKey();
  @override
  void initState() {
    super.initState();
    nama?.text = widget.model.results?.nama??'';
    email?.text = widget.model.results?.email??'';
    no_hp?.text = widget.model.results?.jamaah?.noHp??'';
    alamat?.text = widget.model.results?.jamaah?.alamat??'';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            CustomForm(
              label: 'Nama',
              child:  TextFormField(
                controller: nama,
                validator: (value) =>
                    validateForm(value.toString(), label: 'Nama'),
                decoration:InputDecoration(
                  hintText: 'Masukkan Nama',

                ),
              ),
            ),
            CustomForm(
              label: 'Email',
              child:  TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: email,
                validator: (value) =>
                    validateForm(value.toString(), label: 'Email'),
                decoration:InputDecoration(
                  hintText: 'Masukkan email',

                ),
              ),
            ),
            CustomForm(
              label: 'No HP',
              child:  TextFormField(
                controller: no_hp,
                validator: (value) =>
                    validateForm(value.toString(), label: 'No HP'),
                decoration:InputDecoration(
                  hintText: 'Masukkan no HP',
                ),
              ),
            ),
            CustomForm(
              label: 'Alamat',
              child:  TextFormField(
                controller: alamat,
                validator: (value) =>
                    validateForm(value.toString(), label: 'Alamat'),
                decoration:InputDecoration(
                  hintText: 'Masukkan alamat',
                ),
              ),
            ),
            CustomOutlineButton(label: 'Simpan',onPressed: (){
              if(_form.currentState!.validate()){
                Map data = {
                  "id": widget.model.results?.id,
                  "nama":nama?.text,
                  "email":email?.text,
                  "alamat":alamat?.text,
                  "no_hp":no_hp?.text
                };
                Navigator.pop(context,data);
              }
            },color: kPrimaryColor,),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom,)
          ],
        ),
      ),
    );
  }
}