// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i22;
import 'package:flutter/material.dart' as _i23;

import '../view/components/option_with_search.dart' as _i21;
import '../view/jamaah/detail_masjid/detail_jadwal_imam.dart' as _i17;
import '../view/jamaah/detail_masjid/home_detail_masjid.dart' as _i16;
import '../view/jamaah/home_jamaah.dart' as _i15;
import '../view/login.dart' as _i2;
import '../view/masjid/detail/detail.dart' as _i18;
import '../view/masjid/home_masjid.dart' as _i3;
import '../view/masjid/informasi/informasi.dart' as _i12;
import '../view/masjid/inventaris/inventaris.dart' as _i13;
import '../view/masjid/jadwal_imam/detail_jadwal.dart' as _i8;
import '../view/masjid/jadwal_imam/jadwal_imam.dart' as _i7;
import '../view/masjid/jamaah.dart' as _i4;
import '../view/masjid/kegiatan/detail/anggota.dart' as _i19;
import '../view/masjid/kegiatan/detail/iuran.dart' as _i20;
import '../view/masjid/kegiatan/kegiatan.dart' as _i9;
import '../view/masjid/kegiatan/tambah_kegiatan.dart' as _i10;
import '../view/masjid/keuangan/keuangan_index.dart' as _i14;
import '../view/masjid/keuangan/tambah_pemasukan.dart' as _i11;
import '../view/masjid/pengurus/pengurus.dart' as _i5;
import '../view/masjid/pengurus/tambah_pengurus.dart' as _i6;
import '../view/splash_screen.dart' as _i1;

class AppRouter extends _i22.RootStackRouter {
  AppRouter([_i23.GlobalKey<_i23.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i22.PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SplashScreen());
    },
    LoginRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.Login());
    },
    HomeMasjidRoute.name: (routeData) {
      final args = routeData.argsAs<HomeMasjidRouteArgs>(
          orElse: () => const HomeMasjidRouteArgs());
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.HomeMasjid(key: args.key, index: args.index));
    },
    JamaahRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.Jamaah());
    },
    PengurusRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.Pengurus());
    },
    TambahPengurusRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.TambahPengurus());
    },
    JadwalImamRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.JadwalImam());
    },
    DetailImamRoute.name: (routeData) {
      final args = routeData.argsAs<DetailImamRouteArgs>();
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i8.DetailImam(key: args.key, id: args.id, hari: args.hari));
    },
    KegiatanRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.Kegiatan());
    },
    TambahKegiatanRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.TambahKegiatan());
    },
    TambahPemasukanRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.TambahPemasukan());
    },
    InformasiRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i12.Informasi());
    },
    InventarisRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i13.Inventaris());
    },
    KeuanganIndexRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i14.KeuanganIndex());
    },
    HomeJamaahRoute.name: (routeData) {
      final args = routeData.argsAs<HomeJamaahRouteArgs>(
          orElse: () => const HomeJamaahRouteArgs());
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i15.HomeJamaah(key: args.key, index: args.index));
    },
    HomeDetailMasjidRoute.name: (routeData) {
      final args = routeData.argsAs<HomeDetailMasjidRouteArgs>();
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i16.HomeDetailMasjid(
              key: args.key, id: args.id, index: args.index));
    },
    DetailJadwalImamRoute.name: (routeData) {
      final args = routeData.argsAs<DetailJadwalImamRouteArgs>();
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i17.DetailJadwalImam(
              key: args.key, id: args.id, hari: args.hari));
    },
    DetailRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i18.Detail());
    },
    AnggotaRoute.name: (routeData) {
      final args = routeData.argsAs<AnggotaRouteArgs>();
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i19.Anggota(key: args.key, id: args.id));
    },
    IuranRoute.name: (routeData) {
      final args = routeData.argsAs<IuranRouteArgs>();
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData, child: _i20.Iuran(key: args.key, id: args.id));
    },
    CustomOptionWithSearchRoute.name: (routeData) {
      final args = routeData.argsAs<CustomOptionWithSearchRouteArgs>();
      return _i22.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i21.CustomOptionWithSearch(
              key: args.key, options: args.options, title: args.title));
    }
  };

  @override
  List<_i22.RouteConfig> get routes => [
        _i22.RouteConfig(SplashScreenRoute.name, path: '/'),
        _i22.RouteConfig(LoginRoute.name, path: '/login'),
        _i22.RouteConfig(HomeMasjidRoute.name, path: '/home_masjid'),
        _i22.RouteConfig(JamaahRoute.name, path: '/jamaah'),
        _i22.RouteConfig(PengurusRoute.name, path: '/pengurus'),
        _i22.RouteConfig(TambahPengurusRoute.name, path: '/tambah_pengurus'),
        _i22.RouteConfig(JadwalImamRoute.name, path: '/jadwal_imam'),
        _i22.RouteConfig(DetailImamRoute.name, path: '/detail_imam'),
        _i22.RouteConfig(KegiatanRoute.name, path: '/kegiatan'),
        _i22.RouteConfig(TambahKegiatanRoute.name, path: '/tambah_kegiatan'),
        _i22.RouteConfig(TambahPemasukanRoute.name, path: '/tambah_pemasukan'),
        _i22.RouteConfig(InformasiRoute.name, path: '/informasi'),
        _i22.RouteConfig(InventarisRoute.name, path: '/inventaris'),
        _i22.RouteConfig(KeuanganIndexRoute.name, path: '/keuangan_index'),
        _i22.RouteConfig(HomeJamaahRoute.name, path: '/home_jamaah'),
        _i22.RouteConfig(HomeDetailMasjidRoute.name,
            path: '/home_detail_masjid'),
        _i22.RouteConfig(DetailJadwalImamRoute.name,
            path: '/detail_jadwal_imam'),
        _i22.RouteConfig(DetailRoute.name, path: '/detail'),
        _i22.RouteConfig(AnggotaRoute.name, path: '/anggota'),
        _i22.RouteConfig(IuranRoute.name, path: '/iuran'),
        _i22.RouteConfig(CustomOptionWithSearchRoute.name,
            path: '/custom-option')
      ];
}

