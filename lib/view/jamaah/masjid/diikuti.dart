import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_mosque/blocs/jamaah/masjid_jamaah/masjid_jamaah_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/models/masjid_list_model.dart';
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
      create: (_) => locator<MasjidJamaahCubit>()..diikuti(),
      child: Scaffold(
        body: BlocBuilder<MasjidJamaahCubit, MasjidJamaahState>(
          builder: (context, state){
            if(state is MasjidJamaahFailure){
              return ErrorComponent(onPressed: (){
                context.read<MasjidJamaahCubit>().diikuti();
              }, message: state.message,);
            }else if (state is MasjidJamaahLoaded){
              return DiikutiBody(model: context.select((MasjidJamaahCubit cubit) => cubit.model));
            }
            return LoadingComp();
          },
        ),
      ),
    );
  }
}

class DiikutiBody extends StatefulWidget{
  final MasjidListModel? model;
  const DiikutiBody({Key? key, required this.model}) : super (key: key);

  @override
  _DiikutiBodyState createState() => _DiikutiBodyState();
}

class _DiikutiBodyState extends State<DiikutiBody>{
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
        body: RefreshIndicator(
            key: _refresh,
            onRefresh: ()=> context.read<MasjidJamaahCubit>().diikuti(),
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
                    return Column(
                      children: [
                        ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.model?.results?[index].nama??''),
                              Divider(color: Colors.black,),
                              Text(widget.model?.results?[index].alamat??'', style: TextStyle(fontSize: 14),),
                            ],
                          ),
                          leading: CircleAvatar(
                            radius: 20,
                            backgroundColor: bluePrimary,
                            child: Icon(Icons.home, color: Colors.white,),
                          ),
                        ),
                        Divider(),
                      ],
                    );},
                ),
              ),
            )
        )
    );
  }
}