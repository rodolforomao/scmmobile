import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DocumentosPage extends StatefulWidget {


  @override
  _DocumentosPage createState() => _DocumentosPage();
}

class _DocumentosPage extends State<DocumentosPage> {


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
            "Documentos",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 19.0,
                color: Color(0xffFFFFFF),
                fontFamily: "open-sans-regular"),
          ),
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

            ],
          ),
        ),
      ),
    );
  }
}
