// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jokes_for_geeks/models/jokes.dart';
import 'package:jokes_for_geeks/services.dart/jokes_services.dart';

class JokesPage extends StatefulWidget {
  const JokesPage({super.key});

  @override
  State<JokesPage> createState() => _JokesPageState();
}

class _JokesPageState extends State<JokesPage> {
  Color? bg_color, txt_color;

  String url = "any?safe-mode";
  int selected = 0;

  String _joke = "";
  String _jokeSetup = "";
  String _jokeDelivery = "";
  String _jokeCategory = "";

  void AnyJoke() async {
    var response = await getAnyJoke("https://v2.jokeapi.dev/joke/$url");
    if(response.error != null) {
      showDialog(context: context, builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text("${response.error}"),
        actions: <Widget>[
          TextButton(
            child: const Text("Close"),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ));
    } else {
      if(response.data["error"] == true){
        setState(() {
          _joke = "No jokes were found that match your provided filter(s).";
        });
      }
      else if(response.data["type"] == "twopart"){
        setState(() {
          _jokeSetup = response.data["setup"];
          _jokeDelivery = response.data["delivery"];
          _jokeCategory = response.data["category"];
        });
      }
      else {
        setState(() {
          _joke = response.data["joke"];
          _jokeCategory = response.data["category"];
        });
      }
    }

    switch(_jokeCategory){
      case "Pun":
      setState(() {
        bg_color = Colors.blue;
        txt_color = Colors.black;
      });
      break;

      case "Spooky":
      setState(() {
        bg_color = Colors.teal;
        txt_color = Colors.black;
      });
      break;

      case "Misc":
      setState(() {
        bg_color = Colors.yellow;
        txt_color = Colors.black;
      });
      break;

      case "Dark":
      setState(() {
        bg_color = Colors.black;
        txt_color = Colors.white;
      });
      break;

      case "Programming":
      setState(() {
        bg_color = Colors.grey;
        txt_color = Colors.black;
      });
      break;

      default:
      setState(() {
        bg_color = Colors.orange;
      });
    }
  }

  @override

  void initState() {
    super.initState();
    AnyJoke();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            constraints: const BoxConstraints.expand(width: double.infinity, height: double.infinity),  
            color: bg_color,
            child: _joke != "" ?
            Container(
              constraints: const BoxConstraints.expand(width: double.infinity),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _joke,
                    style: GoogleFonts.firaSans(
                      textStyle: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
            :
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Setup: $_jokeSetup",
                          style: GoogleFonts.firaSans(
                            textStyle: TextStyle(
                              decoration: TextDecoration.none,
                              color: txt_color,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Delivery: $_jokeDelivery",
                          style: GoogleFonts.firaSans(
                            textStyle: TextStyle(
                              decoration: TextDecoration.none,
                              color: txt_color,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "($_jokeCategory)",
                        style: GoogleFonts.rancho(
                          fontSize: 22,
                          letterSpacing: 1.5,
                          fontStyle: FontStyle.italic,
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                        )
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01, vertical: MediaQuery.of(context).size.height * 0.1),
            child: Wrap(
              direction: Axis.horizontal,
              children: category.map((cat) => Padding(
                padding: const EdgeInsets.all(3.5),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = cat.index;
                      url = cat.name;

                      AnyJoke();
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    padding: EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                    decoration: BoxDecoration(
                      color: selected != cat.index ? Colors.transparent : txt_color,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        cat.name,
                        style: GoogleFonts.rancho(
                          fontSize: 20,
                          color: selected != cat.index ? txt_color : bg_color,
                          letterSpacing: 1.2,
                        )
                      ),
                    ),
                  ),
                ),
              )).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          AnyJoke();
        },
        child: Icon(
          Icons.skip_next_outlined,
          color: Colors.black,
          size: 28,
        ),
      ),
    );
  }
}