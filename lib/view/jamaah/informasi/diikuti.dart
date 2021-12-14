import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_mosque/blocs/jamaah/informasi_jamaah/informasi_jamaah_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/models/informasi_jamaah_model.dart';
import 'package:smart_mosque/utils/string_helper.dart';
import 'package:smart_mosque/view/components/error_component.dart';
import 'package:smart_mosque/view/components/loading_com.dart';
import 'package:smart_mosque/view/components/no_data.dart';

class Diikuti extends StatefulWidget{
  const Diikuti({Key? key}) : super (key: key);

  @override
  _DiikutiState createState() => _DiikutiState();
}

class _DiikutiState extends State<Diikuti>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<InformasiJamaahCubit>()..diikuti(),
      child: Scaffold(
        body: BlocBuilder<InformasiJamaahCubit, InformasiJamaahState>(
          builder: (context, state){
            if(state is InformasiJamaahFailure){
              return ErrorComponent(onPressed: (){
                context.read<InformasiJamaahCubit>().diikuti();
              }, message: state.message,);
            }else if (state is InformasiJamaahLoaded){
              return DiikutiBody(model: context.select((InformasiJamaahCubit cubit) => cubit.model));
            }
            return LoadingComp();
          },
        ),
      ),
    );
  }
}

class DiikutiBody extends StatefulWidget{
  final InformasiJamaahModel? model;
  const DiikutiBody({Key? key, required this.model}) : super (key: key);

  @override
  _DiikutiBodyState createState() => _DiikutiBodyState();
}

class _DiikutiBodyState extends State<DiikutiBody>{
  ScrollController _scrollController = ScrollController();
  GlobalKey<RefreshIndicatorState> _refresh = GlobalKey();
  TextEditingController cari = TextEditingController();
  late List<Result> data;
  @override
  void initState() {
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
          onRefresh: ()=>context.read<InformasiJamaahCubit>().semua(),
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
                        hintText: 'Cari Informasi',
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
                      itemBuilder: (context, index) {
                        DateTime? tgl = data[index].tanggal;
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
                                                Text(data[index]
                                                    .nama ?? '',
                                                  style: TextStyle(fontSize: 18),),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('${convertDateTime(tgl!)}'),
                                                    Text(data[index].waktu ?? ''),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Divider(),
                                            Text(data[index].judul ?? ''),
                                            Divider(),
                                            Text(data[index].isi ?? ''),
                                            Divider(),
                                            Text(data[index].keterangan ?? ''),

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
                ],
              ),
            ),
          )
      ),
    );
  }
}