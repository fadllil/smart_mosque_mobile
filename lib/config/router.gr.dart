// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i17;
import 'package:flutter/material.dart' as _i18;

import '../view/jamaah/detail_masjid/detail_jadwal_imam.dart' as _i15;
import '../view/jamaah/detail_masjid/home_detail_masjid.dart' as _i14;
import '../view/jamaah/home_jamaah.dart' as _i13;
import '../view/login.dart' as _i2;
import '../view/masjid/detail/detail.dart' as _i16;
import '../view/masjid/home_masjid.dart' as _i3;
import '../view/masjid/informasi/informasi.dart' as _i10;
import '../view/masjid/inventaris/inventaris.dart' as _i11;
import '../view/masjid/jadwal_imam/detail_jadwal.dart' as _i8;
import '../view/masjid/jadwal_imam/jadwal_imam.dart' as _i7;
import '../view/masjid/jamaah.dart' as _i4;
import '../view/masjid/kegiatan/kegiatan.dart' as _i9;
import '../view/masjid/keuangan/keuangan_index.dart' as _i12;
import '../view/masjid/pengurus/pengurus.dart' as _i5;
import '../view/masjid/pengurus/tambah_pengurus.dart' as _i6;
import '../view/splash_screen.dart' as _i1;

class AppRouter extends _i17.RootStackRouter {
  AppRouter([_i18.GlobalKey<_i18.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i17.PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SplashScreen());
    },
    LoginRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.Login());
    },
    HomeMasjidRoute.name: (routeData) {
      final args = routeData.argsAs<HomeMasjidRouteArgs>(
          orElse: () => const HomeMasjidRouteArgs());
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.HomeMasjid(key: args.key, index: args.index));
    },
    JamaahRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.Jamaah());
    },
    PengurusRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.Pengurus());
    },
    TambahPengurusRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.TambahPengurus());
    },
    JadwalImamRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.JadwalImam());
    },
    DetailImamRoute.name: (routeData) {
      final args = routeData.argsAs<DetailImamRouteArgs>();
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i8.DetailImam(key: args.key, id: args.id, hari: args.hari));
    },
    KegiatanRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.Kegiatan());
    },
    InformasiRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.Informasi());
    },
    InventarisRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.Inventaris());
    },
    KeuanganIndexRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i12.KeuanganIndex());
    },
    HomeJamaahRoute.name: (routeData) {
      final args = routeData.argsAs<HomeJamaahRouteArgs>(
          orElse: () => const HomeJamaahRouteArgs());
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i13.HomeJamaah(key: args.key, index: args.index));
    },
    HomeDetailMasjidRoute.name: (routeData) {
      final args = routeData.argsAs<HomeDetailMasjidRouteArgs>();
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i14.HomeDetailMasjid(
              key: args.key, id: args.id, index: args.index));
    },
    DetailJadwalImamRoute.name: (routeData) {
      final args = routeData.argsAs<DetailJadwalImamRouteArgs>();
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i15.DetailJadwalImam(
              key: args.key, id: args.id, hari: args.hari));
    },
    DetailRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i16.Detail());
    }
  };

  @override
  List<_i17.RouteConfig> get routes => [
        _i17.RouteConfig(SplashScreenRoute.name, path: '/'),
        _i17.RouteConfig(LoginRoute.name, path: '/login'),
        _i17.RouteConfig(HomeMasjidRoute.name, path: '/home_masjid'),
        _i17.RouteConfig(JamaahRoute.name, path: '/jamaah'),
        _i17.RouteConfig(PengurusRoute.name, path: '/pengurus'),
        _i17.RouteConfig(TambahPengurusRoute.name, path: '/tambah_pengurus'),
        _i17.RouteConfig(JadwalImamRoute.name, path: '/jadwal_imam'),
        _i17.RouteConfig(DetailImamRoute.name, path: '/detail_imam'),
        _i17.RouteConfig(KegiatanRoute.name, path: '/kegiatan'),
        _i17.RouteConfig(InformasiRoute.name, path: '/informasi'),
        _i17.RouteConfig(InventarisRoute.name, path: '/inventaris'),
        _i17.RouteConfig(KeuanganIndexRoute.name, path: '/keuangan_index'),
        _i17.RouteConfig(HomeJamaahRoute.name, path: '/home_jamaah'),
        _i17.RouteConfig(HomeDetailMasjidRoute.name,
            path: '/home_detail_masjid'),
        _i17.RouteConfig(DetailJadwalImamRoute.name,
            path: '/detail_jadwal_imam'),
        _i17.RouteConfig(DetailRoute.name, path: '/detail')
      ];
}

/// generated route for [_i1.SplashScreen]
class SplashScreenRoute extends _i17.PageRouteInfo<void> {
  const SplashScreenRoute() : super(name, path: '/');

  static const String name = 'SplashScreenRoute';
}

/// generated route for [_i2.Login]
class LoginRoute extends _i17.PageRouteInfo<void> {
  const LoginRoute() : super(name, path: '/login');

  static const String name = 'LoginRoute';
}

