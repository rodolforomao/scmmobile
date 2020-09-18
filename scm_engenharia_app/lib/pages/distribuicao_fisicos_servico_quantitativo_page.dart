import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scm_engenharia_app/data/db_helper.dart';
import 'package:scm_engenharia_app/data/tb_distribuicao_quantitativo_acessos_fisicos_servico.dart';
import 'package:scm_engenharia_app/data/tb_tecnologia.dart';
import 'package:scm_engenharia_app/data/tb_uf.dart';
import 'package:scm_engenharia_app/data/tb_uf_municipio.dart';
import 'package:scm_engenharia_app/models/operacao.dart';
import 'package:scm_engenharia_app/pages/erro_informacao_page.dart';
import 'package:scm_engenharia_app/pages/variavel_de_ambiente_page.dart';

class DistribuicaoFisicosServicoQuantitativoPage extends StatefulWidget {
  final TbDistribuicaoQuantitativoAcessosFisicosServico
      sDistribuicaoFisicosServicoQuantitativo;

  DistribuicaoFisicosServicoQuantitativoPage(
      {Key key, @required this.sDistribuicaoFisicosServicoQuantitativo})
      : super(key: key);

  @override
  _DistribuicaoFisicosServicoQuantitativoPageState createState() =>
      _DistribuicaoFisicosServicoQuantitativoPageState();
}

