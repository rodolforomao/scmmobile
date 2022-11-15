import '../../help/components.dart';
import '../../help/navigation_service/route_paths.dart' as routes;
import 'package:flutter/material.dart';
import 'global_scaffold.dart';

class GlobalView  {
  static viewResponsiveGridTextField(BuildContext context,int itemCount,double maxCrossAxisExtent, List itemBuilder) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: itemCount,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
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

  static viewRenderSingleChildScrollView(maxHeight,child, context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topCenter,
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(
          minHeight: maxHeight,
          maxWidth: MediaQuery.of(context).size.width,
        ),
        child: child,
      ),
    );
  }

  static maxHeightAppBar(BuildContext context,double height) {
    return (MediaQuery.of(context).size.height - height) - MediaQuery.of(context).padding.top;
  }
}

class OnExitApp {
  String? cpf;
  final BuildContext context;
  OnExitApp(this.context,cpf) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            constraints: const BoxConstraints(
              minWidth: 70,
              maxWidth: 450,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              textDirection: TextDirection.ltr,
              children: [
                Padding(padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 6.0),child: Text(
                  'Configurações',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 12,color:  Colors.black, fontWeight: FontWeight.w600,),
                ),),
                const Padding(padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 10.0),child: Divider(color:Colors.black54),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
                      height: 40.0,
                      child: const Text(
                        'Deseja realmente sair?',
                        textAlign: TextAlign.start,
                        softWrap: false,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFF000000),
                            fontFamily: 'Poppins-Medium'
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
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(250, 45),
                                  maximumSize: const Size(250, 45),
                                  side: const BorderSide(
                                    color: Color(0xFF828282), //Color of the border
                                    style: BorderStyle.solid, //Style of the border
                                    width: 1.0, //width of the border
                                  ),
                                  backgroundColor: Color(0xFF828282),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                ),
                                onPressed: () async {
                                  try {
                                    Components.logoffApp(cpf);
                                  } catch (error) {
                                    OnRealizandoOperacao('',context);
                                    GlobalScaffold.instance.onToastError(error.toString());
                                  }
                                },
                                child: const Text('  Sim  ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15.0,
                                      fontFamily: 'Poppins-Regular',
                                      color: Color(0xFFffffff),
                                    )),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 14.0),
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(250, 45),
                                  maximumSize: const Size(250, 45),
                                ),
                                onPressed: () async {
                                  try {
                                    Navigator.pop(context);
                                  } catch (error) {
                                    GlobalScaffold.instance.onToastError(error.toString());
                                  }
                                },
                                child: const Text('  Não  ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15.0,
                                      fontFamily: 'Poppins-Regular',
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
              ],
            ),
          ),
        );
      },
    );
  }
}