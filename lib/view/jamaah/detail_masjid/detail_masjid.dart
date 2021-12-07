import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_mosque/blocs/jamaah/detail_masjid/detail_masjid_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/models/detail_masjid_model.dart';
import 'package:smart_mosque/view/components/error_component.dart';
import 'package:smart_mosque/view/components/loading_com.dart';
import 'package:smart_mosque/view/masjid/jadwal_imam/detail_jadwal.dart';

class DetailMasjid extends StatefulWidget{
  final int? id;
  final TabController tab;
  const DetailMasjid({Key? key, required this.id, required this.tab}) : super (key: key);

  @override
  _DetailMasjidState createState() => _DetailMasjidState();
}

class _DetailMasjidState extends State<DetailMasjid>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<DetailMasjidCubit>()..init(widget.id!),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profil'),
          elevation: 0,
        ),
        body: BlocConsumer<DetailMasjidCubit, DetailMasjidState>(
          listener: (context, state){
            if(state is DetailMasjidCreating){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is DetailMasjidCreated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil mengikuti');
            }else if (state is DetailMasjidError){
              EasyLoading.dismiss();
              EasyLoading.showError(state.message!);
            }
          },
          builder: (context, state){
            if(state is DetailMasjidFailure){
              return ErrorComponent(onPressed: (){
              context.read<DetailMasjidCubit>().init(widget.id!);
              }, message: state.message,);
            }else if(state is DetailMasjidLoading){
              return LoadingComp();
            }
            return DetailMasjidBody(model: context.select((DetailMasjidCubit bloc) => bloc.model), id: widget.id,);
          },
        ),
      ),
    );
  }
}

class DetailMasjidBody extends StatefulWidget{
  final int? id;
  final DetailMasjidModel? model;
  const DetailMasjidBody({Key? key, required this.id, required this.model}) : super (key: key);

  @override
  _DetailMasjidBodyState createState() => _DetailMasjidBodyState();
}

class _DetailMasjidBodyState extends State<DetailMasjidBody>{
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
                (widget.model?.results?.follow ?? true) ? SizedBox() :
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: Colors.red,
                  child: ListTile(
                    onTap: (){
                      Map data = {
                        'id_masjid' : widget.id
                      };
                      context.read<DetailMasjidCubit>().ikuti(data);
                    },
                    leading: CircleAvatar(radius: 20, backgroundColor: Colors.white, child: Icon(Icons.add, color: Colors.red,),),
                    title: Text('Ikuti', style: TextStyle(color: Colors.white),),
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