import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mighty_car_rental/components/fav_vehicle_card.dart';
import 'package:mighty_car_rental/models/auth_model.dart';
import 'package:mighty_car_rental/providers/dio_provider.dart';
import 'package:mighty_car_rental/utils/config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  Map<String, dynamic> user = {};
  List<dynamic> favVehicle = [];
  bool isFavorite = false;
  bool isNotice = false;
  int items_count = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    if (token.isNotEmpty && token != '') {
      final response = await DioProvider().getFavVehicle(token);
      if (response != null) {
        setState(() {
          favVehicle = json.decode(response)['saved_favorite'];
          items_count = favVehicle.length;
        });
      } else {
        setState(() {
          favVehicle = [];
        });
      }
    }
  }

  void onRemove() {
    setState(() {
      loadData();
      if (items_count == 1) {
        favVehicle.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    user = Provider.of<AuthModel>(context, listen: false).getUser;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      body: favVehicle.isEmpty
          ? const Center(
              child: Text(
                "NO FAVORITE VEHICLE",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
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
                      const SizedBox(height: 5),
                      // render the vehicle card
                      Column(
                        children: List.generate(
                          favVehicle.length,
                          (index) {
                            return FavVehicleCard(
                              vehicle: favVehicle[index],
                              onRemove: onRemove,
                            );
                          },
                        ),
                      ),
                      // END - render the vehicle card
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