class _DistribuicaoFisicosServicoQuantitativoPageState
    extends State<DistribuicaoFisicosServicoQuantitativoPage> {
  TbDistribuicaoQuantitativoAcessosFisicosServico
      _DistribuicaoFisicosServicoQuantitativo =
      new TbDistribuicaoQuantitativoAcessosFisicosServico();
  DBHelper dbHelper;
  List<TbTecnologia> ListTecnologiadb = new List<TbTecnologia>();
  List<TbUf> ListUfdb = new List<TbUf>();
  List<TbUfMunicipio> ListUfMunicipiodb = new List<TbUfMunicipio>();
  TbUfMunicipio tbUfMunicipio = TbUfMunicipio();
  TbUf tbUf = TbUf();
  TbTecnologia tbTecnologia = new TbTecnologia();

  String id_uf = "0";
  String id_municipio = "0";
  String id_tecnologia = "0";

  TextEditingController _TxtControllerCod_ibge = TextEditingController();
  TextEditingController _TxtControllerPf_0 = TextEditingController();
  TextEditingController _TxtControllerPf_512 = TextEditingController();
  TextEditingController _TxtControllerPf_2 = TextEditingController();
  TextEditingController _TxtControllerPf_12 = TextEditingController();
  TextEditingController _TxtControllerPf_34 = TextEditingController();
  TextEditingController _TxtControllerPj_0 = TextEditingController();
  TextEditingController _TxtControllerPj_512 = TextEditingController();
  TextEditingController _TxtControllerPj_2 = TextEditingController();
  TextEditingController _TxtControllerPj_12 = TextEditingController();
  TextEditingController _TxtControllerPj_34 = TextEditingController();

  Future<Null> OnSalvarConta() async {
    try {
      if (id_uf == "0")
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
      _DistribuicaoFisicosServicoQuantitativo.id_uf = id_uf;
      _DistribuicaoFisicosServicoQuantitativo.id_municipio = id_municipio;
      _DistribuicaoFisicosServicoQuantitativo.id_tecnologia = id_tecnologia;

      _DistribuicaoFisicosServicoQuantitativo.cod_ibge =
          _TxtControllerCod_ibge.text;
      _DistribuicaoFisicosServicoQuantitativo.pf_0 = _TxtControllerPf_0.text;
      _DistribuicaoFisicosServicoQuantitativo.pf_512 = _TxtControllerPf_512.text;
      _DistribuicaoFisicosServicoQuantitativo.pf_2 = _TxtControllerPf_2.text;
      _DistribuicaoFisicosServicoQuantitativo.pf_12 = _TxtControllerPf_12.text;
      _DistribuicaoFisicosServicoQuantitativo.pf_34 = _TxtControllerPf_34.text;
      _DistribuicaoFisicosServicoQuantitativo.pj_0 = _TxtControllerPj_0.text;
      _DistribuicaoFisicosServicoQuantitativo.pj_512 = _TxtControllerPj_512.text;
      _DistribuicaoFisicosServicoQuantitativo.pj_2 = _TxtControllerPj_2.text;
      _DistribuicaoFisicosServicoQuantitativo.pj_12 = _TxtControllerPj_12.text;
      _DistribuicaoFisicosServicoQuantitativo.pj_34 = _TxtControllerPj_34.text;
      Navigator.pop(context, _DistribuicaoFisicosServicoQuantitativo);
    } catch (error) {
      OnToastInformacao(error);
    }
  }

  void OnToastInformacao(String Mensagem) {
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
      Operacao _ExisteVariavelDeAmbiente = await dbHelper.OnExisteVariavelDeAmbiente();
      if (_ExisteVariavelDeAmbiente.erro)
        throw (_ExisteVariavelDeAmbiente.mensagem);
      else if (_ExisteVariavelDeAmbiente.resultado == true) {
        Navigator.of(context, rootNavigator: true).push(
          new CupertinoPageRoute<bool>(
            maintainState: false,
            fullscreenDialog: true,
            builder: (BuildContext context) => new VariavelDeAmbientePage(),
          ),
        ).then((value) {
          Inc();
        });
      } else {
        tbUfMunicipio.idMunicipioApp = 0;
        tbUfMunicipio.ufId = "0";
        tbUfMunicipio.uf = "0";
        tbUfMunicipio.id = "0";
        tbUfMunicipio.municipio = "Selecione...";

        tbUf.idUfApp = 0;
        tbUf.id = "0";
        tbUf.uf = "Selecione...";

        tbTecnologia.idTecnologiaApp = 0;
        tbTecnologia.id = "0";
        tbTecnologia.tecnologia = "Selecione...";

        ListTecnologiadb.add(tbTecnologia);
        ListUfdb.add(tbUf);
        ListUfMunicipiodb.add(tbUfMunicipio);

        Operacao _Uf = await dbHelper.onSelecionarUf();
        if (_Uf.erro)
          throw (_Uf.mensagem);
        else if (_Uf.resultado == null) {
          throw (_Uf.mensagem);
        } else {
          for (var prop in _Uf.resultado as List<TbUf>) {
            setState(() {
              ListUfdb.add(prop);
            });
          }
        }
        Operacao _Tecnologia = await dbHelper.onSelecionarTecnologia();
        if (_Tecnologia.erro)
          throw (_Tecnologia.mensagem);
        else if (_Tecnologia.resultado == null) {
          throw (_Tecnologia.mensagem);
        } else {
          for (var prop in _Tecnologia.resultado as List<TbTecnologia>) {
            setState(() {
              ListTecnologiadb.add(prop);
            });
          }
        }

        if (widget.sDistribuicaoFisicosServicoQuantitativo == null) {

        } else {
          _DistribuicaoFisicosServicoQuantitativo = widget.sDistribuicaoFisicosServicoQuantitativo;

          TbUf resUf = ListUfdb.where((i) => i.id == widget.sDistribuicaoFisicosServicoQuantitativo.id_uf).first;
          tbUf.idUfApp = resUf.idUfApp;
          tbUf.id = resUf.id;
          tbUf.uf = resUf.uf;
           id_uf = resUf.id;



          Operacao _UfMunicipio = await dbHelper
              .onSelecionarMunicipioByIdUf(
              tbUf.id);
          if (_UfMunicipio.erro)
            throw (_UfMunicipio.mensagem);
          else if (_UfMunicipio.resultado == null) {
            OnToastInformacao("Para o estado " +
                tbUf.uf +
                " não a município cadastrado");
          } else {
            for (var prop in _UfMunicipio.resultado
            as List<TbUfMunicipio>) {
              setState(() {
                ListUfMunicipiodb.add(prop);
              });
            }
            TbUfMunicipio resMunicipio = ListUfMunicipiodb.where((i) => i.id == widget.sDistribuicaoFisicosServicoQuantitativo.id_municipio).first;
            tbUfMunicipio.idMunicipioApp = resMunicipio.idMunicipioApp;
            tbUfMunicipio.ufId = resMunicipio.ufId;
            tbUfMunicipio.uf = resMunicipio.uf;
            tbUfMunicipio.id = resMunicipio.id;
            tbUfMunicipio.municipio = resMunicipio.municipio;
             id_municipio = resMunicipio.id;

          }

          TbTecnologia resTecnologia = ListTecnologiadb.where((i) =>
          i.id == widget.sDistribuicaoFisicosServicoQuantitativo.id_tecnologia).first;
          tbTecnologia.idTecnologiaApp = resTecnologia.idTecnologiaApp;
          tbTecnologia.id = resTecnologia.id;
          tbTecnologia.tecnologia = resTecnologia.tecnologia;
          id_tecnologia = resTecnologia.id;
          _TxtControllerCod_ibge.text =
              widget.sDistribuicaoFisicosServicoQuantitativo.cod_ibge;
          _TxtControllerPf_0.text =
              widget.sDistribuicaoFisicosServicoQuantitativo.pf_0;
          _TxtControllerPf_512.text =
              widget.sDistribuicaoFisicosServicoQuantitativo.pf_512;
          _TxtControllerPf_2.text =
              widget.sDistribuicaoFisicosServicoQuantitativo.pf_2;
          _TxtControllerPf_12.text =
              widget.sDistribuicaoFisicosServicoQuantitativo.pf_12;
          _TxtControllerPf_34.text =
              widget.sDistribuicaoFisicosServicoQuantitativo.pf_34;
          _TxtControllerPj_0.text =
              widget.sDistribuicaoFisicosServicoQuantitativo.pj_0;
          _TxtControllerPj_512.text =
              widget.sDistribuicaoFisicosServicoQuantitativo.pj_512;
          _TxtControllerPj_2.text =
              widget.sDistribuicaoFisicosServicoQuantitativo.pj_2;
          _TxtControllerPj_12.text =
              widget.sDistribuicaoFisicosServicoQuantitativo.pj_12;
          _TxtControllerPj_34.text =
              widget.sDistribuicaoFisicosServicoQuantitativo.pj_34;
        }
      }
    } catch (error) {
      OnToastInformacao(error);
    }
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    Inc();
  }

  @override
  void dispose() {
    super.dispose();
    FocusScope.of(context).requestFocus(new FocusNode());
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
        actions: <Widget>[],
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
                                    Operacao _UfMunicipio = await dbHelper
                                        .onSelecionarMunicipioByIdUf(
                                            newValue.id);
                                    if (_UfMunicipio.erro)
                                      throw (_UfMunicipio.mensagem);
                                    else if (_UfMunicipio.resultado == null) {
                                      OnToastInformacao("Para o estado " +
                                          newValue.uf +
                                          " não a município cadastrado");
                                    } else {
                                      ListUfMunicipiodb.clear();
                                      tbUfMunicipio.idMunicipioApp = 0;
                                      tbUfMunicipio.ufId = "0";
                                      tbUfMunicipio.uf = "0";
                                      tbUfMunicipio.id = "0";
                                      tbUfMunicipio.municipio = "Selecione...";
                                      _DistribuicaoFisicosServicoQuantitativo.uf =  newValue.uf;
                                      ListUfMunicipiodb.add(tbUfMunicipio);
                                      for (var prop in _UfMunicipio.resultado
                                          as List<TbUfMunicipio>) {
                                        setState(() {
                                          ListUfMunicipiodb.add(prop);
                                        });
                                      }
                                      tbUfMunicipio = ListUfMunicipiodb.first;
                                    }
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
                              ),
                            ),
                          ));
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
                                hint: Text(
                                  "Selecione ..",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: const Color(0xFF90ffffff)),
                                ),
                                elevation: 16,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'avenir-lt-std-medium',
                                  color: Color(0xFF000000),
                                ),
                                iconEnabledColor: Colors.white,
                                value: tbUfMunicipio,
                                isExpanded: true,
                                iconSize: 35,
                                items: ListUfMunicipiodb.map(
                                    (TbUfMunicipio value) {
                                  return new DropdownMenuItem<TbUfMunicipio>(
                                    value: value,
                                    onTap: () {
                                      setState(() {
                                        tbUfMunicipio = value;
                                        id_municipio = value.id;
                                        _DistribuicaoFisicosServicoQuantitativo.municipio = value.municipio;
                                      });
                                    },
                                    child: Text(
                                      value.municipio,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 19.0,
                                          color: Color(0xFF000000),
                                          fontFamily:
                                              "avenir-next-rounded-pro-regular"),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (TbUfMunicipio newValue) {
                                  setState(() {});
                                },
                              ),
                            ),
                          ));
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
                                hint: Text(
                                  "Selecione ..",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: const Color(0xFF90ffffff)),
                                ),
                                elevation: 16,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'avenir-lt-std-medium',
                                  color: Color(0xFF000000),
                                ),
                                iconEnabledColor: Colors.white,
                                value:
                                    tbTecnologia != null ? tbTecnologia : null,
                                isExpanded: true,
                                iconSize: 35,
                                items:
                                    ListTecnologiadb.map((TbTecnologia value) {
                                  return new DropdownMenuItem<TbTecnologia>(
                                    value: value,
                                    child: Text(
                                      value.tecnologia,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 19.0,
                                          color: Color(0xFF000000),
                                          fontFamily:
                                              "avenir-next-rounded-pro-regular"),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (TbTecnologia newValue) {
                                  setState(() {
                                    tbTecnologia = newValue;
                                    id_tecnologia = newValue.id;
                                    _DistribuicaoFisicosServicoQuantitativo.tecnologia = newValue.tecnologia;
                                  });
                                },
                              ),
                            ),
                          ));
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
