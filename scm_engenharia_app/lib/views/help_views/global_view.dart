import 'dart:io';
import 'package:flutter/cupertino.dart';
import '../../help/navigation_service/route_paths.dart' as routes;
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';


class GlobalView  {

  static viewPerformingSearch(maxHeight, context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(
          minHeight: maxHeight,
          maxWidth: MediaQuery.of(context).size.width,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                margin: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                height: 100.0,
                width: 100.0,
                child: Image.asset(
                  'assets/img/geap_loading.gif',
                  height: 100.0,
                  width: 100.0,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              'Realizando  operação...',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Montserrat-Medium',
                  fontSize: 17.0,
                  color: Color(0xFF151515)),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  static viewErrorInformation(maxHeight,errorInformation, context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(
          minHeight: maxHeight,
          maxWidth: MediaQuery.of(context).size.width,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/img/img_informacao.png',
              width: 150.0,
              height: 150.0,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: Text(
                errorInformation,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 25.0),
          ],
        ),
      ),
    );
  }

}