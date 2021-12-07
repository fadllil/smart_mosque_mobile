import 'package:auto_route/auto_route.dart';
import 'package:smart_mosque/view/jamaah/detail_masjid/detail_jadwal_imam.dart';
import 'package:smart_mosque/view/jamaah/detail_masjid/home_detail_masjid.dart';
import 'package:smart_mosque/view/jamaah/home_jamaah.dart';
import 'package:smart_mosque/view/login.dart';
import 'package:smart_mosque/view/masjid/detail/detail.dart';
import 'package:smart_mosque/view/masjid/home_masjid.dart';
import 'package:smart_mosque/view/masjid/informasi/informasi.dart';
import 'package:smart_mosque/view/masjid/inventaris/inventaris.dart';
import 'package:smart_mosque/view/masjid/jadwal_imam/detail_jadwal.dart';
import 'package:smart_mosque/view/masjid/jadwal_imam/jadwal_imam.dart';
import 'package:smart_mosque/view/masjid/jamaah.dart';
import 'package:smart_mosque/view/masjid/kegiatan/kegiatan.dart';
import 'package:smart_mosque/view/masjid/keuangan/keuangan_index.dart';
import 'package:smart_mosque/view/masjid/pengurus/tambah_pengurus.dart';
import '../view/masjid/pengurus/pengurus.dart';
import 'package:smart_mosque/view/splash_screen.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: SplashScreen, initial: true, path: '/'),
    AutoRoute(page: Login, path: '/login'),
    AutoRoute(page: HomeMasjid, path: '/home_masjid'),
    AutoRoute(page: Jamaah, path: '/jamaah'),
    AutoRoute(page: Pengurus, path: '/pengurus'),
    AutoRoute(page: TambahPengurus, path: '/tambah_pengurus'),
    AutoRoute(page: JadwalImam, path: '/jadwal_imam'),
    AutoRoute(page: DetailImam, path: '/detail_imam'),
    AutoRoute(page: Kegiatan, path: '/kegiatan'),
    AutoRoute(page: Informasi, path: '/informasi'),
    AutoRoute(page: Inventaris, path: '/inventaris'),
    AutoRoute(page: KeuanganIndex, path: '/keuangan_index'),
    AutoRoute(page: HomeJamaah, path: '/home_jamaah'),
    AutoRoute(page: HomeDetailMasjid, path: '/home_detail_masjid'),
    AutoRoute(page: DetailJadwalImam, path: '/detail_jadwal_imam'),
    AutoRoute(page: Detail, path: '/detail'),
  ],
)
class $AppRouter {}