import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/Screens/details.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.uid, required this.url, required this.name})
      : super(key: key);
 final String uid;
  final String url;
  final String name;
  @override
  _ProfileState createState() => _ProfileState();

}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  late List Data;
  Future getData() async {
    var res = await FirebaseFirestore.instance
        .collection('RealEstate')
        .where('uid', isEqualTo: widget.uid)
        .get();
    return Data = res.docs;
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        backgroundColor: Color.fromRGBO(19, 26, 44, 1.0),
      ),
      body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Column(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            Color.fromRGBO(19, 26, 44, 1.0),
                            Color.fromRGBO(19, 26, 44, 1.0)
                          ])),
                      child: Container(
                        width: double.infinity,
                        height: 290.0,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  widget.url,
                                ),
                                radius: 50.0,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                widget.name,
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Card(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 5.0),
                                clipBehavior: Clip.antiAlias,
                                color: Colors.white,
                                elevation: 5.0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 22.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "RealEstats",
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    19, 26, 44, 1.0),
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              "${Data.length}",
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.redAccent,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: data.size.height / 9,
                                        width: data.size.width / 6,
                                        decoration: BoxDecoration(
                                            color:
                                                Color.fromRGBO(19, 26, 44, 1.0),
                                            borderRadius:
                                                BorderRadius.circular(10)
                                            // shape: BoxShape.circle,
                                            ),
                                        child: Center(
                                          child: Icon(
                                            Icons.phone,
                                            color: Colors.yellow[700],
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Container(
                                        height: data.size.height / 9,
                                        width: data.size.width / 6,
                                        decoration: BoxDecoration(
                                            color:
                                                Color.fromRGBO(19, 26, 44, 1.0),
                                            borderRadius:
                                                BorderRadius.circular(10)
                                            // shape: BoxShape.circle,
                                            ),
                                        child: Center(
                                          child: Icon(
                                            Icons.message,
                                            color: Colors.yellow[700],
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                  Expanded(
                    child: Container(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 16.0),
                          child: Data.length == 0
                              ? Center(
                                  child: Text('Dont Have A RealEstate'),
                                )
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Hero(
                                        tag: Image.network(
                                            Data[index]['images'][0]),
                                        child: buildProperty(
                                            context, Data[index]));
                                  },
                                  itemCount: Data.length,
                                )),
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }

  Widget buildProperty(BuildContext context, dynamic property) {
    String name = property['name'];
    String d = property['description'];
    String p = property['purpose'];
    String l = property['location'];
    String owner_image = property['image'];
    int bark = property['num_bark'];
    int price = property['price'];
    int bath = property['num_bath'];
    int bed = property['num_bed'];
    int number = property.user_number;
    int ket = property['num_ket'];
    int sqm = property['sqm'];
    List images_url = property['images'];
    final data = MediaQuery.of(context);
    final width = data.size.width;
    final height = data.size.height;
    return Container(
      padding: EdgeInsets.only(right: 10),
      // height: height * .8,
      width: width * .8,
      child: GestureDetector(
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Container(
            height: data.size.height / 2.35,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(property['images'][0]))),
            child: Container(
              // height: data.size.height / 2.35,
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage("assets/images/house_01.jpg"),
              //     fit: BoxFit.cover,
              //   ),
              // ),
              child: Container(
                padding: EdgeInsets.all(20),
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
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      width: width * 0.3,
                      height: height * 0.06,
                      padding: EdgeInsets.symmetric(
                        vertical: 4,
                      ),
                      child: Center(
                        child: Text(
                          "FOR " + property['purpose'],
                          style: TextStyle(
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
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: width * .02,
                                ),
                                Text(
                                  property['location'],
                                  style: TextStyle(
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
                                Icon(
                                  Icons.zoom_out_map,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: width * .02,
                                ),
                                Text(
                                  "${property['sqm']}" + " sq/m",
                                  style: TextStyle(
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
                              Spacer(),
                              Text(
                                r"$" + " ${property['price']} SDG",
                                style: TextStyle(
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
        ),
      ),
    );
  }
}
