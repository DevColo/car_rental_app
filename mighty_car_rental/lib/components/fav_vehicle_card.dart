import 'package:mighty_car_rental/main.dart';
import 'package:mighty_car_rental/providers/dio_provider.dart';
import 'package:mighty_car_rental/screens/vehicle_details.dart';
import 'package:mighty_car_rental/src/images.dart';
import 'package:mighty_car_rental/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavVehicleCard extends StatelessWidget {
  const FavVehicleCard({
    super.key,
    required this.vehicle,
    required this.onRemove,
  });

  final Map<String, dynamic> vehicle;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 100,
      child: GestureDetector(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(
              color: Color.fromARGB(255, 233, 233, 233),
              width: 1.0,
            ),
          ),
          elevation: 0,
          color: Colors.white,
          child: Row(
            children: [
              // First Column: Image
              Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 243, 243, 243),
                  ),
                  child: Image.asset(
                    img + vehicle['image'],
                    width: Config.screenWidth,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Second Column: Title and Price
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      "${vehicle['vehicle_name']}",
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // Price
                    RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: [
                          TextSpan(
                            text: "\$${vehicle['price']}",
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const TextSpan(
                            text: '/hr',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 177, 177, 177),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Third Column: Fav Icon
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: const Icon(
                    Icons.close_outlined,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    final token = prefs.getString('token') ?? '';

                    if (token.isNotEmpty && token != '') {
                      var vehicleId = vehicle['id'];
                      final response = await DioProvider()
                          .removeFavVehicle(token, vehicleId);
                      if (response == 200) {
                        // Call the onRemove callback to trigger refresh
                        onRemove();
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          MyApp.navigatorKey.currentState!.push(MaterialPageRoute(
              builder: (_) => VehicleDetails(
                    vehicle: vehicle,
                  )));
        },
      ),
    );
  }
}
