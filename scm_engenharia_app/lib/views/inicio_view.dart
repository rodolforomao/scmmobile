
// ignore: avoid_web_libraries_in_flutter
//import 'dart:html';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../help/navigation_service/route_paths.dart' as routes;
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;



class InicioView extends StatefulWidget {
  const InicioView({Key? key}) : super(key: key);

  @override
  InicioState createState() => InicioState();
}

class InicioState extends State<InicioView>  {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS || defaultTargetPlatform == TargetPlatform.android) {
        await FirebaseMessaging.instance.subscribeToTopic('ScmEngenhariaNLogadoAll');
        await FirebaseMessaging.instance.subscribeToTopic('ScmEngenhariaAll');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.antiAlias, alignment: AlignmentDirectional.bottomCenter,
      fit: StackFit.loose,
      children: <Widget>[
        Image.asset(
            'assets/img/img_background.png',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
            colorBlendMode: BlendMode.dstIn
        ),
        Positioned(
          top: 50,
          child: Padding(padding: const EdgeInsets.fromLTRB(20.0,0.0,20.0,0.0), child: Image.asset(
              'assets/img/logo_white_horizontal.png',
              height: 60,
              fit: BoxFit.fill,
              colorBlendMode: BlendMode.dstIn
          ),),
        ),
        Positioned(
          top: 190,
          child: Padding( padding: const EdgeInsets.fromLTRB(50,10,50,10) ,child: RichText(
              textAlign: TextAlign.start,
              softWrap: false,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(children: [
                TextSpan(
                    text: 'Licenças de TV e telefonia para  seu \r\n',
                   style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 20,color:  Colors.white,),
                ),
                TextSpan(
                    text: 'Provedor. ',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith( fontSize: 25,color:  Colors.white, fontWeight: FontWeight.w800,),
                ),
              ])),),
        ),
        Positioned(
          top: 300,
          child: Padding( padding: const EdgeInsets.fromLTRB(50,10,50,10) ,child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10,0,10,0),
              height:15,
              width: 15,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100)
                //more than 50% of width makes circle
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10,0,10,0),
              height:15,
              width: 15,
              decoration: BoxDecoration(
                  color:  Color(0xff90FFFFFF),
                  borderRadius: BorderRadius.circular(100)
                //more than 50% of width makes circle
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10,0,10,0),
              height:15,
              width: 15,
              decoration: BoxDecoration(
                  color:  Color(0xff90FFFFFF),
                  borderRadius: BorderRadius.circular(100)
                //more than 50% of width makes circle
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10,0,10,0),
              height:15,
              width: 15,
              decoration: BoxDecoration(
                  color:  Color(0xff90FFFFFF),
                  borderRadius: BorderRadius.circular(100)
                //more than 50% of width makes circle
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10,0,10,0),
              height:15,
              width: 15,
              decoration: BoxDecoration(
                  color:  Color(0xff90FFFFFF),
                  borderRadius: BorderRadius.circular(100)
                //more than 50% of width makes circle
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10,0,10,0),
              height:15,
              width: 15,
              decoration: BoxDecoration(
                  color:  Color(0xff90FFFFFF),
                  borderRadius: BorderRadius.circular(100)
                //more than 50% of width makes circle
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10,0,10,0),
              height:15,
              width: 15,
              decoration: BoxDecoration(
                  color:  const Color(0xff90FFFFFF),
                  borderRadius: BorderRadius.circular(100)
                //more than 50% of width makes circle
              ),
            ),
          ],),),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          height: 220,
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50))),
          child: SizedBox(
            height: 100,
            child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  print("Click event on Container");
                },
                child: Column(
                  children:  <Widget>[
                    const Icon(Icons.search_outlined, color: Color(0xffef7d00),),
                    Padding( padding: const EdgeInsets.only(top: 10.0),child: Text('Análise',  style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 12,color:  Colors.black87, fontWeight: FontWeight.w500,))),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("Click event on Container");
                },
                child: Column(
                  children: <Widget>[
                    const Icon(Icons.warning, color: Color(0xffef7d00),),
                    Padding( padding: const EdgeInsets.only(top: 10.0),child: Text('Alertas',  style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 12,color:  Colors.black87, fontWeight: FontWeight.w500,))),

                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("Click event on Container");
                },
                child: Column(
                  children: <Widget>[
                    Icon(Icons.description, color: Color(0xffef7d00),),
                    Padding( padding: EdgeInsets.only(top: 10.0),child: Text('Recibos',   style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 12,color:  Colors.black87, fontWeight: FontWeight.w500,))),

                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("Click event on Container");
                },
                child: Column(
                  children:  <Widget>[
                    const Icon(Icons.inventory, size: 25, color: Color(0xffef7d00),),
                    Padding( padding: const EdgeInsets.only(top: 10.0),child: Text('Documentos',  style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 12,color:  Colors.black87, fontWeight: FontWeight.w500,))),

                  ],
                ),
              ),
            ],),),
        ),
        Positioned(
          bottom: 250,
          child: Padding(padding: const EdgeInsets.fromLTRB(20.0,0.0,20.0,0.0), child:  ElevatedButton(
            style: TextButton.styleFrom(
              elevation: 8,
              backgroundColor: const Color(0xffef7d00),
              padding: const EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 3.0),
              minimumSize: const Size(350, 50),
              maximumSize: const Size(350, 50),
              textStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color:  Color(0xffFFFFFF),
                fontSize: 15,
              ),
            ),
            child: const Padding(
              padding:
              EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
              child: Text(
                'Desejo abrir uma conta',
                style:  TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
            ),
            onPressed: () async {
              Navigator.of(context).pushNamed(
                routes.createNewAccountRoute,
              );
            },
          ),),
        ),
        Positioned(
          bottom: 190,
          child: Padding(padding: const EdgeInsets.fromLTRB(20.0,0.0,20.0,0.0), child:  TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xffFFFFFF),
              padding: const EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 3.0),
              elevation: 8,
              minimumSize: const Size(350, 50),
              maximumSize: const Size(350, 50),

            ),
            child: const Padding(
              padding:
              EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
              child: Text(
                'Acessar minha conta',
                style:  TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color:  Colors.black87,),
              ),
            ),
            onPressed: () async {
              Navigator.of(context).pushNamed(
                routes.loginRoute,
              );
            },
          ),),
        )
      ],
    );
  }

}



