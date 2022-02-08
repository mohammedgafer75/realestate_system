import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate/Screens/details.dart';
import 'package:real_estate/controller/search_controller.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(19, 26, 44, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(19, 26, 44, 1.0),
        title: const Text('Search Result'),
      ),
      body: Container(

          // height: 200,
          // width: 250,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            // color: Colors.white.withOpacity(0.5),
          ),
          // color: Color.fromRGBO(19, 26, 44, 1.0),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GetBuilder<SearchController>(
              builder: (logic) {
              return  logic.loading.value?const Center(
                  child: CircularProgressIndicator(),
                ):
                logic.data.isNotEmpty ?
                   ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Hero(
                          tag: Image.network(
                            logic.data[index]['images'][0],
                            fit: BoxFit.fill,
                          ),
                          child: buildProperty(context, logic.data[index]));
                    },
                    itemCount: logic.data.length,
                  ) : const Center(
                    child: Text('No Realestate Founded'),
                  );
              })
          ),
    );
  }

  Widget buildProperty(BuildContext context, dynamic property) {
    final data = MediaQuery.of(context);
    final width = data.size.width;
    final height = data.size.height;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Details(
                uid: property['uid'],
                purpose: property['purpose'],
                location: property['location'],
                num_bark: property['num_bark'],
                num_bath: property['num_bath'],
                num_bed: property['num_bed'],
                num_ket: property['num_ket'],
                sqm: property['sqm'],
                description: property['description'],
                price: property['price'],
                owner: property['owner'],
                owner_image: property['owner_image'],
                images: property['images'],
                user_number: property['user_number'],
                  )),
        );
      },
      child: Card(
        margin: EdgeInsets.only(bottom: data.size.width / 12),
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Container(
          height: data.size.height / 2.35,
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: NetworkImage(property['images'][0]))),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow[700],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  width: width * 0.3,
                  height: height * 0.06,
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                  ),
                  child: Center(
                    child: Text(
                      "FOR " + property['purpose'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: width * .02,
                            ),
                            Text(
                              property['location'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: data.size.height / 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.zoom_out_map,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: width * .02,
                            ),
                            Text(
                              "${property['sqm']}" " sq/m",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Spacer(),
                          Text(
                            r"$" " ${property['price']} SDG",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ])
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
