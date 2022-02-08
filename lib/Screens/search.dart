import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate/Screens/find_realestate.dart';
import 'package:real_estate/controller/search_controller.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final width = data.size.width;
    final height = data.size.height;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(19, 26, 44, 1.0),
        child: Icon(
          Icons.map_outlined,
          color: Colors.blue.shade400,
        ),
        onPressed: () => Get.to( () => const FindRealEstate()),
      ),
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: const Color.fromRGBO(19, 26, 44, 1.0),
      ),
      backgroundColor: Colors.white,
      body:
          GetBuilder<SearchController>(
            init: SearchController(),
            builder: (logic) {
              return Form(
               key: logic.formKey,
               child: Container(
                 padding: const EdgeInsets.all(20),
                height: size.height,
                width: size.width,
                 child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Expanded(
                      child: Text(
                    "Location :",
                    style: TextStyle(color: Colors.black),
                  )),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: DropdownButton(
                        icon: const Icon(Icons.location_on_outlined,
                            color: Colors.black),
                        iconEnabledColor: Colors.white,
                        items: logic.category.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        onChanged: (String? newValueSelected) {
                           logic.currentCategorySelected = newValueSelected!;
                        },
                        value: logic.currentCategorySelected,
                      ),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: logic.min,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black),
                  hintText: 'Minimum price',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  return logic.validate(value!);
                },
              ),
              TextFormField(
                controller: logic.max,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black),
                  hintText: 'maximum price',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  return logic.validate(value!);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: TextButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.only(
                            top: height / 45,
                            bottom: height / 45,
                            left: width / 10,
                            right: width / 10)),
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(19, 26, 44, 1.0)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    side: const BorderSide(
                                        color:
                                            Color.fromRGBO(19, 26, 44, 1.0))))),
                    onPressed: () {
                     logic.search();
                    },
                    child: const Text('Search',
                        style: TextStyle(color: Colors.white, fontSize: 18))),
              )
            ],
          ),
        ),
      );
  },
),
    );
  }
}
