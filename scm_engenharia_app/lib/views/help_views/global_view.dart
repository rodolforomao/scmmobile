import 'dart:io';
import 'package:flutter/cupertino.dart';
import '../../help/components.dart';
import '../../help/navigation_service/route_paths.dart' as routes;
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'global_scaffold.dart';

BuildContext? dialogContext;

class GlobalView  {

  static viewResponsiveGridTextField(BuildContext context,int itemCount,double maxCrossAxisExtent, List itemBuilder) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: itemCount,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: maxCrossAxisExtent,
        //childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.4),
        mainAxisExtent: 80,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
      ),
      itemBuilder: (context, index) {
        return itemBuilder[index];
      },
    );
  }

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
                child: Theme(
                  data: Theme.of(context).copyWith( colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xfff5821f))),
                  child: const CircularProgressIndicator(),
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
                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 17),
              ),
            ),
            const SizedBox(height: 25.0),
          ],
        ),
      ),
    );
  }

}

class OnExitApp {
  final BuildContext context;
  OnExitApp(this.context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(25.0),
            constraints: const BoxConstraints(
              minWidth: 70,
              maxWidth: 450,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
                  height: 50.0,
                  child: const Text(
                    'Deseja realmente sair?',
                    textAlign: TextAlign.start,
                    softWrap: false,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 400,
                  ),
                  margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child:  OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: const Color(0xFFffffff),
                              side: const BorderSide(
                                color: Color(0xFF3F7EC1), //Color of the border
                              ),
                            ),
                            onPressed: () async {
                              try {
                                Components.logoffApp();
                              } catch (error) {
                                OnRealizandoOperacao('', false, context);
                                GlobalScaffold.instance.onToastInformacaoErro(error.toString());
                              }
                            },
                            child: const Text('  Sim  ',
                                style: TextStyle(
                                  color: Color(0xFF3F7EC1),
                                )),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: OutlinedButton(
                            onPressed: () async {
                              try {
                                Navigator.pop(context);
                              } catch (error) {
                                GlobalScaffold.instance.onToastInformacaoErro(error.toString());
                              }
                            },
                            child: const Text('  Não  ',
                                style: TextStyle(
                                  color: Color(0xFFffffff),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}