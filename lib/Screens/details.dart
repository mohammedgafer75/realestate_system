import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:real_estate/Screens/profile.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatefulWidget {
  const Details(
      {Key? key,
      required this.uid,
      required this.purpose,
      required this.owner_image,
      required this.owner,
      required this.price,
      required this.user_number,
      required this.description,
      required this.location,
      required this.num_bark,
      required this.num_bath,
      required this.num_bed,
      required this.num_ket,
      required this.sqm,
      required this.images})
      : super(key: key);
  final String uid;
  final String purpose;
  final String owner;
  final String owner_image;
  final String location;
  final String description;
  final int user_number;
  final int price;
  final int sqm;
  final int num_bed;
  final int num_bath;
  final int num_ket;
  final int num_bark;
  final List images;

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final width = data.size.width;
    final height = data.size.height;
    return Scaffold(
        body: ListView(
      children: [
        Stack(
          children: [
            Hero(
              tag: Image.network(widget.images[0]),
              child: Stack(
                children: [
                  SizedBox(
                    height: data.size.height * 0.5,
                    child: Image.network(
                      widget.images[0],
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    height: data.size.height * 0.5,
                    child: Container(
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
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: data.size.height * 0.50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.07, vertical: height * .07),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        Container(
                          height: data.size.height / 12,
                          width: data.size.width / 8,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.favorite,
                              color: Colors.red[700],
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Expanded(
                  //   child: Container(),
                  // ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * .07,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.yellow[700],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      width: data.size.width / 3.5,
                      height: data.size.height / 15,
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                      ),
                      child: Center(
                        child: Text(
                          "FOR " "${widget.purpose}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 0,
                      bottom: 16,
                    ),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 20,
                          ),
                          Text(
                            widget.location,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                        ]),
                        Row(
                          children: [
                            const Icon(
                              Icons.zoom_out_map,
                              color: Colors.white,
                              size: 20,
                            ),
                            Text(
                              "${widget.sqm}" " sq/m",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: EdgeInsets.only(
                                left: width * .08,
                                right: 24,
                                top: 8,
                                bottom: 16,
                              ),
                              child: Text(
                                r"$" "${widget.price}" + " SDG",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: data.size.height,
            decoration: const BoxDecoration(
              color: Colors.white,
              // borderRadius: BorderRadius.only(
              //   topLeft: Radius.circular(30),
              //   topRight: Radius.circular(30),
              // ),
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: data.size.width / 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => Profile(
                                  uid: widget.uid,
                                  url: widget.owner_image,
                                  name: widget.owner,
                                ));
                          },
                          child: Row(
                            children: [
                              Container(
                                height: data.size.height / 6,
                                width: data.size.width / 6,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(
                                  // image: DecorationImage(
                                  //   image: Image.network(
                                  //       "assets/images/house_01.jpg"),
                                  //   fit: BoxFit.cover,
                                  // ),
                                  shape: BoxShape.circle,
                                ),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: widget.owner_image,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      (const Icon(Icons.error)),
                                  width: 1000,
                                ),
                              ),
                              SizedBox(width: data.size.width / 40),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.owner,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: data.size.height / 120,
                                  // ),
                                  Text(
                                    "Property Owner",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                launch("tel://${widget.user_number}");
                              },
                              child: Container(
                                height: data.size.height / 5,
                                width: data.size.width / 7,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(19, 26, 44, 1.0),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.phone,
                                    color: Colors.yellow[700],
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: data.size.width / 130,
                            ),
                            // sms:0039-222-060-888
                            GestureDetector(
                              onTap: () {
                                launch("sms:${widget.user_number}");
                              },
                              child: Container(
                                height: data.size.height / 5,
                                width: data.size.width / 7,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(19, 26, 44, 1.0),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.message,
                                    color: Colors.yellow[700],
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * .13,
                    child: Row(
                      // scrollDirection: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildFeature(Icons.hotel, "${widget.num_bed} Bedroom"),
                        buildFeature(Icons.wc, "${widget.num_bath} Bathroom"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * .13,
                    child: Row(
                      // scrollDirection: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildFeature(
                            Icons.kitchen, "${widget.num_ket} Kitchen"),
                        buildFeature(
                            Icons.local_parking, "${widget.num_bark} Parking"),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 16,
                      right: 24,
                      left: 24,
                      bottom: 16,
                    ),
                    child: Text(
                      "description",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 24,
                      left: 50,
                      bottom: 24,
                    ),
                    child: Text(
                      widget.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      right: 24,
                      left: 24,
                      bottom: 16,
                    ),
                    child: Text(
                      "Photos",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 24,
                      ),
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: buildPhotos(widget.images),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Widget buildFeature(IconData iconData, String text) {
    return Container(
      margin: const EdgeInsets.only(left: 5, top: 5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(19, 26, 44, 1.0),
          borderRadius: BorderRadius.circular(10)
          //shape: BoxShape.rectangle,
          ),
      //color: Color.fromRGBO(19, 26, 44, 1.0),
      child: Column(
        children: [
          Icon(
            iconData,
            color: Colors.amber,
            size: 28,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildPhotos(List images) {
    List<Widget> list = [];
    list.add(const SizedBox(
      width: 24,
    ));
    for (var i = 0; i < images.length; i++) {
      list.add(buildPhoto(images[i]));
    }
    return list;
  }

  Widget buildPhoto(String url) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Container(
        margin: const EdgeInsets.only(right: 24),
        decoration: const BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage(url),
          //   fit: BoxFit.cover,
          // ),
          shape: BoxShape.circle,
        ),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: url,
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: CircularProgressIndicator(value: downloadProgress.progress),
          ),
          errorWidget: (context, url, error) => (const Icon(Icons.error)),
          width: 1000,
        ),
      ),
    );
  }
}
