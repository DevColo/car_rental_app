import 'package:flutter/material.dart';
import 'package:mighty_car_rental/components/vehicle_card.dart';
import 'package:mighty_car_rental/models/auth_model.dart';
import 'package:mighty_car_rental/src/images.dart';
import 'package:mighty_car_rental/utils/config.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> user = {};
  Map<String, dynamic> doctor = {};
  List<dynamic> favList = [];
  List<Map<String, dynamic>> topBrand = [
    {
      "image": benz,
      "category": "Benz",
    },
    {
      "image": farari,
      "category": "Farari",
    },
    {
      "image": rr,
      "category": "Rolls Royce",
    },
    {
      "image": bugatti,
      "category": "Buggati",
    },
    {
      "image": ford,
      "category": "Ford",
    },
    {
      "image": bmw,
      "category": "BMW",
    },
  ];
  bool isFavorite = false;
  bool isNotice = false;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    user = Provider.of<AuthModel>(context, listen: false).getUser;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(55.0),
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            child: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          const TextSpan(
                            text: "welcome, ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextSpan(
                            text: user['first_name'],
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    alignment: Alignment.centerRight,
                    icon: Icon(
                      isNotice
                          ? Icons.notifications
                          : Icons.notifications_active,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    onPressed: () {
                      setState(() {
                        isNotice = !isNotice;
                      });
                    },
                  ),
                ],
              ),
              backgroundColor: Colors.blue,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 243, 243, 243),
        //if user is empty, then return progress indicator
        body: user.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Top Brands',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        SizedBox(
                          height: 90,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children:
                                List<Widget>.generate(topBrand.length, (index) {
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Card(
                                    color: Color.fromARGB(255, 255, 253, 253),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    elevation: 0,
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              topBrand[index]['image']),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    topBrand[index]['category'],
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                        SizedBox(height: 15),
                        const Text(
                          'Popular Vehicles',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(
                          height: 5,
                        ),
                        // render the vehicle card
                        Column(
                          children:
                              List.generate(user['vehicles'].length, (index) {
                            return VehicleCard(
                              vehicle: user['vehicles'][index],
                              //if lates fav list contains particular doctor id, then show fav icon
                              // isFav: favList
                              //         .contains(user['doctor'][index]['doc_id'])
                              //     ? true
                              //     : false,
                            );
                          }),
                        ),
                        // END - render the vehicle card
                      ],
                    ),
                  ),
                ),
              ));
  }
}
