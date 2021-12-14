// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../blocs/auth/authentication_cubit.dart' as _i4;
import '../blocs/jamaah/detail_masjid/detail_masjid_cubit.dart' as _i29;
import '../blocs/jamaah/informasi_jamaah/informasi_jamaah_cubit.dart' as _i31;
import '../blocs/jamaah/informasi_masjid/informasi_masjid_cubit.dart' as _i32;
import '../blocs/jamaah/inventaris_masjid/inventaris_masjid_cubit.dart' as _i34;
import '../blocs/jamaah/jadwal_masjid/detail/detail_jadwal_masjid_cubit.dart'
    as _i28;
import '../blocs/jamaah/jadwal_masjid/jadwal_masjid_cubit.dart' as _i9;
import '../blocs/jamaah/kegiatan_masjid/kegiatan_masjid_cubit.dart' as _i40;
import '../blocs/jamaah/keuangan_masjid/pemasukan_masjid/pemasukan_masjid_cubit.dart'
    as _i16;
import '../blocs/jamaah/keuangan_masjid/pengeluaran_masjid/pengeluaran_masjid_cubit.dart'
    as _i18;
import '../blocs/jamaah/masjid_jamaah/masjid_jamaah_cubit.dart' as _i42;
import '../blocs/jamaah/profil_jamaah/profil_jamaah_cubit.dart' as _i45;
import '../blocs/login/login_cubit.dart' as _i41;
import '../blocs/masjid/dashboard/dashboard_masjid_cubit.dart' as _i25;
import '../blocs/masjid/detail/detail_cubit.dart' as _i26;
import '../blocs/masjid/informasi/informasi_cubit.dart' as _i30;
import '../blocs/masjid/inventaris/inventaris_cubit.dart' as _i33;
import '../blocs/masjid/jadwal-imam/detail/detail_imam_cubit.dart' as _i27;
import '../blocs/masjid/jadwal-imam/jadwal_imam_cubit.dart' as _i35;
import '../blocs/masjid/jamaah/jamaah_cubit.dart' as _i36;
import '../blocs/masjid/kegiatan/anggota/kegiatan_anggota_cubit.dart' as _i37;
import '../blocs/masjid/kegiatan/iuran/kegiatan_iuran_cubit.dart' as _i39;
import '../blocs/masjid/kegiatan/kegiatan_cubit.dart' as _i38;
import '../blocs/masjid/kegiatan/tambah_kegiatan/tambah_kegiatan_cubit.dart'
    as _i22;
import '../blocs/masjid/keuangan/pemasukan/pemasukan_cubit.dart' as _i15;
import '../blocs/masjid/keuangan/pengeluaran/pengeluaran_cubit.dart' as _i17;
import '../blocs/masjid/keuangan/tambah_pemasukan/tambah_pemasukan_cubit.dart'
    as _i23;
