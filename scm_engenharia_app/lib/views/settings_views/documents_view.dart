import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DocumentsView extends StatefulWidget {
  const DocumentsView({Key? key}) : super(key: key);
  @override
  DocumentsState createState() => DocumentsState();
}

class DocumentsState extends State<DocumentsView> {


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
          flexibleSpace: Container(
            decoration: const BoxDecoration(
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
          title: const Text(
            "Documentos",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 19.0,
                color: Color(0xffFFFFFF),
                fontFamily: "open-sans-regular"),
          ),
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

            ],
          ),
        ),
      ),
    );
  }
}
