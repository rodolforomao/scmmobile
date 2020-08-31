import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scm_engenharia_app/data/db_helper.dart';
import 'package:scm_engenharia_app/data/tb_tecnologia.dart';
import 'package:scm_engenharia_app/data/tb_uf.dart';
import 'package:scm_engenharia_app/data/tb_uf_municipio.dart';
import 'package:scm_engenharia_app/help/components.dart';
import 'package:scm_engenharia_app/models/model_formulario_sici_fust.dart';
import 'package:scm_engenharia_app/models/operacao.dart';

class DistribuicaoFisicosServicoQuantitativoPage  extends StatefulWidget {
  @override
  _DistribuicaoFisicosServicoQuantitativoPageState createState() => _DistribuicaoFisicosServicoQuantitativoPageState();
}

class _DistribuicaoFisicosServicoQuantitativoPageState extends State<DistribuicaoFisicosServicoQuantitativoPage > {

  ModelDistribuicaoFisicosServicoQuantitativoJson _DistribuicaoFisicosServicoQuantitativo = new ModelDistribuicaoFisicosServicoQuantitativoJson();
  DBHelper dbHelper;
  List<TbTecnologia> ListTecnologiadb = new List<TbTecnologia>();
  List<TbUf> ListUfdb = new List<TbUf>();
  List<TbUfMunicipio> ListUfMunicipiodb = new List<TbUfMunicipio>();
  TbUfMunicipio tbUfMunicipio = TbUfMunicipio();
  TbUf tbUf = TbUf();
  TbTecnologia tbTecnologia = TbTecnologia();
  String id_uf = "0",txt_uf = "";
  String id_municipio = "0" ,txt_municipio = "";
  String id_tecnologia = "0",txt_tecnologia = "";



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
      if (id_uf  == "0")
        throw ("O estado deve ser selecionado");
      else if (id_municipio == "0")
        throw ("O município  deve ser selecionado");
      else if (id_tecnologia == "0")
        throw ("O tecnologia  deve ser selecionado");
      else if (_TxtControllerCod_ibge.text.isEmpty)
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
      _DistribuicaoFisicosServicoQuantitativo.idUf = id_uf;
      _DistribuicaoFisicosServicoQuantitativo.idMunicipio = id_municipio;
      _DistribuicaoFisicosServicoQuantitativo.idTecnologia = id_tecnologia;
      
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

      tbUfMunicipio.idMunicipioApp = 0;
      tbUfMunicipio.ufId = "0";
      tbUfMunicipio.uf = "0";
      tbUfMunicipio.id  = "0";
      tbUfMunicipio.municipio  = "Selecione...";

      tbUf.idUfApp = 0;
      tbUf.id = "0";
      tbUf.uf = "Selecione...";

      tbTecnologia.idTecnologiaApp = 0;
      tbTecnologia.id = "0";
      tbTecnologia.tecnologia = "Selecione...";
      ListTecnologiadb.add(tbTecnologia);
      ListUfdb.add(tbUf);
      ListUfMunicipiodb.add(tbUfMunicipio);



      Operacao _Tecnologia = await dbHelper.onSelecionarTecnologia();
      Operacao _Uf = await dbHelper.onSelecionarUf();
      Operacao _UfMunicipio = await dbHelper.onSelecionarUfMunicipio();
      if (_Tecnologia.erro)
        throw (_Tecnologia.mensagem);
      else if (_Tecnologia.resultado == null) {
        //ListTecnologiadb = _Tecnologia.resultado as List;
       // ListUfdb = _Uf.resultado as List;
       // ListUfMunicipiodb = _UfMunicipio.resultado as List;
        setState(() {
          //txt_uf = ListUfdb.first.uf;
          //txt_municipio = ListUfMunicipiodb.first.municipio;
         // txt_tecnologia = ListTecnologiadb.first.tecnologia;
        });
      }
      else {

      }

    } catch (error) {
      //Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
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
                              child: DropdownButton<TbUf>(
                                elevation: 16,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'avenir-lt-std-medium',
                                  color: Color(0xFF000000),),
                                iconEnabledColor: Colors.white,
                                value: tbUf,
                                isExpanded: true,
                                iconSize: 35,
                                items: ListUfdb.map((TbUf value) {
                                  return new DropdownMenuItem<TbUf>(
                                    onTap: () {
                                      setState(() {
                                        tbUf = value;
                                        txt_uf = value.uf;
                                        id_uf = value.id;
                                      });
                                    },
                                    value: tbUf,
                                    child: Text(
                                      value.uf,
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
                              child: DropdownButton<TbUfMunicipio>(
                                elevation: 16,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'avenir-lt-std-medium',
                                  color: Color(0xFF000000),),
                                iconEnabledColor: Colors.white,
                                value: tbUfMunicipio,
                                isExpanded: true,
                                iconSize: 35,
                                items: ListUfMunicipiodb.map((TbUfMunicipio value) {
                                  return new DropdownMenuItem<TbUfMunicipio>(
                                    onTap: () {
                                      setState(() {
                                        tbUfMunicipio = value;
                                        txt_municipio = value.municipio;
                                        id_municipio = value.id;
                                      });
                                    },
                                    value: value,
                                    child: Text(
                                      value.municipio,
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
                              child: DropdownButton<TbTecnologia>(
                                elevation: 16,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'avenir-lt-std-medium',
                                  color: Color(0xFF000000),),
                                iconEnabledColor: Colors.white,
                                value: tbTecnologia,
                                isExpanded: true,
                                iconSize: 35,
                                items: ListTecnologiadb.map((TbTecnologia value) {
                                  return new DropdownMenuItem<TbTecnologia>(
                                    onTap: () {
                                      setState(() {
                                        tbTecnologia = value;
                                        id_tecnologia = value.id;
                                        txt_tecnologia= value.tecnologia;
                                      });
                                    },
                                    value: tbTecnologia,
                                    child: Text(
                                      value.tecnologia,
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
              SizedBox(height: 30.0),
              Center(
                child: InkWell(
                  onTap: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    OnSalvarConta();
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
                      'Adicionar',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontFamily: 'avenir-lt-std-roman',
                        fontSize: 18.0,
                      ),
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
