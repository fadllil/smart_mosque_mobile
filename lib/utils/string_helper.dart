import 'package:intl/intl.dart';

String timeToGreet(){
  DateTime now = DateTime.now().toLocal();
  if(now.hour>=5&&now.hour<11){
    return 'Selamat Pagi🌄';
  }else if(now.hour>=11&&now.hour<15){
    return 'Selamat Siang☀️';
  }else if(now.hour>=15&&now.hour<19){
    return 'Selamat Sore🌅';
  }else{
    return 'Selamat Malam🌕';
  }
}
String valueRupiah(int value)=>NumberFormat.currency(
    locale: 'id',
    decimalDigits: 0,
    symbol: "Rp ")
    .format(value);

String dbDateFormat(DateTime value){
  return DateFormat('y-MM-dd').format(value.toLocal());
}

String convertDateTime(DateTime date) {
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  return formatter.format(date);
}