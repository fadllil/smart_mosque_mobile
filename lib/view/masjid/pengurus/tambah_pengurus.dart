import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_mosque/blocs/masjid/tambah-pengurus/tambah_pengurus_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/config/router.gr.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/view/components/custom_form.dart';
import 'package:smart_mosque/view/components/custom_outline_button.dart';
import 'package:smart_mosque/view/components/error_component.dart';
import 'package:smart_mosque/view/components/loading_com.dart';

class TambahPengurus extends StatelessWidget {
  const TambahPengurus({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<TambahPengurusCubit>()..init(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tambah Pengurus'),
        ),
        body: BlocConsumer<TambahPengurusCubit, TambahPengurusState>(
          listener: (context, state){
            if(state is TambahPengurusCreating){
              EasyLoading.show(status: 'Loading', dismissOnTap: false, maskType: EasyLoadingMaskType.black);
            }else if (state is TambahPengurusCreated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil menambah data pengurus');
              AutoRouter.of(context).popAndPush(PengurusRoute());
            }else if(state is TambahPengurusError){
              EasyLoading.dismiss();
              EasyLoading.showError(state.message);
            }
          },
          builder: (context, state){
            if(state is TambahPengurusLoading){
              return LoadingComp();
            }else if(state is TambahPengurusFailure){
              return ErrorComponent(onPressed: (){
                context.read<TambahPengurusCubit>()..init();
              });
            }
            return TambahPengurusBody();
          },
        ),
      ),
    );
  }


}

class TambahPengurusBody extends StatefulWidget{
  const TambahPengurusBody({Key? key}) : super (key: key);

  @override
  _TambahPengurusBodyState createState() => _TambahPengurusBodyState();
}

class _TambahPengurusBodyState extends State<TambahPengurusBody>{
  GlobalKey<FormState> _form = GlobalKey();
  TextEditingController nama = TextEditingController();
  TextEditingController jabatan = TextEditingController();
  TextEditingController alamat = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomForm(
                  label: 'Nama',
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    controller: nama,
                    decoration: InputDecoration(
                      hintText: "Masukkan Nama"
                    ),
                  )
              ),
              CustomForm(
                  label: 'Jabatan',
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    controller: jabatan,
                    decoration: InputDecoration(
                      hintText: "Masukkan Jabatan"
                    ),
                  )
              ),
              CustomForm(
                  label: "Alamat",
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    controller: alamat,
                    decoration: InputDecoration(
                        hintText: "Masukkan Alamat"
                    ),
                  )
              ),
              CustomOutlineButton(
                  label: "Tambah",
                  onPressed: (){
                    FocusScope.of(context).unfocus();
                    if(_form.currentState!.validate()){
                      Map data = {
                        'nama' : nama.text,
                        'jabatan' : jabatan.text,
                        'alamat' : alamat.text
                      };
                      context.read<TambahPengurusCubit>().postPengurus(data);
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