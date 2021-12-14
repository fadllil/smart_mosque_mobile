import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_mosque/blocs/jamaah/masjid_jamaah/masjid_jamaah_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/config/router.gr.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/models/masjid_list_model.dart';
import 'package:smart_mosque/view/components/error_component.dart';
import 'package:smart_mosque/view/components/loading_com.dart';
import 'package:smart_mosque/view/components/no_data.dart';

class Semua extends StatefulWidget{
  const Semua({Key? key}) : super (key: key);

  @override
  _SemuaState createState() => _SemuaState();
}

class _SemuaState extends State<Semua>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<MasjidJamaahCubit>()..semua(),
      child: Scaffold(
        body: BlocBuilder<MasjidJamaahCubit, MasjidJamaahState>(
          builder: (context, state){
            if(state is MasjidJamaahFailure){
              return ErrorComponent(onPressed: (){
                context.read<MasjidJamaahCubit>().semua();
              }, message: state.message,);
            }else if (state is MasjidJamaahLoaded){
              return SemuaBody(model: context.select((MasjidJamaahCubit cubit) => cubit.model));
            }
            return LoadingComp();
          },
        ),
      ),
    );
  }
}

class SemuaBody extends StatefulWidget{
  final MasjidListModel? model;
  const SemuaBody({Key? key, required this.model}) : super (key: key);

  @override
  _SemuaBodyState createState() => _SemuaBodyState();
}

class _SemuaBodyState extends State<SemuaBody>{
  ScrollController _scrollController = ScrollController();
  GlobalKey<RefreshIndicatorState> _refresh = GlobalKey();
  TextEditingController cari = TextEditingController();
  late List<Result> data;

  @override
  initState(){
    super.initState();
    data = widget.model?.results??[];
}

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
            key: _refresh,
            onRefresh: ()=> context.read<MasjidJamaahCubit>().semua(),
            child: SingleChildScrollView(
              controller: _scrollController..addListener(() {

              }),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextFormField(
                      controller: cari,
                      onChanged: (value){
                        data = widget.model?.results??[];
                        data = data.where((element) => element.nama?.toLowerCase().contains(cari.text)??false).toList();
                        setState(() {

                        });
                      },
                      decoration:  InputDecoration(
                          hintText: 'Cari Masjid',
                          suffixIcon: IconButton(onPressed: (){
                            FocusScope.of(context).unfocus();
                            data = widget.model?.results??[];
                            data = data.where((element) => element.nama?.toLowerCase().contains(cari.text)??false).toList();
                            setState(() {

                            });
                          }, icon: const Icon(Icons.search))
                      ),
                    ),
                    (data.isEmpty)?NoData(message: 'Data belum ada') : ListView.builder(
                      itemCount: data.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        return Column(
                          children: [
                            ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data[index].nama??''),
                                  Divider(color: Colors.black,),
                                  Text(data[index].alamat??'', style: TextStyle(fontSize: 14),),
                                ],
                              ),
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundColor: bluePrimary,
                                child: Icon(Icons.home, color: Colors.white,),
                              ),
                              onTap: (){
                                int? id = data[index].id;
                                AutoRouter.of(context).push(HomeDetailMasjidRoute(id: id));
                              },
                            ),
                            Divider(),
                          ],
                        );},
                    ),
                  ],
                ),
              ),
            )
        )
    );
  }
}