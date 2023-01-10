import 'package:flutter/material.dart';
import 'package:scm_engenharia_app/models/global_user_logged.dart' as global_user_logged;
import '../thema/app_thema.dart';
import 'help_views/global_scaffold.dart';
import 'dart:async';
import 'help_views/global_view.dart';

class ErroInformacaoView extends StatefulWidget {
  Map<String, dynamic> map;
  ErroInformacaoView({Key? key, required this.map, }) : super(key: key);
  @override
  ErrorInformationState createState() => ErrorInformationState();
}

class ErrorInformationState extends State<ErroInformacaoView> {

  selecionarPopupMenuButton() => PopupMenuButton(
    icon: const Icon(Icons.more_vert, color: Color(0xFFFFFFFF), size: 25),
    onSelected: (value) async {
      try {
        switch (value) {
          case 1:
            {
              if(global_user_logged.globalUserLogged != null)
              {
                OnExitApp(context,global_user_logged.globalUserLogged!.cpf);
              }
            }
            break;
          case 2:
            {

            }
            break;
        }
      } catch (error) {
        GlobalScaffold.instance.onToastError(error.toString());
      }
    },
    itemBuilder: (cxt) => [
      PopupMenuItem(
        value:1,
        child:  Container(
          width: 170,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              Icon(Icons.exit_to_app, size: 23, color: Color(0xFF424242)),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'Sair ',
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  @override
  void initState() {
    super.initState();
    Future(() {

    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informação'),
        toolbarHeight: 55,
        flexibleSpace: Container(
          decoration: StylesThemas.boxDecorationAppBar,
        ),
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          global_user_logged.globalUserLogged == null ? Container() :   IconButton(
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
              size: 22,
            ),
            onPressed: () {
              selecionarPopupMenuButton();
            },
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 40.0,
              ),
              Image.asset(
                'assets/img/img_informacao.png',
                width: 150.0,
                height: 150.0,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                height: 40.0,
              ),
              Text(
                widget.map['error'].toString() ?? '--',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16,color:  Color(0xff575757), fontWeight: FontWeight.w600,),
              ),
              const SizedBox(height: 40.0),

              Center(
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    elevation: 0,
                    backgroundColor: const Color(0xffef7d00),
                    padding: const EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 3.0),
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
                      'TENTAR NOVAMENTE',
                      style:  TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

}
