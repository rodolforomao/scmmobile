import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scm_engenharia_app/help/global_user_logged.dart' as global_user_logged;


class ErrorInformationView extends StatefulWidget {
  String informacao;
  String originPage;
  ErrorInformationView({Key? key, required this.informacao, required this.originPage}) : super(key: key);

  @override
  ErrorInformationState createState() => ErrorInformationState();
}

class ErrorInformationState extends State<ErrorInformationView> {

  @override
  void initState() {
    super.initState();
    Future(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 50.0),
        child: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: const Text(
            'Informação',
          ),
          actions: <Widget>[
            global_user_logged.globalUserLogged == null ? Container() :   IconButton(
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
                size: 22,
              ),
              onPressed: () {

              },
            ),
          ],
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 40.0,
              ),
              Image.asset(
                "assets/imagens/img_informacao.png",
                width: 150.0,
                height: 150.0,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                widget.informacao,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 15.0,
                    color: Color(0xff575757),
                    fontFamily: "avenir-lt-medium"),
              ),
              SizedBox(height: 40.0),
              Center(
                child: InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0.0, 5.0, 20.0, 0.0),
                    constraints: BoxConstraints(maxWidth: 300),
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                        color: Color(0xff8854d0)),
                    child: Text(
                      'TENTAR NOVAMENTE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'avenir-lt-std-roman',
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
