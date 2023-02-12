import 'dart:convert';
import 'package:app/models/stock_model.dart';
import 'package:app/screens/stock_predict.dart';
import 'package:app/utils/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/utils/colors.dart';
import '../utils/constants.dart';

class StockModel extends StatefulWidget {
  const StockModel({super.key});

  @override
  State<StockModel> createState() => _StockModelState();
}

class _StockModelState extends State<StockModel>
    with SingleTickerProviderStateMixin {
  TextEditingController stockController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  // late final AnimationController _controller = AnimationController(
  //   duration: const Duration(seconds: 2),
  //   vsync: this,
  // )..repeat(reverse: false);
  // late final Animation<Offset> _offsetAnimation = Tween<Offset>(
  //   begin: Offset.zero,
  //   end: const Offset(1.5, 0.0),
  // ).animate(CurvedAnimation(
  //   parent: _controller,
  //   curve: Curves.elasticIn,
  // ));
  String id = '';
  double prediction = 0.0;

  bool isLoading = false;
  bool isDataLoaded = false;

  @override
  void dispose() {
    //   _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.gray,
      appBar: AppBar(
        title: Text('Stock Prediction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: formKey,
            //   autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Input Company name",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                      // autofocus: true,
                      style: DefaultTextStyle.of(context)
                          .style
                          .copyWith(fontStyle: FontStyle.italic),
                      decoration:
                          InputDecoration(border: OutlineInputBorder())),
                  suggestionsCallback: (pattern) async {
                    return await BackendService.getSuggestions(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      leading: FaIcon(FontAwesomeIcons.moneyCheck),
                      title: Text(suggestion['name'] ?? ''),
                      subtitle: Text('${suggestion['symbol']}'),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StockPredict(item: suggestion)));
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: SizedBox(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      child: isLoading
                          ? CircularProgressIndicator()
                          : Text('Search',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                      onPressed: () {},
                    ),
                  ),
                ),
                isDataLoaded
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          boxShadow: kboxShadow,
                        ),
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(8),
                        child: Text('${prediction} $id'),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
