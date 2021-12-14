import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_mosque/constants/themes.dart';

class CustomOptionWithSearch extends StatefulWidget {
  final List options;
  final String title;

  const CustomOptionWithSearch({Key? key,required this.options,required this.title})
      : super(key: key);

  @override
  _CustomOptionWithSearchState createState() => _CustomOptionWithSearchState();
}

class _CustomOptionWithSearchState extends State<CustomOptionWithSearch> {
  String selectedValue = "";
  TextEditingController searchController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();
  String searchValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: searchController,
              onChanged: (value){
                searchValue=value;
                setState(() {

                });
              },
              onFieldSubmitted: (value){
                searchValue=value;
                FocusScope.of(context).unfocus();
                setState(() {

                });
              },
              decoration: InputDecoration(
                  hintText: widget.title,
                  suffixIcon: IconButton(icon: Icon(Icons.search),onPressed: (){
                    searchValue=searchController.text;
                    FocusScope.of(context).unfocus();
                    setState(() {

                    });
                  },)
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (selectedValue != "" && (_formKey.currentState?.validate()??false)) {
                Navigator.pop(context, selectedValue);
              } else {
                EasyLoading.showError('${widget.title.split(' ')[1]} belum diisi');
              }
            },
            child: Text(
              'Simpan',
              style: TextStyle(color: bluePrimary, fontSize: 16),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: widget.options.where((element) => element.toString().toLowerCase().contains(searchValue))
                      .map((e) => RadioListTile<String?>(
                    value: e['id'],
                    activeColor: bluePrimary,
                    groupValue: selectedValue,
                    onChanged: (value) {
                      selectedValue = value.toString();
                      setState(() {});
                    },
                    title: Text(e['nama']),
                  ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}