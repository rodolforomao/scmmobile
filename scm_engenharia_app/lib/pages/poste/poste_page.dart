import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:scm_engenharia_app/data/db_helper.dart';
import 'package:scm_engenharia_app/data/tb_uf.dart';
import 'package:scm_engenharia_app/help/masked_text_controller.dart';
import 'dart:async';
import 'package:scm_engenharia_app/pages/erro_informacao_page.dart';


class PostePage extends StatefulWidget {

  @override
  _PostePageState createState() => _PostePageState();
}

class _PostePageState extends State<PostePage> {

  DBHelper dbHelper;
  BuildContext dialogContext;
  String _StatusTipoWidget = "renderizar_informacao", ErroInformacao = "";


  List<TbUf> ListUfdb = new List<TbUf>();
  TbUf tbUf = TbUf();

  String id_uf = "0";
  String id_municipio = "0";
  String id_tecnologia = "0";

  TextEditingController _TxtControllerLocalizacaoLat = new MaskedTextController(mask: '-00.0000000');
  TextEditingController _TxtControllerLocalizacaoLong = new MaskedTextController(mask: '-00.0000000');
  TextEditingController _TxtControllerLocalizacaoDescricao = TextEditingController();

  TextEditingController _TxtControllerTamanhoResistencia = TextEditingController();
  TextEditingController _TxtControllerBarramento = TextEditingController();


  Future<Null> Inc() async {
    try {
      _determinePosition();
    } catch (error) {

    }
  }

  Future<Null> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _StatusTipoWidget = "erro_informacao";
        ErroInformacao = 'Os serviços de localização estão desativados.';
      });
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _StatusTipoWidget = "erro_informacao";
        ErroInformacao = 'As permissões de localização são negadas permanentemente, não podemos solicitar permissões.';
      });
    }
    else if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        setState(() {
          _StatusTipoWidget = "erro_informacao";
          ErroInformacao = 'As permissões de localização são negadas (valor real: $permission).';
        });
      }
    }
    else
    {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _TxtControllerLocalizacaoLat.text = position.latitude.toString();
      _TxtControllerLocalizacaoLong.text = position.longitude.toString();

    }
  }

  OnAlertaInformacao(String Mensagem) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 15.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Informação",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xff212529),
                        fontFamily: "avenir-lt-std-roman"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.black12,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                    child: Text(
                      Mensagem,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      softWrap: false,
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Color(0xff212529),
                          fontFamily: "avenir-lt-std-roman"),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.black12,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    FlatButton(
                      color: Color(0xff018a8a),
                      //`Icon` to display
                      child: Text(
                        '           OK           ',
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Color(0xffFFFFFF),
                            fontFamily: "avenir-lt-std-roman"),
                      ),
                      //`Text` to display
                      onPressed: () {
                        Navigator.pop(context);
                        FocusManager.instance.primaryFocus.unfocus();
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    Future.delayed(Duration.zero, () {
      if (dialogContext != null) {
        Navigator.pop(dialogContext);
        setState(() {
          dialogContext = null;
        });
      }
      Inc();
    });
  }

  @override
  void dispose() {
    try {

    } catch (exception, stackTrace) {
      print("exception.toString()");
      print(exception.toString());
    } finally {
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        centerTitle: false,
        elevation: 0.0,
        title: Text(
          "Poste",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 19.0,
              color: Color(0xffFFFFFF),
              fontFamily: "open-sans-regular"),
        ),
        actions: <Widget>[],
      ),
      body: _TipoWidget(context),
    );
  }

  _TipoWidget(BuildContext context) {
    switch (_StatusTipoWidget) {
      case "renderizar_informacao":
        {
          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());

                  },
                  controller: _TxtControllerLocalizacaoLat,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Latitude',
                    hintText: 'Latitude',
                  ),
                  maxLength: 11,
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _TxtControllerLocalizacaoLong,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  autofocus: false,
                  maxLength: 11,
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'nunito-regular',
                      color: const Color(0xFF000000)),
                  decoration: InputDecoration(
                    labelText: 'Longitude',
                    hintText: 'Longitude',
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _TxtControllerLocalizacaoDescricao,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  autofocus: false,
                  maxLength: 100,
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'nunito-regular',
                      color: const Color(0xFF000000)),
                  decoration: InputDecoration(
                    labelText: 'Descrição endereço',
                    hintText: 'Descrição endereço',
                  ),
                ),
                SizedBox(height: 20.0),
                Divider(),
                SizedBox(height: 20.0),
                Container(
                  height: 58.0,
                  child:  DropdownButtonFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 16.0),
                      labelText: 'Tipo de poste',
                      hintText: '',
                    ),
                    elevation: 16,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'avenir-lt-std-medium',
                      color: Color(0xFF000000),
                    ),
                    iconEnabledColor: Colors.white,
                    value: tbUf,
                    isExpanded: true,
                    iconSize: 35,
                    items: ListUfdb.map((TbUf value) {
                      return new DropdownMenuItem<TbUf>(
                        onTap: () {
                          setState(() {
                            tbUf = value;
                            id_uf = value.id;
                          });
                        },
                        value: value,
                        child: Text(
                          value.uf,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 19.0,
                              color: Color(0xFF000000),
                              fontFamily:
                              "avenir-next-rounded-pro-regular"),
                        ),
                      );
                    }).toList(),
                    onChanged: (TbUf newValue) async {
                      try {

                      } catch (error) {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                new ErroInformacaoPage(
                                    informacao: error)))
                            .then((value) {
                          Inc();
                        });
                      }
                    },
                  ),),
                SizedBox(height: 20.0),
                Container(
                  height: 58.0,
                  child:  DropdownButtonFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 16.0),
                      labelText: 'Equipamento',
                      hintText: '',
                    ),
                    elevation: 16,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'avenir-lt-std-medium',
                      color: Color(0xFF000000),
                    ),
                    iconEnabledColor: Colors.white,
                    value: tbUf,
                    isExpanded: true,
                    iconSize: 35,
                    items: ListUfdb.map((TbUf value) {
                      return new DropdownMenuItem<TbUf>(
                        onTap: () {
                          setState(() {
                            tbUf = value;
                            id_uf = value.id;
                          });
                        },
                        value: value,
                        child: Text(
                          value.uf,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 19.0,
                              color: Color(0xFF000000),
                              fontFamily:
                              "avenir-next-rounded-pro-regular"),
                        ),
                      );
                    }).toList(),
                    onChanged: (TbUf newValue) async {
                      try {

                      } catch (error) {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                new ErroInformacaoPage(
                                    informacao: error)))
                            .then((value) {
                          Inc();
                        });
                      }
                    },
                  ),),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _TxtControllerTamanhoResistencia,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  autofocus: false,
                  maxLength: 100,
                  decoration: InputDecoration(
                    labelText: 'Tamanho/Resistência',
                    hintText: 'Tamanho/Resistência',
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _TxtControllerBarramento,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Barramento',
                    hintText: 'Barramento',
                  ),
                ),
                SizedBox(height: 30.0),
                Center(
                  child: InkWell(
                    onTap: () async {},
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
                        'SALVAR',
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
                SizedBox(height: 30.0),
              ],
            ),
          );
        }
        break;
      case "erro_informacao":
        {
          return SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/imagens/img_error.png",
                    width: 150.0,
                    height: 150.0,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    ErroInformacao,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    softWrap: false,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: "avenir-lt-std-roman",
                      fontSize: 15.0,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Inc();
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
                          'TENTE NOVAMENTE',
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
          );
        }
        break;
    }
  }

}
