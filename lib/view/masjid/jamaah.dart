import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_mosque/blocs/masjid/jamaah/jamaah_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/models/jamaah_list_model.dart';
import 'package:smart_mosque/view/components/error_component.dart';
import 'package:smart_mosque/view/components/loading_com.dart';
import 'package:smart_mosque/view/components/no_data.dart';

class Jamaah extends StatefulWidget{
  const Jamaah({Key? key}) : super (key: key);

  @override
  _JamaahState createState() => _JamaahState();
}

class _JamaahState extends State<Jamaah>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<JamaahCubit>()..init(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Jamaah'),
        ),
        body: BlocBuilder<JamaahCubit, JamaahState>(
          builder: (context, state){
            if(state is JamaahFailure){
              return ErrorComponent(onPressed: (){
                context.read<JamaahCubit>().init();
              }, message: state.message,);
            }else if (state is JamaahLoaded){
              return JamaahBody(model: context.select((JamaahCubit cubit) => cubit.model),);
            }
            return LoadingComp();
          },
        ),
      ),
    );
  }
}

class JamaahBody extends StatefulWidget{
  final JamaahListModel? model;
  const JamaahBody({Key? key, required this.model}) : super (key: key);

  @override
  _JamaahBodyState createState() => _JamaahBodyState();
}

class _JamaahBodyState extends State<JamaahBody>{
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
        onRefresh: ()=>context.read<JamaahCubit>().init(),
        child: (widget.model?.results?.isEmpty??true)?NoData(message: 'Data belum ada') : SingleChildScrollView(
          controller: _scrollController..addListener(() {

          }),
          child: Container(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: widget.model?.results?.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index)=>Column(
                children: [
                  ListTile(
                    title: Text(widget.model?.results?[index].user?.nama??''),
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: bluePrimary,
                      child: Icon(Icons.person, color: Colors.white,),
                    ),
                    trailing: Text('${widget.model?.results?[index].jamaah!.alamat}'),
                  ),
                  Divider()
                ],
              ) ,
            ),
          ),
        ),
      ),
    );
  }
}