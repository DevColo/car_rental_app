import 'package:mighty_car_rental/main.dart';
import 'package:mighty_car_rental/screens/vehicle_details.dart';
import 'package:mighty_car_rental/src/images.dart';
//import 'package:doctor_app/screens/doctor_details.dart';
import 'package:mighty_car_rental/utils/config.dart';
import 'package:flutter/material.dart';

class VehicleCard extends StatelessWidget {
  const VehicleCard({
    Key? key,
    required this.vehicle,
    //required this.isFav,
  }) : super(key: key);

  final Map<String, dynamic> vehicle;
  //final bool isFav;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 300,
      child: GestureDetector(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
              color: Color.fromARGB(255, 233, 233, 233),
              width: 1.0,
            ),
          ),
          elevation: 0,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 243, 243, 243),
                ),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: <Widget>[
                    // vehicle image
                    Image.asset(
                      //welcomeCar1,
                      img + vehicle['image'],
                      width: Config.screenWidth,
                      fit: BoxFit.cover,
                    ),
                    // fav icon
                    // Padding(
                    //   padding: const EdgeInsets.all(0),
                    //   child: IconButton(
                    //     icon: Icon(
                    //       isFavorite ? Icons.favorite : Icons.favorite_border,
                    //       color: Colors.red,r
                    //     ),
                    //     onPressed: () {
                    //       setState(() {
                    //         isFavorite = !isFavorite;
                    //       });
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
              // Vehicle Details
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, right: 15, left: 15, bottom: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Vehicle brand and name
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                //top: 3,
                                right: 5,
                                left: 5,
                                bottom: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 243, 243, 243),
                            ),
                            child: Text(
                              "${vehicle['brand']}",
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.blue),
                            ),
                          ),
                          Text(
                            "${vehicle['vehicle_name']}",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      // Vehicle price
                      Column(
                        children: [
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "\$${vehicle['price']}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      TextSpan(
                                        text: '/hr',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Color.fromARGB(
                                              255, 177, 177, 177),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Vehicle Descriptions
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, right: 15, left: 15, bottom: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Icon(
                              Icons.local_gas_station,
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            "${vehicle['petro']}",
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Icon(
                              Icons.directions_car,
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            "${vehicle['gear_type']}",
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Icon(
                              Icons.supervised_user_circle_sharp,
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            "${vehicle['seat_amount']} Seats",
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          //pass the details to detail page
          MyApp.navigatorKey.currentState!.push(MaterialPageRoute(
              builder: (_) => VehicleDetails(
                    vehicle: vehicle,
                  )));
        },
      ),
    );
  }
}
