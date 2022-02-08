import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate/Screens/details.dart';
import 'package:real_estate/controller/search_controller.dart';

class MapResult extends StatelessWidget {
  const MapResult({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(19, 26, 44, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(19, 26, 44, 1.0),
        title: const Text('map_result'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              color: Colors.white.withOpacity(0.5),
            ),
            // color: Color.fromRGBO(19, 26, 44, 1.0),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: GetBuilder<SearchController>(
                builder: (logic) {
                  if (logic.loading.value == false) {
                    return logic.mapResult.isEmpty ?
                    const Center(child: Text('No Available Locations'),):
                    ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return Hero(
                            tag: Image.network(
                              logic.mapResult[index]['images'][0],
                              fit: BoxFit.fill,
                            ),
                            child: buildProperty(context, logic.mapResult[index]));
                      },
                      itemCount: 1,
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
            ),
      ),
    );
  }

  Widget buildProperty(BuildContext context, dynamic property) {
    String name = property['name'];
    String d = property['description'];
    String p = property['purpose'];
    String l = property['location'];
    String owner_image = property['userImage'];
    int bark = property['num_bark'];
    int price = property['price'];
    int bath = property['num_bath'];
    int number = property['user_number'];
    int bed = property['num_bed'];
    int ket = property['num_ket'];
    int sqm = property['sqm'];
    List images_url = property['images'];
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
                    purpose: p,
                    location: l,
                    num_bark: bark,
                    num_bath: bath,
                    num_bed: bed,
                    num_ket: ket,
                    sqm: sqm,
                    description: d,
                    price: price,
                    owner: name,
                    owner_image: owner_image,
                    images: images_url,
                    user_number: number,
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
          height: data.size.height / 2.95,
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: NetworkImage(property['images'][0]),fit: BoxFit.fitHeight)),
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
