import 'dart:convert';
import 'dart:async';
import 'dart:typed_data';

import 'package:deneme/Link.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Model.dart';
import 'package:flutter/services.dart';

late String no = "1001001";
var url = Uri.parse('http://192.168.0.239:8080/ords/pba/pqmapk/getNextNumber?P_IdGise=$no');
late String Url = url.toString();
var tfconrtol = TextEditingController();
late int sCode;
late String href;
String? rel;
late String str1;
late String str2;
late String str3;
late String str4;
String? decoded;
String? regexxed;


String? gise;
String? subeler;
void main() {

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sıra Takip Sistemi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(),
    );
  }

}


class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String? counter;
  int? a;
  late var modelResult;
  bool isStopped = false;


  Future call(Uri url) async {
    try {
      var response = await http.get(url);

      str1 = Url[Url.length - 1];
      str2 = Url[Url.length - 2];
      str3 = Url[Url.length - 3];
      str4 = Url[Url.length - 4];
      gise = str2 + str1;
      subeler = str4 + str3;



      if (response.statusCode == 200) {
        var result = modelFromJson(response.body);

        setState(() {
          counter = result.pGiseno.toString();
          rel = result.links[0].rel;
          href = result.links[0].href;
        });

        sCode=200;
        return result;
      } else {
        print(response.statusCode);
        sCode=response.statusCode;
        print("Hata !");
      }
    } catch (e) {
      print(e.toString());
      sCode=400;
      print("Hata !");
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    secTimer();
   // call(url);
    //print(a);
    super.initState();
  }

  secTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (isStopped) {
        timer.cancel();
      }
      call(url);
      //print("veriler güncellendi");
    });
  }





  showAlertDialog(BuildContext context) {

// set up the button
    Widget okButton = TextButton(
      child: Text("Tamam"),
      onPressed: () async {
        String AlinanVeri = tfconrtol.text;
        no = AlinanVeri;

        if(no.length==7) {
          var url1 = url;

          url = Uri.parse('http://192.168.0.239:8080/ords/pba/pqmapk/getNextNumber?P_IdGise=$no');
          Url = url.toString();
          //print(url);
          await call(url);

          print(sCode);
          print(url);

          if (sCode != 200) {
            url=url1;
            print(url);
            Url = url.toString();
            str1 = Url[Url.length - 1];
            str2 = Url[Url.length - 2];
            str3 = Url[Url.length - 3];
            str4 = Url[Url.length - 4];
            gise = str2 + str1;
            subeler = str4 + str3;
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("! HATA !"),
                  content: Text("Girdiğiniz gişe numarasına ait bir gişe bulunamadı"),
                  actions: [
                    TextButton(
                      child: Text("Tamam"),
                      onPressed: () {
                        Navigator.pop(context);
                      },

                    ),
                  ],
                );
              },
            );

          } else {

            Navigator.pop(context);
          }

        }else{
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("! HATA !"),
                  content: Text("Eksik veya Fazla giriş yaptınız."),
                  actions: [
                    TextButton(
                      child: Text("Tamam"),
                      onPressed: () {
                        Navigator.pop(context);
                      },

                    ),


                  ],
                );
              },
            );
          }
       // Navigator.pop(context);
        }

    );

    Widget cancelButton = TextButton(
      child: Text("İptal"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(

      title: Text("WebService Adresi"),
      content: SizedBox(
        height: 80,
          child: Column(
            children: [
              TextField(
                controller: tfconrtol,
                decoration: InputDecoration(
                  labelText: "Veri",
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              )
            ],
          )
      ),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
 }



    @override
    Widget build(BuildContext context) {
      return Scaffold( // ******************   tasarım kısmı

        /*
        appBar: AppBar(             // isteğe göre AppBar eklenebilir
          backgroundColor: Colors.indigo,
          title: Text("AS BANK SIRA TAKİP SİSTEMİ",
            style: TextStyle(
                color: Colors.white
            ),
          ),
          centerTitle: true,
        ),
        */

        body: SingleChildScrollView(
        child: Center(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[

              /*
              Container(
                margin: const EdgeInsets.only(
                    top: 10.0, left: 20.0, right: 20.0),
                height: MediaQuery.of(context).size.height*0.17 ,
                width: 550,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(width: 3),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue.shade300,

                ),
                child: Text("Şube: $subeler",
                  style: const TextStyle(
                      fontSize: 70, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              */

              SizedBox(height: 15),
              Container(
                margin: const EdgeInsets.only(
                    top: 30.0, left: 20.0, right: 20.0),
                height: MediaQuery.of(context).size.height*0.3,
                width: 550,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(width: 3),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue.shade300,
                ),
                child: Text("Gişe: $gise", //
                  style: const TextStyle(
                      fontSize: 70, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: 5),
              Divider(
                height: 10,
                color: Colors.grey,
                thickness: 2,
              ),

              Container(
                margin: const EdgeInsets.only(
                    top: 5.0, left: 20.0, right: 20.0,bottom: 5.0),
                height: MediaQuery.of(context).size.height*0.3,
                width: 550,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(width: 3),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue.shade300,
                ),
                child: Text("Sıra: $counter",
                  style: const TextStyle(
                      fontSize: 70 , color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),

              Divider(
                height: 10,
                color: Colors.grey,
                thickness: 2,
              ),

              SizedBox(height: 50),

              Container(
                child: GestureDetector(
                onDoubleTap: () {
                  //print("double tap");
                  showAlertDialog(context);
                  call(url);
                },
                  child: Image.memory(base64Decode(regexxed!),
                      fit: BoxFit.contain,
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.3),
                ),

              ),


             /* children: GestureDetector(
                onDoubleTap: () {
                  //print("double tap");
                  showAlertDialog(context);
                  call(url);
                },
                child: Image.asset(
                    "resimler/logo.png", width: MediaQuery.of(context).size.height*0.25, height: MediaQuery.of(context).size.height*0.25),
              ),*/

            ],

          ),


        ),

        ),
      );
    }

}
