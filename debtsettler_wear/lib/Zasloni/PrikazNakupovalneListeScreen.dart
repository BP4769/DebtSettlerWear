import 'package:debtsettler_wear/Modeli/Izdelek_model.dart';
import 'package:debtsettler_wear/Modeli/Uporabnik_model.dart';
import 'package:debtsettler_wear/Zasloni/PrikazUporabnikovScreen.dart';
import 'package:debtsettler_wear/Storitve/NakupovalnaLista_services.dart';
import 'package:debtsettler_wear/Storitve/Uporabniki_services.dart';
import 'package:flutter/material.dart';
import 'package:wear/wear.dart';
import 'package:debtsettler_wear/konstante.dart' as Constants;


class PrikazNakupoavlneListeScreen extends StatefulWidget {
  const PrikazNakupoavlneListeScreen({
    Key? key,
    required this.gospodinjstvoKey,
  }) : super(key: key);

  final String gospodinjstvoKey;

  @override
  State<PrikazNakupoavlneListeScreen> createState() => _PrikazNakupoavlneListeScreenState();
}

class _PrikazNakupoavlneListeScreenState extends State<PrikazNakupoavlneListeScreen> {

  late Future<List<Izdelek>> izdelki;
  late final String gospodinjstvoKey = widget.gospodinjstvoKey;


  @override
  void initState() {
    super.initState();

    // initial load
    izdelki = Constants.mode == "demo" ? preberiIzdelke(gospodinjstvoKey:gospodinjstvoKey) : getIzdelki(gospodinjstvoKey:gospodinjstvoKey);
  }

  Future<void> _refreshList() async {
    // reload
    setState(() {
      izdelki = Constants.mode == "demo" ? preberiIzdelke(gospodinjstvoKey:gospodinjstvoKey) : getIzdelki(gospodinjstvoKey:gospodinjstvoKey);
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
              child: FutureBuilder<List<Izdelek>>(
                future: izdelki,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                    final List<Izdelek>? posts = snapshot.data;
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: posts!.length+2,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              if (index >= posts.length+1) {
                                if (posts.isEmpty) {
                                  return SizedBox(
                                    height: screenSize.height*0.50,
                                    child: const Center(
                                      child: Text("Nothing here yet", style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),),
                                    ),
                                  );
                                } else if (posts.any((item) => item.isSelected)) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: InkWell(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        child: const Icon(Icons.delete, color: Colors.white,),
                                        height: screenSize.height*0.33,
                                      ),
                                      onTap: () {
                                        late List<Izdelek> deletedItems = [];

                                        setState(() {
                                          for(int i = posts.length - 1; i >= 0; i--) {
                                            if (posts[i].isSelected) {
                                              deletedItems.add(posts[i]);
                                            }
                                          }
                                          posts.removeWhere((item) => item.isSelected);
                                          izbrisiIzdelke(deletedItems, gospodinjstvoKey);
                                        });
                                      },
                                    ),
                                  );
                                } else {
                                  return SizedBox(height: screenSize.height*0.33,);
                                }
                              } else if (index == 0) {
                                return SizedBox(
                                    width: screenSize.width,
                                    height: screenSize.height*0.25,
                                    child: ButtonBar(
                                      alignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.supervisor_account, color: Colors.white,),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(builder: (context) {
                                                return PrikazUporabnikovScreen(gospodinjstvoKey: widget.gospodinjstvoKey,);
                                              }),
                                            );
                                          },
                                        ),
                                        IconButton(
                                          color: Colors.blue,
                                          icon: Icon(Icons.list, color: Colors.white,),
                                          onPressed: () { _refreshList();},
                                        ),
                                      ],
                                    )
                                );
                              } else {
                                return Container(
                                    height: screenSize.height*0.25,
                                    child: InkWell(
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          color: posts[index-1].isSelected ? Colors.green : Colors.grey[700],
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(posts[index-1].izdelekKolicina.toString(), style: const TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                                                flex: 1,
                                              ),
                                              Expanded(
                                                child: Text(posts[index-1].izdelekIme, style: const TextStyle(color: Colors.white),),
                                                flex: 3,
                                              ),
                                              Expanded(
                                                child: Checkbox(
                                                    value: posts[index-1].isSelected,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        posts[index-1].isSelected = !posts[index-1].isSelected;
                                                      });
                                                    }
                                                ),
                                                flex: 1,
                                              )
                                            ],
                                          )
                                      ),
                                      onTap: () {
                                        setState(() {
                                          posts[index-1].isSelected = !posts[index-1].isSelected;
                                        });
                                      },
                                    )
                                );
                              }
                            },
                          ),
                        ),
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