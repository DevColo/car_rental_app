import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mighty_car_rental/components/button.dart';
import 'package:mighty_car_rental/main.dart';
import 'package:mighty_car_rental/providers/dio_provider.dart';
import 'package:mighty_car_rental/screens/booking_form.dart';
import 'package:mighty_car_rental/src/images.dart';
import 'package:mighty_car_rental/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components//custom_appbar.dart';

class VehicleDetails extends StatefulWidget {
  const VehicleDetails({
    super.key,
    required this.vehicle,
    //required this.isFav,
  });
  final Map<String, dynamic> vehicle;
  //final bool isFav;

  @override
  State<VehicleDetails> createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  Map<String, dynamic> vehicle = {};
  bool isFav = false;

  @override
  void initState() {
    vehicle = widget.vehicle;
    //isFav = widget.isFav;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: 'Vehicle Details',
        icon: const FaIcon(Icons.arrow_back_ios),
        actions: [
          //Favarite Button
          IconButton(
            onPressed: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              final token = prefs.getString('token') ?? '';

              if (token.isNotEmpty && token != '') {
                var vehicleId = vehicle['id'];
                final response =
                    await DioProvider().addFavVehicle(token, vehicleId);
                //if insert successfully, then change the favorite status
                if (response == 200) {
                  setState(() {
                    isFav = !isFav;
                  });
                }
              }
            },
            icon: FaIcon(
              isFav ? Icons.favorite_rounded : Icons.favorite_outline,
              color: Colors.red,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            AboutVehicle(
              vehicle: vehicle,
            ),
            DetailBody(
              vehicle: vehicle,
            ),
            Container(
              color: const Color.fromARGB(255, 243, 243, 243),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Button(
                  width: double.infinity,
                  title: 'Book Now',
                  onPressed: () {
                    MyApp.navigatorKey.currentState!.push(MaterialPageRoute(
                        builder: (_) => BookingForm(
                              vehicle: vehicle,
                              // isFav: isFav,
                            )));
                    // Navigator.of(context).pushNamed('booking_screen',
                    //     arguments: {"vehicle_id": vehicle['id']});
                  },
                  disable: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutVehicle extends StatelessWidget {
  const AboutVehicle({super.key, required this.vehicle});

  final Map<dynamic, dynamic> vehicle;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      color: const Color.fromARGB(255, 243, 243, 243),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Image.network(
            img + vehicle['image'],
            width: Config.screenWidth,
            fit: BoxFit.cover,
          ),
          Config.spaceMedium,
          Text(
            "${vehicle['vehicle_name']}",
            style: const TextStyle(
              color: Color.fromARGB(255, 54, 54, 54),
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Config.spaceSmall,
          SizedBox(
            width: Config.widthSize * 0.75,
            child: Text(
              "\$${vehicle['price']}/ hr",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class DetailBody extends StatelessWidget {
  const DetailBody({super.key, required this.vehicle});
  final Map<dynamic, dynamic> vehicle;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      padding: const EdgeInsets.all(10),
      color: const Color.fromARGB(255, 243, 243, 243),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Config.spaceSmall,
          VehicleInfo(
            petro: vehicle['petro'],
            brand: vehicle['brand'],
            seat: vehicle['seat_amount'],
          ),
          Config.spaceMedium,
          const Text(
            'Vehicle Description',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          Config.spaceSmall,
          Text(
            '${vehicle['description']}',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
            softWrap: true,
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }
}

class VehicleInfo extends StatelessWidget {
  const VehicleInfo(
      {super.key,
      required this.petro,
      required this.brand,
      required this.seat});

  final String petro;
  final String brand;
  final String seat;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        InfoCard(
          label: 'Petro',
          value: petro,
        ),
        const SizedBox(
          width: 15,
        ),
        InfoCard(
          label: 'Brands',
          value: brand,
        ),
        const SizedBox(
          width: 15,
        ),
        InfoCard(
          label: 'Seats',
          value: seat,
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Config.primaryColor,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 15,
        ),
        child: Column(
          children: <Widget>[
            Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
