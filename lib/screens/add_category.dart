import 'package:app/utils/colors.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  bool? _value = false;
  String type = "expense";
  String _selectedType = '';
  Widget _customDropDownAddress(BuildContext context, String? item) {
    return Text(
      item ?? 'Choose a category',
      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 16),
    );
  }

  Widget _style1(BuildContext context, String? item, bool isSelected) {
    return Column(
      children: [
        ListTile(
          title: Text(
            item ?? '',
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 16),
          ),
        ),
        Divider(
          thickness: 1,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.gray,
      appBar: AppBar(
        title: Text('Add Category'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Category Type",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                // padding: EdgeInsets.all(8),
                // margin: EdgeInsets.all(8),
                child: Column(
                  children: [
                    RadioListTile(
                      title: Text("Expense"),
                      value: "expense",
                      groupValue: type,
                      onChanged: (value) {
                        setState(() {
                          type = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text("Income"),
                      value: "income",
                      groupValue: type,
                      onChanged: (value) {
                        setState(() {
                          type = value.toString();
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              NewWidget(),
              SizedBox(
                height: 8,
              ),
              DropdownSearch<String>(
                items: ['Food & Drinks', 'Shoping'],
                onChanged: (value) {
                  _selectedType = value!;
                  print(_selectedType);
                },
                dropdownBuilder: _customDropDownAddress,
                //   selectedItem: _selectedType,
                popupProps: PopupProps.menu(
                  itemBuilder: _style1,
                  showSelectedItems: true,
                ),
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14)),
                      fillColor: Colors.white,
                      filled: true),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Budgeted Amount",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14)),
                  hintText: '0.0',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Note",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14)),
                  hintText: 'Note',
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    child: Text('Save',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      print('Hello');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Category",
      style: TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
