import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scm_engenharia_app/views/splash_screen_view.dart';


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
    return new Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color(0xFFF65100),
                  Color(0xFFf5821f),
                  Color(0xFFff8c49),
                ],
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            "Informação",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 19.0,
                color: Color(0xffFFFFFF),
                fontFamily: "open-sans-regular"),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
                size: 22,
              ),
              onPressed: () {

              },
            )
          ],
        ),
        preferredSize: new Size(MediaQuery.of(context).size.width, 50.0),
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
                style: TextStyle(
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
