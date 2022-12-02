import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../models/info_app.dart';
import 'help_views/global_view.dart';




class AboutAppView extends StatefulWidget {
  const AboutAppView({Key? key}) : super(key: key);
  @override
  AboutAppState createState() => AboutAppState();
}

class AboutAppState extends State<AboutAppView> {

  InfoApp infoApp = InfoApp();

  onInfo() async {
    infoApp = InfoApp();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if(kIsWeb)
    {
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      infoApp.device = webBrowserInfo.userAgent;
    }
    else
    {
      if(Platform.isAndroid)
      {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        infoApp.device = androidInfo.model;
      }
      else if(Platform.isIOS)
      {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        infoApp.device = iosInfo.utsname.machine;
      }
      else if(Platform.isMacOS) {
        infoApp.device =  'macos';
      } else if(Platform.isLinux) {
        infoApp.device =  'linux';
      } else if(Platform.isWindows) {
        infoApp.device =  'windows';
      } else if(Platform.isFuchsia) {
        infoApp.device =  'fuchsia';
      } else {
        infoApp.device = 'outros';
      }
    }
    infoApp.appName = packageInfo.appName;
    infoApp.buildNumber  = packageInfo.buildNumber;
    infoApp.version = packageInfo.version;
    if(kIsWeb)
    {
      infoApp.appName = 'SCM Engenharia';
      infoApp.buildNumber  = packageInfo.buildNumber;
      infoApp.version = packageInfo.version;
      return infoApp;
    }
    if(Platform.isAndroid)
    {
      infoApp.buildNumber = packageInfo.version;
      infoApp.version = packageInfo.buildNumber;
    }
    if(Platform.isIOS)
    {
      infoApp.version = packageInfo.version;
      infoApp.buildNumber = packageInfo.buildNumber;
    }
    return infoApp;
  }

  @override
  void initState() {
    super.initState();
    Future(() async {
      onInfo();
      setState(() {
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: AppBar(
          centerTitle: true,
          title: const Text(
            'Sobre',
          ),
        ),
      ),
      body: Padding(padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0), child: GlobalView.viewRenderSingleChildScrollView(
          MediaQuery.of(context).size.height,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20.0),
              RichText(
                  textAlign: TextAlign.start,
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(children: [
                    const TextSpan(
                      text: 'Nome aplicativo : ',
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xff656665)),
                    ),
                    TextSpan(
                      text: infoApp.appName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Color(0xff093d6c)),
                    ),
                  ])),
              const SizedBox(height: 20.0),
              RichText(
                  textAlign: TextAlign.start,
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(children: [
                    const TextSpan(
                      text: 'Versão : ',
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xff656665)),
                    ),
                    TextSpan(
                      text: infoApp.version,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Color(0xff093d6c)),
                    ),
                  ])),
              const SizedBox(height: 20.0),
              RichText(
                  textAlign: TextAlign.start,
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(children: [
                    const TextSpan(
                      text: 'Build : ',
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xff656665)),
                    ),
                    TextSpan(
                      text: infoApp.buildNumber,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Color(0xff093d6c)),
                    ),
                  ])),
              const SizedBox(height: 20.0),
              InkWell(
                child: RichText(
                    textAlign: TextAlign.start,
                    softWrap: false,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(children: [
                      const TextSpan(
                        text: 'Versão do aplicativo :  ',
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Color(0xff656665)),
                      ),
                      TextSpan(
                        text: infoApp.buildNumber,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            decoration: TextDecoration.underline,
                            color: Color(0xff093d6c)),
                      ),

                    ])),
                onTap: () async {
                  //onAppStoreLink();
                },
              ),
              const SizedBox(height: 20.0),
              RichText(
                  textAlign: TextAlign.start,
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(children: [
                    const TextSpan(
                      text: 'Dispositivo : ',
                      style: TextStyle(
                          fontFamily: 'Myriad-Pro-Light',
                          fontSize: 14.0,
                          color: Color(0xff656665)),
                    ),
                    TextSpan(
                      text: infoApp.device,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Myriad-Pro-Light',
                          fontSize: 20.0,
                          color: Color(0xff093d6c)),
                    ),
                  ])),
              const SizedBox(height: 30.0),
              Card(
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                      child:  RichText(
                          textAlign: TextAlign.center,
                          text:  const TextSpan(children: [
                            TextSpan(
                              text:
                              'Este canal é exclusivo para dúvidas, sugestões e reclamações sobre o ',
                              style: TextStyle(
                                fontFamily: 'Myriad-Pro-Light',
                                fontWeight: FontWeight.bold,
                                fontSize: 19.0,
                                color: Color(0xff737373),
                              ),
                            ),
                            TextSpan(
                              text: 'APLICATIVO',
                              style: TextStyle(
                                fontFamily: 'Myriad-Pro-Light',
                                fontWeight: FontWeight.bold,
                                fontSize: 19.0,
                                color: Color(0xff737373),
                              ),
                            ),
                          ])),
                    ),
                    const SizedBox(height: 20.0),
                    Center(
                      child: TextButton.icon(
                        onPressed: () async {

                        },
                        label: const Padding(
                          padding:
                          EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                          child: Text(' Enviar comentário ',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,
                          ),
                        ),
                        icon: const Padding(
                          padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                          child: Icon(
                            Icons.email_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
          context),),
    );
  }

}
