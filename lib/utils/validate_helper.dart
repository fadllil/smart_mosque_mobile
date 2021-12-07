String? validateForm(String value,{required String label}){
  if(value.isEmpty||value=='null'){
    return '$label harus diisi';
  }
  return null;
}