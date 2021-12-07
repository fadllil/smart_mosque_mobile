// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../blocs/auth/authentication_cubit.dart' as _i4;
import '../blocs/jamaah/detail_masjid/detail_masjid_cubit.dart' as _i27;
import '../blocs/jamaah/informasi_jamaah/informasi_jamaah_cubit.dart' as _i29;
import '../blocs/jamaah/informasi_masjid/informasi_masjid_cubit.dart' as _i30;
import '../blocs/jamaah/inventaris_masjid/inventaris_masjid_cubit.dart' as _i32;
import '../blocs/jamaah/jadwal_masjid/detail/detail_jadwal_masjid_cubit.dart'
    as _i26;
import '../blocs/jamaah/jadwal_masjid/jadwal_masjid_cubit.dart' as _i10;
import '../blocs/jamaah/kegiatan_masjid/kegiatan_masjid_cubit.dart' as _i36;
import '../blocs/jamaah/keuangan_masjid/pemasukan_masjid/pemasukan_masjid_cubit.dart'
    as _i17;
import '../blocs/jamaah/keuangan_masjid/pengeluaran_masjid/pengeluaran_masjid_cubit.dart'
    as _i19;
import '../blocs/jamaah/masjid_jamaah/masjid_jamaah_cubit.dart' as _i38;
import '../blocs/jamaah/profil_jamaah/profil_jamaah_cubit.dart' as _i41;
import '../blocs/login/login_cubit.dart' as _i37;
import '../blocs/masjid/dashboard/dashboard_masjid_cubit.dart' as _i5;
import '../blocs/masjid/detail/detail_cubit.dart' as _i24;
import '../blocs/masjid/informasi/informasi_cubit.dart' as _i28;
import '../blocs/masjid/inventaris/inventaris_cubit.dart' as _i31;
import '../blocs/masjid/jadwal-imam/detail/detail_imam_cubit.dart' as _i25;
import '../blocs/masjid/jadwal-imam/jadwal_imam_cubit.dart' as _i33;
import '../blocs/masjid/jamaah/jamaah_cubit.dart' as _i34;
import '../blocs/masjid/kegiatan/kegiatan_cubit.dart' as _i35;
import '../blocs/masjid/keuangan/pemasukan/pemasukan_cubit.dart' as _i16;
import '../blocs/masjid/keuangan/pengeluaran/pengeluaran_cubit.dart' as _i18;
import '../blocs/masjid/pengurus/pengurus_cubit.dart' as _i39;
import '../blocs/masjid/profil/profil_cubit.dart' as _i40;
import '../blocs/masjid/tambah-pengurus/tambah_pengurus_cubit.dart' as _i23;
import '../service/api_interceptor.dart' as _i3;
import '../service/http_service.dart' as _i6;
import '../service/informasi_service.dart' as _i7;
import '../service/inventaris_service.dart' as _i8;
import '../service/jadwal_imam_service.dart' as _i9;
import '../service/jamaah_service.dart' as _i11;
import '../service/kegiatan_service.dart' as _i12;
import '../service/keuangan_service.dart' as _i13;
import '../service/login_service.dart' as _i14;
import '../service/masjid_service.dart' as _i15;
import '../service/pengurus_service.dart' as _i20;
import '../service/profil_service.dart' as _i22;
import '../utils/preference_helper.dart'
    as _i21; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.ApiInterceptors>(() => _i3.ApiInterceptors());
  gh.factory<_i4.AuthenticationCubit>(() => _i4.AuthenticationCubit());
  gh.factory<_i5.DashboardMasjidCubit>(() => _i5.DashboardMasjidCubit());
  gh.lazySingleton<_i6.HttpService>(() => _i6.HttpService());
  gh.lazySingleton<_i7.InformasiService>(() => _i7.InformasiService());
  gh.lazySingleton<_i8.InventarisService>(() => _i8.InventarisService());
  gh.lazySingleton<_i9.JadwalImamService>(() => _i9.JadwalImamService());
  gh.factory<_i10.JadwalMasjidCubit>(
      () => _i10.JadwalMasjidCubit(get<_i9.JadwalImamService>()));
  gh.lazySingleton<_i11.JamaahService>(() => _i11.JamaahService());
  gh.lazySingleton<_i12.KegiatanService>(() => _i12.KegiatanService());
  gh.lazySingleton<_i13.KeuanganService>(() => _i13.KeuanganService());
  gh.lazySingleton<_i14.LoginService>(() => _i14.LoginService());
  gh.lazySingleton<_i15.MasjidService>(() => _i15.MasjidService());
  gh.factory<_i16.PemasukanCubit>(
      () => _i16.PemasukanCubit(get<_i13.KeuanganService>()));
  gh.factory<_i17.PemasukanMasjidCubit>(
      () => _i17.PemasukanMasjidCubit(get<_i13.KeuanganService>()));
  gh.factory<_i18.PengeluaranCubit>(
      () => _i18.PengeluaranCubit(get<_i13.KeuanganService>()));
  gh.factory<_i19.PengeluaranMasjidCubit>(
      () => _i19.PengeluaranMasjidCubit(get<_i13.KeuanganService>()));
  gh.lazySingleton<_i20.PengurusService>(() => _i20.PengurusService());
  gh.lazySingleton<_i21.PreferencesHelper>(() => _i21.PreferencesHelper());
  gh.lazySingleton<_i22.ProfilService>(() => _i22.ProfilService());
  gh.factory<_i23.TambahPengurusCubit>(
      () => _i23.TambahPengurusCubit(get<_i20.PengurusService>()));
  gh.factory<_i24.DetailCubit>(
      () => _i24.DetailCubit(get<_i15.MasjidService>()));
  gh.factory<_i25.DetailImamCubit>(
      () => _i25.DetailImamCubit(get<_i9.JadwalImamService>()));
  gh.factory<_i26.DetailJadwalMasjidCubit>(
      () => _i26.DetailJadwalMasjidCubit(get<_i9.JadwalImamService>()));
  gh.factory<_i27.DetailMasjidCubit>(
      () => _i27.DetailMasjidCubit(get<_i15.MasjidService>()));
  gh.factory<_i28.InformasiCubit>(
      () => _i28.InformasiCubit(get<_i7.InformasiService>()));
  gh.factory<_i29.InformasiJamaahCubit>(
      () => _i29.InformasiJamaahCubit(get<_i7.InformasiService>()));
  gh.factory<_i30.InformasiMasjidCubit>(
      () => _i30.InformasiMasjidCubit(get<_i7.InformasiService>()));
  gh.factory<_i31.InventarisCubit>(
      () => _i31.InventarisCubit(get<_i8.InventarisService>()));
  gh.factory<_i32.InventarisMasjidCubit>(
      () => _i32.InventarisMasjidCubit(get<_i8.InventarisService>()));
  gh.factory<_i33.JadwalImamCubit>(
      () => _i33.JadwalImamCubit(get<_i9.JadwalImamService>()));
  gh.factory<_i34.JamaahCubit>(
      () => _i34.JamaahCubit(get<_i11.JamaahService>()));
  gh.factory<_i35.KegiatanCubit>(
      () => _i35.KegiatanCubit(get<_i12.KegiatanService>()));
  gh.factory<_i36.KegiatanMasjidCubit>(
      () => _i36.KegiatanMasjidCubit(get<_i12.KegiatanService>()));
  gh.factory<_i37.LoginCubit>(() => _i37.LoginCubit(
      get<_i14.LoginService>(), get<_i4.AuthenticationCubit>()));
  gh.factory<_i38.MasjidJamaahCubit>(
      () => _i38.MasjidJamaahCubit(get<_i15.MasjidService>()));
  gh.factory<_i39.PengurusCubit>(
      () => _i39.PengurusCubit(get<_i20.PengurusService>()));
  gh.factory<_i40.ProfilCubit>(
      () => _i40.ProfilCubit(get<_i22.ProfilService>()));
  gh.factory<_i41.ProfilJamaahCubit>(
      () => _i41.ProfilJamaahCubit(get<_i22.ProfilService>()));
  return get;
}
