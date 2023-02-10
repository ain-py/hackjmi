import 'package:app/models/expense_model.dart';
import 'package:app/provider/add_category_provider.dart';
import 'package:app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key, required this.expenseData});
  final ExpenseData expenseData;
  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  List<DropdownMenuItem<String>>? getItems(List<String> itemList) {
    itemList.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(
          value,
          style: TextStyle(fontSize: 20),
        ),
      );
    }).toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<CategoryPorvider>(context, listen: false).expenseData =
        widget.expenseData;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.gray,
      appBar: AppBar(
        title: Text('Add Category'),
      ),
      body: Consumer<CategoryPorvider>(
        builder: (context, provider, child) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: provider.formKey,
              //   autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          groupValue: provider.type,
                          onChanged: (value) {
                            provider.type = value.toString();
                            provider.finalItem = provider.expenseItems;
                            provider.setSelectedType();
                          },
                        ),
                        RadioListTile(
                          title: Text("Income"),
                          value: "income",
                          groupValue: provider.type,
                          onChanged: (value) {
                            provider.type = value.toString();
                            provider.finalItem = provider.incomeItems;
                            provider.setSelectedType();
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Category",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  DropdownButtonFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) =>
                        value == null ? 'Category is required' : null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14)),
                      hintText: 'Choose a category',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    value: provider.selectedType,
                    items: provider.finalItem
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        provider.selectedType = newValue!;
                      });
                    },
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
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: provider.amountController,
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value!.isEmpty ? 'Field is required' : null,
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
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: provider.noteController,
                    validator: (value) =>
                        value!.isEmpty ? 'Field is required' : null,
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
                          if (provider.formKey.currentState!.validate()) {
                            //form is valid, proceed further
                            provider.addCat();
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