/// generated route for [_i1.SplashScreen]
class SplashScreenRoute extends _i22.PageRouteInfo<void> {
  const SplashScreenRoute() : super(name, path: '/');

  static const String name = 'SplashScreenRoute';
}

/// generated route for [_i2.Login]
class LoginRoute extends _i22.PageRouteInfo<void> {
  const LoginRoute() : super(name, path: '/login');

  static const String name = 'LoginRoute';
}

/// generated route for [_i3.HomeMasjid]
class HomeMasjidRoute extends _i22.PageRouteInfo<HomeMasjidRouteArgs> {
  HomeMasjidRoute({_i23.Key? key, int? index = 0})
      : super(name,
            path: '/home_masjid',
            args: HomeMasjidRouteArgs(key: key, index: index));

  static const String name = 'HomeMasjidRoute';
}

class HomeMasjidRouteArgs {
  const HomeMasjidRouteArgs({this.key, this.index = 0});

  final _i23.Key? key;

  final int? index;
}

/// generated route for [_i4.Jamaah]
class JamaahRoute extends _i22.PageRouteInfo<void> {
  const JamaahRoute() : super(name, path: '/jamaah');

  static const String name = 'JamaahRoute';
}

/// generated route for [_i5.Pengurus]
class PengurusRoute extends _i22.PageRouteInfo<void> {
  const PengurusRoute() : super(name, path: '/pengurus');

  static const String name = 'PengurusRoute';
}

/// generated route for [_i6.TambahPengurus]
class TambahPengurusRoute extends _i22.PageRouteInfo<void> {
  const TambahPengurusRoute() : super(name, path: '/tambah_pengurus');

  static const String name = 'TambahPengurusRoute';
}

/// generated route for [_i7.JadwalImam]
class JadwalImamRoute extends _i22.PageRouteInfo<void> {
  const JadwalImamRoute() : super(name, path: '/jadwal_imam');

  static const String name = 'JadwalImamRoute';
}

/// generated route for [_i8.DetailImam]
class DetailImamRoute extends _i22.PageRouteInfo<DetailImamRouteArgs> {
  DetailImamRoute({_i23.Key? key, required int? id, required String? hari})
      : super(name,
            path: '/detail_imam',
            args: DetailImamRouteArgs(key: key, id: id, hari: hari));

  static const String name = 'DetailImamRoute';
}

class DetailImamRouteArgs {
  const DetailImamRouteArgs({this.key, required this.id, required this.hari});

  final _i23.Key? key;

  final int? id;

  final String? hari;
}

/// generated route for [_i9.Kegiatan]
class KegiatanRoute extends _i22.PageRouteInfo<void> {
  const KegiatanRoute() : super(name, path: '/kegiatan');

  static const String name = 'KegiatanRoute';
}

/// generated route for [_i10.TambahKegiatan]
class TambahKegiatanRoute extends _i22.PageRouteInfo<void> {
  const TambahKegiatanRoute() : super(name, path: '/tambah_kegiatan');

  static const String name = 'TambahKegiatanRoute';
}

/// generated route for [_i11.TambahPemasukan]
class TambahPemasukanRoute extends _i22.PageRouteInfo<void> {
  const TambahPemasukanRoute() : super(name, path: '/tambah_pemasukan');

