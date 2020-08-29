import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scm_engenharia_app/help/components.dart';
import 'package:scm_engenharia_app/models/model_formulario_sici_fust.dart';

class DistribuicaoFisicosServicoQuantitativoPage  extends StatefulWidget {
  @override
  _DistribuicaoFisicosServicoQuantitativoPageState createState() => _DistribuicaoFisicosServicoQuantitativoPageState();
}

class _DistribuicaoFisicosServicoQuantitativoPageState extends State<DistribuicaoFisicosServicoQuantitativoPage > {

  ModelDistribuicaoFisicosServicoQuantitativoJson _DistribuicaoFisicosServicoQuantitativo = new ModelDistribuicaoFisicosServicoQuantitativoJson();

  List<String> Uf = new List<String>();
  String UfTxt, errorTextControllerSenha, errorTextControllerEmail;

  String id_uf;
  String id_municipio;
  String id_tecnologia;
  TextEditingController _TxtControllerCod_ibge  = TextEditingController();
  TextEditingController _TxtControllerPf_0 = TextEditingController();
  TextEditingController _TxtControllerPf_512 = TextEditingController();
  TextEditingController _TxtControllerPf_2 = TextEditingController();
  TextEditingController _TxtControllerPf_12= TextEditingController();
  TextEditingController _TxtControllerPf_34 = TextEditingController();
  TextEditingController _TxtControllerPj_0= TextEditingController();
  TextEditingController _TxtControllerPj_512 = TextEditingController();
  TextEditingController _TxtControllerPj_2 = TextEditingController();
  TextEditingController _TxtControllerPj_12 = TextEditingController();
  TextEditingController _TxtControllerPj_34 = TextEditingController();

