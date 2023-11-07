import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../help/components.dart';
import '../../help/navigation_service/route_paths.dart' as routes;
import '../../help/parameter_result_view.dart';
import '../../models/info_app.dart';
import '../../thema/app_thema.dart';
import '../help_views/global_scaffold.dart';
import 'package:scm_engenharia_app/models/global_user_logged.dart' as global_user_logged;

import '../help_views/global_view.dart';
class SobreView extends StatefulWidget {
  const SobreView({Key? key}) : super(key: key);
  @override
  SobreState createState() => SobreState();
}

class SobreState extends State<SobreView> with ParameterResultViewEvent {

  TypeView statusView = TypeView.viewLoading;
  InfoApp infoApp = InfoApp();

  onSendEmail() async {
    try {
      final Uri params = Uri(
        scheme: 'mailto',
        path:
        'rodolforomao@gmail.com',
        query: 'subject=APP scmengenharia&body=Escreva aqui seu comentário, dúvida ou sugestão. \r\n \r\n As seguintes informações podem nos ajudar a resolver o seu problema: \r\n Build : ${infoApp.buildNumber!} \r\n Versão : ${infoApp.version!} \r\n Dispositivo : ${infoApp.device!} \r\n \r\n ',
      );
      launchUrl(params);
    } catch (error) {
      GlobalScaffold.instance.onToastError(error.toString());
    }
  }

  onInc() async {
    try {
      setState(() {statusView = TypeView.viewLoading;});
      InfoApp repInfoApp = await Components.onInfo();
      setState(() {
        infoApp = repInfoApp;
        statusView = TypeView.viewRenderInformation;
      });
    } catch (error) {
      Map<String, dynamic> map = {'view' : routes.sobreRoute, 'error' : error};
      Navigator.of(context).pushNamed(
        routes.errorInformationRoute,
        arguments: map,
      ).then((value) {
        onInc();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    onInc();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: AppBar(
          centerTitle: true,
          flexibleSpace: Container(
            decoration: StylesThemas.boxDecorationAppBar,
          ),
          title: const Text(
            'Configurações',
          ),
          toolbarHeight: 50,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: viewType(MediaQuery.of(context).size.height),
    );
  }

  viewType(double maxHeight) {
    switch (statusView) {
      case TypeView.viewLoading:
        return GlobalView.viewPerformingSearch(maxHeight,context);
      case TypeView.viewErrorInformation:
        return GlobalView.viewErrorInformation(maxHeight,erroInformation,context);
      case TypeView.viewRenderInformation:
        return SingleChildScrollView(
            padding: const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0, bottom: 10.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: Container(
                  padding: const EdgeInsets.only(top: 10.0, right: 15.0, left: 15.0, bottom: 10.0),
                  constraints:  BoxConstraints(
                    minHeight: 500,
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  alignment: Alignment.topCenter,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height -140,
                  child:SingleChildScrollView(child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textDirection: TextDirection.ltr,
                    children: <Widget>[
                      Padding(padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 10.0),child: Text(
                        'Sobre',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 20,color:  Colors.black, fontWeight: FontWeight.w600,),
                      ),),
                      const Padding(padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),child: Divider(color:Colors.black54),),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        textDirection: TextDirection.ltr,
                        children: <Widget>[
                          Padding( padding: const EdgeInsets.only(top: 20.0, bottom: 10.0) ,child:RichText(
                              textAlign: TextAlign.start,
                              softWrap: false,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Nome Aplicativo :',
                                    style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 18)
                                ),
                                TextSpan(
                                    text: '  ${infoApp.appName!}  ',
                                    style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 20,color: Color(0xff262626))
                                ),
                              ])),),
                          Padding( padding: const EdgeInsets.only(top: 10.0, bottom: 10.0) ,child: RichText(
                              textAlign: TextAlign.start,
                              softWrap: false,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Build : ',
                                    style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 18)
                                ),
                                TextSpan(
                                    text: '  ${infoApp.buildNumber!}  ',
                                    style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 20,color: Color(0xff262626))
                                ),
                              ])),),
                          Padding( padding: const EdgeInsets.only(top: 10.0, bottom: 10.0) ,child: InkWell(
                            child: RichText(
                                textAlign: TextAlign.start,
                                softWrap: false,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: 'Versão :  ',
                                      style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 18)
                                  ),
                                  TextSpan(
                                      text: '  ${infoApp.version!}  ',
                                      style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 20,color: Color(0xff262626))
                                  ),
                                ])),
                            onTap: () async {

                            },
                          ),),
                          Padding( padding: const EdgeInsets.only(top: 10.0, bottom: 10.0) ,child:  RichText(
                              textAlign: TextAlign.start,
                              softWrap: false,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Dispositivo : ',
                                    style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 18)
                                ),
                                TextSpan(
                                    text: '  ${infoApp.deviceVersion!}  ',
                                    style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 20,color: Color(0xff262626))
                                ),
                              ])),),
                          Padding( padding: const EdgeInsets.only(top: 10.0, bottom: 10.0) ,child:  RichText(
                              textAlign: TextAlign.start,
                              softWrap: false,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'ID do Dispositivo : ',
                                    style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 18)
                                ),
                                TextSpan(
                                    text: '  ${infoApp.idDevice!}  ',
                                    style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 20,color: Color(0xff262626))
                                ),
                              ])),),
                          Center(child: Container(
                            alignment: Alignment.center,
                            constraints: const BoxConstraints(
                              minHeight: 300,
                              maxWidth: 900,
                            ),
                            padding: const EdgeInsets.only(top: 10.0, right: 15.0, left: 15.0),
                            child: Card(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 5.0),
                                    child:  RichText(
                                        textAlign: TextAlign.center,
                                        text:   TextSpan(children: [
                                          TextSpan(
                                            text:
                                            'Este canal é exclusivo para dúvidas, sugestões e reclamações sobre o ',
                                            style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 18),
                                          ),
                                          TextSpan(
                                            text: 'APLICATIVO',
                                            style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 18),
                                          ),
                                        ])),
                                  ),
                                  Padding( padding: const EdgeInsets.only(top: 20.0, bottom: 20.0) ,child: Center(
                                    child: TextButton.icon(
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
                                        minimumSize: const Size(250, 47),
                                        maximumSize: const Size(250, 47),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:  BorderRadius.circular(5.0),
                                        ),
                                      ),
                                      onPressed: () async {
                                        onSendEmail();
                                      },
                                      label:  const Text(' Enviar comentário ', style:  TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins-Regular',
                                        color: Color(0xFFffffff),
                                      ),),
                                      icon: const Padding(
                                        padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                                        child: Icon(
                                          Icons.email_outlined,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),),
                                ],
                              ),
                            ),
                          ),)
                        ],
                      ),
                    ],
                  ),)),));
      case TypeView.viewThereIsNoInternet:
        // TODO: Handle this case.
    }
  }
}
