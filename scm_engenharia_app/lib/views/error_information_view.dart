import 'package:flutter/material.dart';
import 'package:scm_engenharia_app/models/global_user_logged.dart' as global_user_logged;

class ErrorInformationView extends StatefulWidget {
  Map<String, dynamic> map;
  ErrorInformationView({Key? key, required this.map, }) : super(key: key);

  @override
  ErrorInformationState createState() => ErrorInformationState();
}

class ErrorInformationState extends State<ErrorInformationView> {

  String informacao = '';
  String originPage = '';

  @override
  void initState() {
    super.initState();
    Future(() {
     // final arg = ModalRoute.of(context)!.settings.arguments as Map;
     // informacao = arg['view'];
     // originPage = arg['error'];
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
                widget.map['error'] ?? '--',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 15.0,
                    color: Color(0xff575757),
                    fontFamily: "avenir-lt-medium"),
              ),
              const SizedBox(height: 40.0),
              Center(
                child: InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0.0, 5.0, 20.0, 0.0),
                    constraints: const BoxConstraints(maxWidth: 300),
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                        color: Color(0xff8854d0)),
                    child: const Text(
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
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

}