  Future<Null> OnSalvarConta() async {
    try {
      if (_TxtControllerCod_ibge.text.isEmpty)
        throw ("Nome e obrigatório");
      else if (_TxtControllerPf_0.text.isEmpty)
        throw ("CPF e obrigatório");
      else if (_TxtControllerPf_512.text.isEmpty)
        throw ("Email e obrigatório");
      else if (_TxtControllerPf_2.text.isEmpty)
        throw ("Telefone e obrigatório");
      else if (_TxtControllerPf_12.text.isEmpty)
        throw ("Telefone Whatsapp e obrigatório");
      else if (_TxtControllerPf_34.text.isEmpty)
        throw ("Empresa e obrigatório");
      else if (_TxtControllerPj_0.text.isEmpty)
        throw ("UF deve ser selecionada");
      else if (_TxtControllerPj_512.text.isEmpty)
        throw ("UF deve ser selecionada");
      else if (_TxtControllerPj_2.text.isEmpty)
        throw ("UF deve ser selecionada");
      else if (_TxtControllerPj_12.text.isEmpty)
        throw ("UF deve ser selecionada");
      else if (_TxtControllerPj_34.text.isEmpty)
        throw ("UF deve ser selecionada");
      _DistribuicaoFisicosServicoQuantitativo.idUf = "1";
      _DistribuicaoFisicosServicoQuantitativo.idMunicipio = "1";
      _DistribuicaoFisicosServicoQuantitativo.idTecnologia = "1";
      
      _DistribuicaoFisicosServicoQuantitativo.codIbge = _TxtControllerCod_ibge.text;
      _DistribuicaoFisicosServicoQuantitativo.pf0 = _TxtControllerPf_0.text;
      _DistribuicaoFisicosServicoQuantitativo.pf512 = _TxtControllerPf_512.text;
      _DistribuicaoFisicosServicoQuantitativo.pf2 = _TxtControllerPf_2.text;
      _DistribuicaoFisicosServicoQuantitativo.pf12 = _TxtControllerPf_12.text;
      _DistribuicaoFisicosServicoQuantitativo.pf34 = _TxtControllerPf_34.text;
      _DistribuicaoFisicosServicoQuantitativo.pj0 = _TxtControllerPj_0.text;
      _DistribuicaoFisicosServicoQuantitativo.pj512 = _TxtControllerPj_512.text;
      _DistribuicaoFisicosServicoQuantitativo.pj2 = _TxtControllerPj_2.text;
      _DistribuicaoFisicosServicoQuantitativo.pj12 = _TxtControllerPj_12.text;
      _DistribuicaoFisicosServicoQuantitativo.pj34 = _TxtControllerPj_34.text;
      Navigator.pop(context, _DistribuicaoFisicosServicoQuantitativo);

    } catch (error) {
      OnAlertaInformacao(error);
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
          child:  Column(
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
                  Padding(padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                    child:  Text(
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

  Inc() async {
    try {
      Uf = await Components.OnlistaEstados() as List<String>;
      setState(() {
        UfTxt = Uf.first;
      });
    } catch (error) {
      //Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    Inc();

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
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Formulário Sici - Fust",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 19.0,
              color: Color(0xffFFFFFF),
              fontFamily: "open-sans-regular"),
        ),
        actions: <Widget>[

        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20.0),
              Container(
                  height: 55.0,
                  child: FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Nome da UF',
                            hintText: 'avenir-lt-std-medium',
                          ),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                elevation: 16,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'avenir-lt-std-medium',
                                  color: Color(0xFF000000),),
                                iconEnabledColor: Colors.white,
                                value: UfTxt,
                                isExpanded: true,
                                iconSize: 35,
                                items: Uf.map((String value) {
                                  return new DropdownMenuItem<String>(
                                    onTap: () {
                                      setState(() {

                                      });
                                    },
                                    value: value,
                                    child: Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 19.0,
                                          color: Color(0xFF000000),
                                          fontFamily: "avenir-next-rounded-pro-regular"),
                                    ),
                                  );
                                }).toList(),
                                onTap: () {
                                  setState(() {

                                  });
                                },
                                onChanged: (value) {
                                  setState(() {
                                    UfTxt = value;
                                  });
                                },
                              ),
                            ),)
                      );
                    },
                  )),
              SizedBox(height: 20.0),
              Container(
                  height: 55.0,
                  child: FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Nome município',
                            hintText: 'avenir-lt-std-medium',
                          ),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                elevation: 16,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'avenir-lt-std-medium',
                                  color: Color(0xFF000000),),
                                iconEnabledColor: Colors.white,
                                value: UfTxt,
                                isExpanded: true,
                                iconSize: 35,
                                items: Uf.map((String value) {
                                  return new DropdownMenuItem<String>(
                                    onTap: () {
                                      setState(() {

                                      });
                                    },
                                    value: value,
                                    child: Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 19.0,
                                          color: Color(0xFF000000),
                                          fontFamily: "avenir-next-rounded-pro-regular"),
                                    ),
                                  );
                                }).toList(),
                                onTap: () {
                                  setState(() {

                                  });
                                },
                                onChanged: (value) {
                                  setState(() {
                                    UfTxt = value;
                                  });
                                },
                              ),
                            ),)
                      );
                    },
                  )),
              SizedBox(height: 20.0),
              Container(
                  height: 55.0,
                  child: FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Nome tecnologia',
                            hintText: 'avenir-lt-std-medium',
                          ),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                elevation: 16,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'avenir-lt-std-medium',
                                  color: Color(0xFF000000),),
                                iconEnabledColor: Colors.white,
                                value: UfTxt,
                                isExpanded: true,
                                iconSize: 35,
                                items: Uf.map((String value) {
                                  return new DropdownMenuItem<String>(
                                    onTap: () {
                                      setState(() {

                                      });
                                    },
                                    value: value,
                                    child: Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 19.0,
                                          color: Color(0xFF000000),
                                          fontFamily: "avenir-next-rounded-pro-regular"),
                                    ),
                                  );
                                }).toList(),
                                onTap: () {
                                  setState(() {

                                  });
                                },
                                onChanged: (value) {
                                  setState(() {
                                    UfTxt = value;
                                  });
                                },
                              ),
                            ),)
                      );
                    },
                  )),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _TxtControllerCod_ibge,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  labelText: 'Código IBGE',
                  hintText: '',
                ),
                keyboardType: TextInputType.text,
                maxLength: 500,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _TxtControllerPf_0,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  labelText: 'PF - 0 - 512 Kbps',
                  hintText: '',
                ),
                keyboardType: TextInputType.text,
                maxLength: 500,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _TxtControllerPf_512,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  labelText: 'PF - 512 - 2 Mbps',
                  hintText: '',
                ),
                keyboardType: TextInputType.text,
                maxLength: 500,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _TxtControllerPf_2,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  labelText: 'PF - 2 - 12 Mbps',
                  hintText: '',
                ),
                keyboardType: TextInputType.text,
                maxLength: 500,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _TxtControllerPf_12,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  labelText: 'PF - 12 - 34 Mbps',
                  hintText: '',
                ),
                keyboardType: TextInputType.text,
                maxLength: 500,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _TxtControllerPf_34,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  labelText: 'PF - Acima de 34 Mbps',
                  hintText: '',
                ),
                keyboardType: TextInputType.text,
                maxLength: 500,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _TxtControllerPj_0,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  labelText: 'PJ - 0 - 512 Kbps',
                  hintText: '',
                ),
                keyboardType: TextInputType.text,
                maxLength: 500,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _TxtControllerPj_512,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  labelText: 'PJ - 512 - 2 Mbps',
                  hintText: '',
                ),
                keyboardType: TextInputType.text,
                maxLength: 500,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _TxtControllerPj_2,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  labelText: 'PJ - 2 - 12 Mbps',
                  hintText: '',
                ),
                keyboardType: TextInputType.text,
                maxLength: 500,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _TxtControllerPj_12,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  labelText: 'PJ - 12 - 34 Mbps',
                  hintText: '',
                ),
                keyboardType: TextInputType.text,
                maxLength: 500,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _TxtControllerPj_34,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  labelText: 'PJ - Acima de 34 Mbps',
                  hintText: '',
                ),
                keyboardType: TextInputType.text,
                maxLength: 500,
              ),
              SizedBox(height: 40.0),
              InkWell(
                onTap: () {
                  OnSalvarConta();
                },
                child: Container(
                  constraints: BoxConstraints(maxWidth: 300),
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  padding: EdgeInsets.symmetric(vertical: 13),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      border:
                      Border.all(color: Color(0xff018a8a), width: 2),
                      color: Color(0xff018a8a)),
                  child: Text(
                    'Adicionar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'avenir-lt-std-roman',
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}
