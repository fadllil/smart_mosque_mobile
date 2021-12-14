import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_mosque/blocs/masjid/dashboard/dashboard_masjid_cubit.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/config/router.gr.dart';
import 'package:smart_mosque/constants/themes.dart';
import 'package:smart_mosque/models/jamaah_list_model.dart';
import 'package:smart_mosque/utils/string_helper.dart';
import 'package:smart_mosque/view/components/error_component.dart';
import 'package:smart_mosque/view/components/heading_title.dart';
import 'package:smart_mosque/view/components/loading_com.dart';

class DashboardMasjid extends StatefulWidget{
  final TabController tab;
  const DashboardMasjid({Key? key, required this.tab}) : super (key: key);
  
  @override
  _DashboardMasjidState createState() => _DashboardMasjidState();
}

class _DashboardMasjidState extends State<DashboardMasjid>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<DashboardMasjidCubit>()..init(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Smart Masque'),
        ),
        body: BlocBuilder<DashboardMasjidCubit, DashboardMasjidState>(
          builder: (context, state){
            if (state is DashboardMasjidFailure){
              return ErrorComponent(onPressed: context.read<DashboardMasjidCubit>().init,message: state.message!,);
            }else if (state is DashboardMasjidLoading){
              return LoadingComp();
            }
            return DashboardBody(tab: widget.tab, state: (state as DashboardMasjidLoaded), model: context.select((DashboardMasjidCubit cubit) => cubit.model),);
          },
        )
      ),
    );
  }
}

class DashboardBody extends StatefulWidget{
  final DashboardMasjidLoaded state;
  final TabController tab;
  final JamaahListModel? model;
  const DashboardBody({Key? key, required this.state, required this.tab, required this.model}) : super(key: key);
  
  @override
  _DashboardBodyState createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody>{
  GlobalKey<RefreshIndicatorState> _refresh = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refresh,
      onRefresh: ()=>context.read<DashboardMasjidCubit>().init(),
      backgroundColor: kPrimaryColor,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${timeToGreet()}\n${widget.state.nama}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: kTextBlack),
                  ),
                  CircleAvatar(
                    backgroundColor: blueSecondary,
                    radius: 20,
                    child: IconButton(icon: Icon(Icons.person,color: Colors.white,),
                      onPressed: ()
                      {

                      },
                    ),
                  )
                ],
              ),
              Divider(),
              SizedBox(
                height: 20,
              ),

              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          AutoRouter.of(context).push(PengurusRoute());
                        },
                        child: DashboardCard(
                          title: 'Pengurus',
                          icon: Icons.supervised_user_circle,
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          AutoRouter.of(context).push(JamaahRoute());
                        },
                        child: DashboardCard(
                          title: 'Jamaah',
                          icon: Icons.people,
                        ),
                      ),

                      InkWell(
                        onTap: (){
                          AutoRouter.of(context).push(JadwalImamRoute());
                        },
                        child: DashboardCard(
                          title: 'Jadwal Imam',
                          icon: Icons.verified_user,
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          AutoRouter.of(context).push(KegiatanRoute());
                        },
                        child: DashboardCard(
                          title: 'Kegiatan',
                          icon: Icons.verified_user,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          AutoRouter.of(context).push(DetailRoute());
                        },
                        child: DashboardCard(
                          title: 'Detail Masjid',
                          icon: Icons.verified_user,
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          AutoRouter.of(context).push(InformasiRoute());
                        },
                        child: DashboardCard(
                          title: 'Informasi',
                          icon: Icons.verified_user,
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          AutoRouter.of(context).push(InventarisRoute());
                        },
                        child: DashboardCard(
                          title: 'Inventaris',
                          icon: Icons.verified_user,
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          AutoRouter.of(context).push(KeuanganIndexRoute());
                        },
                        child: DashboardCard(
                          title: 'Keuangan',
                          icon: Icons.verified_user,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              HeadingTitle(
                title: 'Jamaah',
                onTap: () {
                  print('oce');
                },
              ),
              ListView.builder(
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
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  const DashboardCard({
    Key? key, required this.icon, required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: blueSecondary, borderRadius: BorderRadius.circular(10)),
      // width: MediaQuery.of(context).size.width / 2.2,
      width: 80,
      child: Column(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Icon(icon,color: blueSecondary),
          ),
          SizedBox(height: 10,),
          Column(
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
