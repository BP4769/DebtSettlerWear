import 'package:debtsettler_wear/Models/Uporabnik_model.dart';
import 'package:debtsettler_wear/Services/Uporabniki_services.dart';
import 'package:flutter/material.dart';
import 'package:wear/wear.dart';
import 'package:debtsettler_wear/constants.dart' as Constants;


class PrikazUporabnikovScreen extends StatefulWidget {
  const PrikazUporabnikovScreen({
    Key? key,
    required this.gospodinjstvoKey,
  }) : super(key: key);

  final String gospodinjstvoKey;

  @override
  State<PrikazUporabnikovScreen> createState() => _PrikazUporabnikovScreenState();
}

class _PrikazUporabnikovScreenState extends State<PrikazUporabnikovScreen> {
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          child: FutureBuilder<List<Uporabnik>>(
            future: Constants.mode == "demo" ? preberiUporabnike(gospodinjstvoKey: widget.gospodinjstvoKey) : getUporabnikiGospodinjstva(gospodinjstvoKey: widget.gospodinjstvoKey),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                final List<Uporabnik>? posts = snapshot.data;
                return PageView.builder(
                  itemCount: posts?.length,
                  controller: _controller,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: screenSize.height*0.15,),
                        const Expanded(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Icon(
                              Icons.account_circle,
                              color: Colors.white,
                            ),
                          ),
                          flex: 2,
                        ),
                        SizedBox(height: screenSize.height*0.05,),
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              posts![index].ime,
                              style: const TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ),
                          flex: 3,
                        ),
                        SizedBox(height: screenSize.height*0.05,),
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              double.parse((posts[index].stanje).toStringAsFixed(2)).toString(),
                              style: TextStyle(
                                  color: posts[index].stanje>=0.0 ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          flex: 2,
                        ),
                        SizedBox(height: screenSize.height*0.15,),
                      ],
                    );
                  },
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