  static const String name = 'TambahPemasukanRoute';
}

/// generated route for [_i12.Informasi]
class InformasiRoute extends _i22.PageRouteInfo<void> {
  const InformasiRoute() : super(name, path: '/informasi');

  static const String name = 'InformasiRoute';
}

/// generated route for [_i13.Inventaris]
class InventarisRoute extends _i22.PageRouteInfo<void> {
  const InventarisRoute() : super(name, path: '/inventaris');

  static const String name = 'InventarisRoute';
}

/// generated route for [_i14.KeuanganIndex]
class KeuanganIndexRoute extends _i22.PageRouteInfo<void> {
  const KeuanganIndexRoute() : super(name, path: '/keuangan_index');

  static const String name = 'KeuanganIndexRoute';
}

/// generated route for [_i15.HomeJamaah]
class HomeJamaahRoute extends _i22.PageRouteInfo<HomeJamaahRouteArgs> {
  HomeJamaahRoute({_i23.Key? key, int? index = 0})
      : super(name,
            path: '/home_jamaah',
            args: HomeJamaahRouteArgs(key: key, index: index));

  static const String name = 'HomeJamaahRoute';
}

class HomeJamaahRouteArgs {
  const HomeJamaahRouteArgs({this.key, this.index = 0});

  final _i23.Key? key;

  final int? index;
}

/// generated route for [_i16.HomeDetailMasjid]
class HomeDetailMasjidRoute
    extends _i22.PageRouteInfo<HomeDetailMasjidRouteArgs> {
  HomeDetailMasjidRoute({_i23.Key? key, required int? id, int? index = 0})
      : super(name,
            path: '/home_detail_masjid',
            args: HomeDetailMasjidRouteArgs(key: key, id: id, index: index));

  static const String name = 'HomeDetailMasjidRoute';
}

class HomeDetailMasjidRouteArgs {
  const HomeDetailMasjidRouteArgs({this.key, required this.id, this.index = 0});

  final _i23.Key? key;

  final int? id;

  final int? index;
}

/// generated route for [_i17.DetailJadwalImam]
class DetailJadwalImamRoute
    extends _i22.PageRouteInfo<DetailJadwalImamRouteArgs> {
  DetailJadwalImamRoute(
      {_i23.Key? key, required int? id, required String? hari})
      : super(name,
            path: '/detail_jadwal_imam',
            args: DetailJadwalImamRouteArgs(key: key, id: id, hari: hari));

  static const String name = 'DetailJadwalImamRoute';
}

class DetailJadwalImamRouteArgs {
  const DetailJadwalImamRouteArgs(
      {this.key, required this.id, required this.hari});

  final _i23.Key? key;

  final int? id;

  final String? hari;
}

/// generated route for [_i18.Detail]
class DetailRoute extends _i22.PageRouteInfo<void> {
  const DetailRoute() : super(name, path: '/detail');

  static const String name = 'DetailRoute';
}

/// generated route for [_i19.Anggota]
class AnggotaRoute extends _i22.PageRouteInfo<AnggotaRouteArgs> {
  AnggotaRoute({_i23.Key? key, required int id})
      : super(name, path: '/anggota', args: AnggotaRouteArgs(key: key, id: id));

  static const String name = 'AnggotaRoute';
}

class AnggotaRouteArgs {
  const AnggotaRouteArgs({this.key, required this.id});

  final _i23.Key? key;

  final int id;
}

/// generated route for [_i20.Iuran]
class IuranRoute extends _i22.PageRouteInfo<IuranRouteArgs> {
  IuranRoute({_i23.Key? key, required int id})
      : super(name, path: '/iuran', args: IuranRouteArgs(key: key, id: id));

  static const String name = 'IuranRoute';
}

class IuranRouteArgs {
  const IuranRouteArgs({this.key, required this.id});

  final _i23.Key? key;

  final int id;
}

/// generated route for [_i21.CustomOptionWithSearch]
class CustomOptionWithSearchRoute
    extends _i22.PageRouteInfo<CustomOptionWithSearchRouteArgs> {
  CustomOptionWithSearchRoute(
      {_i23.Key? key, required List<dynamic> options, required String title})
      : super(name,
            path: '/custom-option',
            args: CustomOptionWithSearchRouteArgs(
                key: key, options: options, title: title));

  static const String name = 'CustomOptionWithSearchRoute';
}

class CustomOptionWithSearchRouteArgs {
  const CustomOptionWithSearchRouteArgs(
      {this.key, required this.options, required this.title});

  final _i23.Key? key;

  final List<dynamic> options;

  final String title;
}
