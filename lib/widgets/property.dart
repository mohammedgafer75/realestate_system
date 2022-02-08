import 'package:flutter/material.dart';
import 'package:real_estate/Screens/details.dart';

class Property extends StatelessWidget {
  const Property({Key? key, required this.property}) : super(key: key);
  final dynamic property;
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final width = data.size.width;
    final height = data.size.height;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Details(
                    uid: property.uid,
                    purpose: property.purpose,
                    location: property.location,
                    num_bark: property.num_bark,
                    num_bath: property.num_bath,
                    num_bed: property.num_bed,
                    num_ket: property.num_ket,
                    sqm: property.sqm,
                    description: property.description,
                    price: property.price,
                    owner: property.name,
                    owner_image: property.userImage,
                    images: property.images,
                    user_number: property.user_number,
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
          height: data.size.height / 2.70,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(property.images[0]), fit: BoxFit.cover)),
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
                      "FOR " + property.purpose,
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
                              property.location,
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
                              "${property.sqm}" + " sq/m",
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
                            // ignore: prefer_adjacent_string_concatenation
                            r"$" + " ${property.price} SDG",
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
