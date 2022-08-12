import 'package:debtsettler_wear/Models/Gospodinjstvo_model.dart';
import 'package:debtsettler_wear/Models/Uporabnik_model.dart';
import 'package:debtsettler_wear/Screens/PrikazNakupovalneListeScreen.dart';
import 'package:debtsettler_wear/Screens/PrikazUporabnikovScreen.dart';
import 'package:debtsettler_wear/Services/Gospodinjstva_services.dart';
import 'package:debtsettler_wear/Services/Uporabniki_services.dart';
import 'package:flutter/material.dart';
import 'package:wear/wear.dart';
import 'package:debtsettler_wear/constants.dart' as Constants;


class SeznamGospodinjstevScreen extends StatefulWidget {
  const SeznamGospodinjstevScreen({Key? key}) : super(key: key);

  @override
  State<SeznamGospodinjstevScreen> createState() => _SeznamGospodinjstevScreenState();
}

class _SeznamGospodinjstevScreenState extends State<SeznamGospodinjstevScreen> {

  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Center(
              child: FutureBuilder<List<GospodinjstvoModel>>(
                future: Constants.mode == "demo" ? preberiGospodinjstva() : getGospodinjstva(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                    final List<GospodinjstvoModel>? posts = snapshot.data;
                    return Column(
                      children: [
                        SizedBox(
                          width: screenSize.width,
                          height: screenSize.height*0.25,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            color: Colors.transparent,
                            child: const Center(
                              child: Text(
                                "Gospodinjtsva:",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: posts?.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: screenSize.height*0.25,
                                child: InkWell(
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    color: Colors.grey[700],
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          child: Icon(Icons.house_outlined, color: Colors.white,),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          child: Text(posts![index].imeGospodinjstva, style: const TextStyle(color: Colors.white),),
                                          flex: 2,
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                        return PrikazNakupoavlneListeScreen(gospodinjstvoKey: posts[index].gsToken,);
                                      }),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    );
                  } else {
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        height: screenSize.height*0.5,
                      ),
                    );
                  }
                },
              )
          ),
        )
    );
  }
}

