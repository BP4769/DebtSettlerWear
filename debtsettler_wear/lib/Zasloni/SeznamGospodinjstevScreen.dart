import 'package:debtsettler_wear/Modeli/Gospodinjstvo_model.dart';
import 'package:debtsettler_wear/Modeli/Uporabnik_model.dart';
import 'package:debtsettler_wear/Zasloni/PrikazNakupovalneListeScreen.dart';
import 'package:debtsettler_wear/Zasloni/PrikazUporabnikovScreen.dart';
import 'package:debtsettler_wear/Storitve/Gospodinjstva_services.dart';
import 'package:debtsettler_wear/Storitve/Uporabniki_services.dart';
import 'package:flutter/material.dart';
import 'package:wear/wear.dart';
import 'package:debtsettler_wear/konstante.dart' as Constants;


class SeznamGospodinjstevScreen extends StatefulWidget {
  const SeznamGospodinjstevScreen({Key? key}) : super(key: key);

  @override
  State<SeznamGospodinjstevScreen> createState() => _SeznamGospodinjstevScreenState();
}

class _SeznamGospodinjstevScreenState extends State<SeznamGospodinjstevScreen> {

  late Future<List<Gospodinjstvo>> gospodinjstva;

  @override
  void initState() {
    super.initState();

    // initial load
    gospodinjstva = Constants.mode == "demo" ? preberiGospodinjstva() : getGospodinjstva();
  }

  Future<void> _refreshList() async {
    // reload
    setState(() {
      gospodinjstva = Constants.mode == "demo" ? preberiGospodinjstva() : getGospodinjstva();
    });
  }

  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Center(
              child: FutureBuilder<List<Gospodinjstvo>>(
                future: gospodinjstva,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                    final List<Gospodinjstvo>? posts = snapshot.data;
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
                            child: Center(
                              child: IconButton(
                                color: Colors.blue,
                                icon: const Icon(Icons.home, color: Colors.white,),
                                onPressed: () { _refreshList();},
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