import '../blocs/masjid/pengurus/pengurus_cubit.dart' as _i43;
import '../blocs/masjid/profil/profil_cubit.dart' as _i44;
import '../blocs/masjid/tambah-pengurus/tambah_pengurus_cubit.dart' as _i24;
import '../service/api_interceptor.dart' as _i3;
import '../service/http_service.dart' as _i5;
import '../service/informasi_service.dart' as _i6;
import '../service/inventaris_service.dart' as _i7;
import '../service/jadwal_imam_service.dart' as _i8;
import '../service/jamaah_service.dart' as _i10;
import '../service/kegiatan_service.dart' as _i11;
import '../service/keuangan_service.dart' as _i12;
import '../service/login_service.dart' as _i13;
import '../service/masjid_service.dart' as _i14;
import '../service/pengurus_service.dart' as _i19;
import '../service/profil_service.dart' as _i21;
import '../utils/preference_helper.dart'
    as _i20; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.ApiInterceptors>(() => _i3.ApiInterceptors());
  gh.factory<_i4.AuthenticationCubit>(() => _i4.AuthenticationCubit());
  gh.lazySingleton<_i5.HttpService>(() => _i5.HttpService());
  gh.lazySingleton<_i6.InformasiService>(() => _i6.InformasiService());
  gh.lazySingleton<_i7.InventarisService>(() => _i7.InventarisService());
  gh.lazySingleton<_i8.JadwalImamService>(() => _i8.JadwalImamService());
  gh.factory<_i9.JadwalMasjidCubit>(
      () => _i9.JadwalMasjidCubit(get<_i8.JadwalImamService>()));
  gh.lazySingleton<_i10.JamaahService>(() => _i10.JamaahService());
  gh.lazySingleton<_i11.KegiatanService>(() => _i11.KegiatanService());
  gh.lazySingleton<_i12.KeuanganService>(() => _i12.KeuanganService());
  gh.lazySingleton<_i13.LoginService>(() => _i13.LoginService());
  gh.lazySingleton<_i14.MasjidService>(() => _i14.MasjidService());
  gh.factory<_i15.PemasukanCubit>(
      () => _i15.PemasukanCubit(get<_i12.KeuanganService>()));
  gh.factory<_i16.PemasukanMasjidCubit>(
      () => _i16.PemasukanMasjidCubit(get<_i12.KeuanganService>()));
  gh.factory<_i17.PengeluaranCubit>(
      () => _i17.PengeluaranCubit(get<_i12.KeuanganService>()));
  gh.factory<_i18.PengeluaranMasjidCubit>(
      () => _i18.PengeluaranMasjidCubit(get<_i12.KeuanganService>()));
  gh.lazySingleton<_i19.PengurusService>(() => _i19.PengurusService());
  gh.lazySingleton<_i20.PreferencesHelper>(() => _i20.PreferencesHelper());
  gh.lazySingleton<_i21.ProfilService>(() => _i21.ProfilService());
  gh.factory<_i22.TambahKegiatanCubit>(() => _i22.TambahKegiatanCubit(
      get<_i11.KegiatanService>(), get<_i10.JamaahService>()));
  gh.factory<_i23.TambahPemasukanCubit>(() => _i23.TambahPemasukanCubit(
      get<_i12.KeuanganService>(), get<_i10.JamaahService>()));
  gh.factory<_i24.TambahPengurusCubit>(
      () => _i24.TambahPengurusCubit(get<_i19.PengurusService>()));
  gh.factory<_i25.DashboardMasjidCubit>(
      () => _i25.DashboardMasjidCubit(get<_i10.JamaahService>()));
  gh.factory<_i26.DetailCubit>(
      () => _i26.DetailCubit(get<_i14.MasjidService>()));
  gh.factory<_i27.DetailImamCubit>(
      () => _i27.DetailImamCubit(get<_i8.JadwalImamService>()));
  gh.factory<_i28.DetailJadwalMasjidCubit>(
      () => _i28.DetailJadwalMasjidCubit(get<_i8.JadwalImamService>()));
  gh.factory<_i29.DetailMasjidCubit>(
      () => _i29.DetailMasjidCubit(get<_i14.MasjidService>()));
  gh.factory<_i30.InformasiCubit>(
      () => _i30.InformasiCubit(get<_i6.InformasiService>()));
  gh.factory<_i31.InformasiJamaahCubit>(
      () => _i31.InformasiJamaahCubit(get<_i6.InformasiService>()));
  gh.factory<_i32.InformasiMasjidCubit>(
      () => _i32.InformasiMasjidCubit(get<_i6.InformasiService>()));
  gh.factory<_i33.InventarisCubit>(
      () => _i33.InventarisCubit(get<_i7.InventarisService>()));
  gh.factory<_i34.InventarisMasjidCubit>(
      () => _i34.InventarisMasjidCubit(get<_i7.InventarisService>()));
  gh.factory<_i35.JadwalImamCubit>(
      () => _i35.JadwalImamCubit(get<_i8.JadwalImamService>()));
  gh.factory<_i36.JamaahCubit>(
      () => _i36.JamaahCubit(get<_i10.JamaahService>()));
  gh.factory<_i37.KegiatanAnggotaCubit>(
      () => _i37.KegiatanAnggotaCubit(get<_i11.KegiatanService>()));
  gh.factory<_i38.KegiatanCubit>(
      () => _i38.KegiatanCubit(get<_i11.KegiatanService>()));
  gh.factory<_i39.KegiatanIuranCubit>(
      () => _i39.KegiatanIuranCubit(get<_i11.KegiatanService>()));
  gh.factory<_i40.KegiatanMasjidCubit>(
      () => _i40.KegiatanMasjidCubit(get<_i11.KegiatanService>()));
  gh.factory<_i41.LoginCubit>(() => _i41.LoginCubit(
      get<_i13.LoginService>(), get<_i4.AuthenticationCubit>()));
  gh.factory<_i42.MasjidJamaahCubit>(
      () => _i42.MasjidJamaahCubit(get<_i14.MasjidService>()));
  gh.factory<_i43.PengurusCubit>(
      () => _i43.PengurusCubit(get<_i19.PengurusService>()));
  gh.factory<_i44.ProfilCubit>(
      () => _i44.ProfilCubit(get<_i21.ProfilService>()));
  gh.factory<_i45.ProfilJamaahCubit>(
      () => _i45.ProfilJamaahCubit(get<_i21.ProfilService>()));
  return get;
}