/// generated route for [_i3.HomeMasjid]
class HomeMasjidRoute extends _i17.PageRouteInfo<HomeMasjidRouteArgs> {
  HomeMasjidRoute({_i18.Key? key, int? index = 0})
      : super(name,
            path: '/home_masjid',
            args: HomeMasjidRouteArgs(key: key, index: index));

  static const String name = 'HomeMasjidRoute';
}

class HomeMasjidRouteArgs {
  const HomeMasjidRouteArgs({this.key, this.index = 0});

  final _i18.Key? key;

  final int? index;
}

/// generated route for [_i4.Jamaah]
class JamaahRoute extends _i17.PageRouteInfo<void> {
  const JamaahRoute() : super(name, path: '/jamaah');

  static const String name = 'JamaahRoute';
}

/// generated route for [_i5.Pengurus]
class PengurusRoute extends _i17.PageRouteInfo<void> {
  const PengurusRoute() : super(name, path: '/pengurus');

  static const String name = 'PengurusRoute';
}

/// generated route for [_i6.TambahPengurus]
class TambahPengurusRoute extends _i17.PageRouteInfo<void> {
  const TambahPengurusRoute() : super(name, path: '/tambah_pengurus');

  static const String name = 'TambahPengurusRoute';
}

/// generated route for [_i7.JadwalImam]
class JadwalImamRoute extends _i17.PageRouteInfo<void> {
  const JadwalImamRoute() : super(name, path: '/jadwal_imam');

  static const String name = 'JadwalImamRoute';
}

/// generated route for [_i8.DetailImam]
class DetailImamRoute extends _i17.PageRouteInfo<DetailImamRouteArgs> {
  DetailImamRoute({_i18.Key? key, required int? id, required String? hari})
      : super(name,
            path: '/detail_imam',
            args: DetailImamRouteArgs(key: key, id: id, hari: hari));

  static const String name = 'DetailImamRoute';
}

class DetailImamRouteArgs {
  const DetailImamRouteArgs({this.key, required this.id, required this.hari});

  final _i18.Key? key;

  final int? id;

  final String? hari;
}

/// generated route for [_i9.Kegiatan]
class KegiatanRoute extends _i17.PageRouteInfo<void> {
  const KegiatanRoute() : super(name, path: '/kegiatan');

  static const String name = 'KegiatanRoute';
}

/// generated route for [_i10.Informasi]
class InformasiRoute extends _i17.PageRouteInfo<void> {
  const InformasiRoute() : super(name, path: '/informasi');

  static const String name = 'InformasiRoute';
}

/// generated route for [_i11.Inventaris]
class InventarisRoute extends _i17.PageRouteInfo<void> {
  const InventarisRoute() : super(name, path: '/inventaris');

  static const String name = 'InventarisRoute';
}

/// generated route for [_i12.KeuanganIndex]
class KeuanganIndexRoute extends _i17.PageRouteInfo<void> {
  const KeuanganIndexRoute() : super(name, path: '/keuangan_index');

  static const String name = 'KeuanganIndexRoute';
}

/// generated route for [_i13.HomeJamaah]
class HomeJamaahRoute extends _i17.PageRouteInfo<HomeJamaahRouteArgs> {
  HomeJamaahRoute({_i18.Key? key, int? index = 0})
      : super(name,
            path: '/home_jamaah',
            args: HomeJamaahRouteArgs(key: key, index: index));

  static const String name = 'HomeJamaahRoute';
}

class HomeJamaahRouteArgs {
  const HomeJamaahRouteArgs({this.key, this.index = 0});

  final _i18.Key? key;

  final int? index;
}

/// generated route for [_i14.HomeDetailMasjid]
class HomeDetailMasjidRoute
    extends _i17.PageRouteInfo<HomeDetailMasjidRouteArgs> {
  HomeDetailMasjidRoute({_i18.Key? key, required int? id, int? index = 0})
      : super(name,
            path: '/home_detail_masjid',
            args: HomeDetailMasjidRouteArgs(key: key, id: id, index: index));

  static const String name = 'HomeDetailMasjidRoute';
}

class HomeDetailMasjidRouteArgs {
  const HomeDetailMasjidRouteArgs({this.key, required this.id, this.index = 0});

  final _i18.Key? key;

  final int? id;

  final int? index;
}

/// generated route for [_i15.DetailJadwalImam]
class DetailJadwalImamRoute
    extends _i17.PageRouteInfo<DetailJadwalImamRouteArgs> {
  DetailJadwalImamRoute(
      {_i18.Key? key, required int? id, required String? hari})
      : super(name,
            path: '/detail_jadwal_imam',
            args: DetailJadwalImamRouteArgs(key: key, id: id, hari: hari));

  static const String name = 'DetailJadwalImamRoute';
}

class DetailJadwalImamRouteArgs {
  const DetailJadwalImamRouteArgs(
      {this.key, required this.id, required this.hari});

  final _i18.Key? key;

  final int? id;

  final String? hari;
}

/// generated route for [_i16.Detail]
class DetailRoute extends _i17.PageRouteInfo<void> {
  const DetailRoute() : super(name, path: '/detail');

  static const String name = 'DetailRoute';
}
