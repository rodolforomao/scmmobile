import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:scm_engenharia_app/help/components.dart';
import 'package:scm_engenharia_app/help/masked_text_controller.dart';
import 'package:scm_engenharia_app/help/servico_mobile_service.dart';
import 'package:scm_engenharia_app/models/model_formulario_sici_fust.dart';
import 'package:scm_engenharia_app/models/operacao.dart';
import 'package:scm_engenharia_app/pages/distribuicao_fisicos_servico_quantitativo_page.dart';

class FormularioSiciFustPage extends StatefulWidget {

  final ModelFormularioSiciFustJson ModelFormularioSiciFust;
  FormularioSiciFustPage({Key key, @required this.ModelFormularioSiciFust}) : super(key: key);
  @override
  _FormularioSiciFustPageState createState() => _FormularioSiciFustPageState();
}

class _FormularioSiciFustPageState extends State<FormularioSiciFustPage> {
  final _ScaffoldKey = GlobalKey<ScaffoldState>();
  ServicoMobileService _RestWebService = new ServicoMobileService();
  BuildContext dialogContext;
  ModelFormularioSiciFustJson _ModelFormularioSiciFustJson = new ModelFormularioSiciFustJson();
  List<ModelDistribuicaoFisicosServicoQuantitativoJson>
  ListaModelDistribuicaoFisicosServicoQuantitativo = new List<ModelDistribuicaoFisicosServicoQuantitativoJson>();
  StreamSubscription<ConnectivityResult> subscription;
  DateTime _DataSelecionadaConsulta = DateTime.now();


  TextEditingController _TxtControllerCnpj = new MaskedTextController(mask: '00.000.000/0000-00');
  TextEditingController _TxtControllerRazaoSocial = TextEditingController();
  TextEditingController _TxtControllerNomeConsultor = TextEditingController();
  TextEditingController _TxtControllerTelefoneMovel = new MaskedTextController(mask: '(00) 0 0000-0000');
  TextEditingController _TxtControllerTelefoneFixo = new MaskedTextController(mask: '(00) 0 0000-0000');

  TextEditingController _TxtControllerEmailConsutor = TextEditingController();
  TextEditingController _TxtControllerEmailCliente = TextEditingController();
  TextEditingController _TxtControllerNomeCliente = TextEditingController();
  TextEditingController _TxtControllerMesReferencia = TextEditingController();
  TextEditingController _TxtControllerPeriodoReferencia = TextEditingController();

  TextEditingController _TxtControllerReceitaBruta = TextEditingController();
  TextEditingController _TxtControllerReceitaLiquida = TextEditingController();
  TextEditingController _TxtControllerSimples = TextEditingController();
  TextEditingController _TxtControllerSimplesPorc = TextEditingController();
  TextEditingController _TxtControllerIcms = TextEditingController();
  TextEditingController _TxtControllerIcmsPorc = TextEditingController();
  TextEditingController _TxtControllerPis = TextEditingController();
  TextEditingController _TxtControllerPisPorc = TextEditingController();
  TextEditingController _TxtControllerCofins = TextEditingController();
  TextEditingController _TxtControllerCofinsPorc = TextEditingController();
  TextEditingController _TxtControllerObservacoes = TextEditingController();

  List<String> Uf = new List<String>();
  String UfTxt,_StatusTipoWidget = "renderizar_ficha_sici";
  TextEditingController _TxtControllerPeriodoDeReferencia = TextEditingController();


  DateTime _DataSelecionada = DateTime.now();

  OnSelecionarPeriodoDeReferencia(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _DataSelecionada,
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _DataSelecionada = picked;
        _TxtControllerPeriodoDeReferencia.text =
            DateFormat('dd/MM/yyyy').format(picked.toLocal());
      });
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

  Future<Null> OnSalvarFormulario() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
      } else {
        if (_TxtControllerCnpj.text.isEmpty)
          throw ("O campo cnpj e obrigatório");
        _ModelFormularioSiciFustJson.periodoReferencia = DateTime.now().toString(); //_TxtControllerPeriodoReferencia.text;
        _ModelFormularioSiciFustJson.cnpj = _TxtControllerCnpj.text;
        _ModelFormularioSiciFustJson.razaoSocial = _TxtControllerRazaoSocial.text;
        _ModelFormularioSiciFustJson.nomeConsultor= _TxtControllerNomeConsultor.text;
        _ModelFormularioSiciFustJson.telefoneMovel= _TxtControllerTelefoneMovel.text;
        _ModelFormularioSiciFustJson.telefoneFixo= _TxtControllerTelefoneFixo.text;
        _ModelFormularioSiciFustJson.emailConsutor = _TxtControllerEmailConsutor.text;
        _ModelFormularioSiciFustJson.emailCliente = _TxtControllerEmailCliente.text;
        _ModelFormularioSiciFustJson.nomeCliente = _TxtControllerNomeCliente.text;
        _ModelFormularioSiciFustJson.mesReferencia = _TxtControllerMesReferencia.text;

        _ModelFormularioSiciFustJson.receitaBruta= _TxtControllerReceitaBruta.text;
        _ModelFormularioSiciFustJson.receitaLiquida= _TxtControllerReceitaLiquida.text;
        _ModelFormularioSiciFustJson.simples= _TxtControllerSimples.text;
        _ModelFormularioSiciFustJson.simplesPorc = _TxtControllerSimplesPorc.text;
        _ModelFormularioSiciFustJson.icms= _TxtControllerIcms.text;
        _ModelFormularioSiciFustJson.icmsPorc= _TxtControllerIcmsPorc.text;
        _ModelFormularioSiciFustJson.pis= _TxtControllerPis.text;
        _ModelFormularioSiciFustJson.pisPorc= _TxtControllerPisPorc.text;
        _ModelFormularioSiciFustJson.cofins= _TxtControllerCofins.text;
        _ModelFormularioSiciFustJson.cofinsPorc= _TxtControllerCofinsPorc.text;
        _ModelFormularioSiciFustJson.observacoes= _TxtControllerObservacoes.text;

        if(ListaModelDistribuicaoFisicosServicoQuantitativo.length == 0)
          throw ("Distribuição do quantitativo de acessos físicos em serviço e obrigatório,favor adicionar.");
        _ModelFormularioSiciFustJson.distribuicaoFisicosServicoQuantitativo = ListaModelDistribuicaoFisicosServicoQuantitativo;
        Operacao _RestWeb = await _RestWebService.OnRealizarLancamentosSici(_ModelFormularioSiciFustJson);
        if (_RestWeb.erro)
          throw (_RestWeb.mensagem);
        else if (_RestWeb.resultado == null)
          throw (_RestWeb.mensagem);
        else
        {
         // Navigator.pop(dialogContext);
          OnAlertaInformacao(_RestWeb.mensagem);
        }
      }
    } catch (error) {
      Navigator.pop(dialogContext);
      OnAlertaInformacao(error);
    }
  }

  void handleReadOnlyInputClick(context) {
    showBottomSheet(
        context: context,
        builder: (BuildContext context) => Container(
          width: MediaQuery.of(context).size.width,
          child: YearPicker(
            selectedDate: DateTime(1997),
            firstDate: DateTime(1995),
            lastDate: DateTime.now(),
            onChanged: (val) {
              print(val);
              Navigator.pop(context);
            },
          ),
        ));
  }

  OnSelecionarData(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDate: _DataSelecionada,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime.now(),
      errorFormatText: 'Insira uma data válida',
      errorInvalidText: 'Insira a data em um intervalo válido',
      fieldLabelText: 'Período referência ',
      fieldHintText: 'Dia/Mês/Ano',
      helpText: 'Selecione o período referência',
    );
    if (picked != null && picked != _DataSelecionada) {
      setState(() {
        _DataSelecionada = picked;
        _TxtControllerPeriodoReferencia.text = DateFormat('dd/MM/yyyy').format(picked.toLocal());

      });

    }
  }

  Inc() async {
    try {
      Uf = await Components.OnlistaEstados() as List<String>;
      setState(() {
        UfTxt = Uf.first;
      });
      if(widget.ModelFormularioSiciFust != null)
        {
          _TxtControllerPeriodoDeReferencia.text = widget.ModelFormularioSiciFust.periodoReferencia;
          _TxtControllerCnpj.text = widget.ModelFormularioSiciFust.cnpj;
           _TxtControllerRazaoSocial.text = widget.ModelFormularioSiciFust.razaoSocial;
           _TxtControllerNomeConsultor.text = widget.ModelFormularioSiciFust.nomeConsultor;
           _TxtControllerTelefoneMovel.text = widget.ModelFormularioSiciFust.telefoneMovel;
           _TxtControllerTelefoneFixo.text = widget.ModelFormularioSiciFust.telefoneFixo;

           _TxtControllerEmailConsutor.text = widget.ModelFormularioSiciFust.emailConsutor;
           _TxtControllerEmailCliente.text = widget.ModelFormularioSiciFust.emailCliente;
           _TxtControllerNomeCliente.text = widget.ModelFormularioSiciFust.nomeCliente;
           _TxtControllerMesReferencia.text = widget.ModelFormularioSiciFust.mesReferencia;

           _TxtControllerReceitaBruta.text = widget.ModelFormularioSiciFust.receitaBruta;
           _TxtControllerReceitaLiquida.text = widget.ModelFormularioSiciFust.receitaLiquida;
           _TxtControllerSimples.text = widget.ModelFormularioSiciFust.simples;
           _TxtControllerSimplesPorc.text = widget.ModelFormularioSiciFust.simplesPorc;
           _TxtControllerIcms.text = widget.ModelFormularioSiciFust.icms;
           _TxtControllerIcmsPorc.text = widget.ModelFormularioSiciFust.icmsPorc;
           _TxtControllerPis.text = widget.ModelFormularioSiciFust.pis;
           _TxtControllerPisPorc.text = widget.ModelFormularioSiciFust.pisPorc;
           _TxtControllerCofins.text = widget.ModelFormularioSiciFust.cofins;
           _TxtControllerCofinsPorc.text = widget.ModelFormularioSiciFust.cofinsPorc;
           _TxtControllerObservacoes.text = widget.ModelFormularioSiciFust.observacoes;
           if(widget.ModelFormularioSiciFust.distribuicaoFisicosServicoQuantitativo != null)
             {
               for (var prop in  widget.ModelFormularioSiciFust.distribuicaoFisicosServicoQuantitativo) {
                 ListaModelDistribuicaoFisicosServicoQuantitativo.add(prop);
               }
             }
        }
    } catch (error) {
      //Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    Inc();
  }

  int current_step = 0;
  List<Step> spr = <Step>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _ScaffoldKey,
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
          InkWell(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              OnSalvarFormulario();
            },
            child: Center(child: Text(
              'Salvar   ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'avenir-lt-std-roman',
                fontSize: 15.0,
              ),
            ),)
          ),
        ],
      ),
      body:_TipoWidget(context),
    );
  }

  Card DistribuicaoFisicosServicoQuantitativoCard(BuildContext context, int index) => Card(
        elevation: 0.9,
        color: Color(0xffFFFFFF),
        child: Container(
            alignment: Alignment.topLeft,
            height: 700,
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 20.0),
            decoration: new BoxDecoration(
              color: Color(0xffFFFFFF), //new Color.fromRGBO(255, 0, 0, 0.0),
              borderRadius: new BorderRadius.circular(5.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: RichText(
                      textAlign: TextAlign.start,
                      softWrap: false,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'UF' + "\n ",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: ListaModelDistribuicaoFisicosServicoQuantitativo[index].uf,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black54,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 15.0,
                          ),
                        ),
                      ])),
                ),
                SizedBox(height: 10.0),
                Flexible(
                  child: RichText(
                      textAlign: TextAlign.start,
                      softWrap: false,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Nome município' + "\n ",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: ListaModelDistribuicaoFisicosServicoQuantitativo[index].municipio,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black54,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 15.0,
                          ),
                        ),
                      ])),
                ),
                SizedBox(height: 10.0),
                Flexible(
                  child: RichText(
                      textAlign: TextAlign.start,
                      softWrap: false,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Nome tecnologia' + "\n ",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: ListaModelDistribuicaoFisicosServicoQuantitativo[index].tecnologia,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black54,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 15.0,
                          ),
                        ),
                      ])),
                ),
                SizedBox(height: 10.0),
                Flexible(
                  child: RichText(
                      textAlign: TextAlign.start,
                      softWrap: false,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Código IBGE' + "\n ",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 15.0,
                          ),
                        ),
                        TextSpan(
                          text: ListaModelDistribuicaoFisicosServicoQuantitativo[index].codIbge,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black54,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 16.0,
                          ),
                        ),
                      ])),
                ),
                SizedBox(height: 10.0),
                Flexible(
                  child: RichText(
                      textAlign: TextAlign.start,
                      softWrap: false,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'PF - 0 - 512 Kbps' + "\n ",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: ListaModelDistribuicaoFisicosServicoQuantitativo[index].pf0,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black54,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 15.0,
                          ),
                        ),
                      ])),
                ),
                SizedBox(height: 10.0),
                Flexible(
                  child: RichText(
                      textAlign: TextAlign.start,
                      softWrap: false,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'PF - 512 - 2 Mbps' + "\n ",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: ListaModelDistribuicaoFisicosServicoQuantitativo[index].pf512,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black54,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 15.0,
                          ),
                        ),
                      ])),
                ),
                SizedBox(height: 10.0),
                Flexible(
                  child: RichText(
                      textAlign: TextAlign.start,
                      softWrap: false,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'PF - 2 - 12 Mbps' + "\n ",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: ListaModelDistribuicaoFisicosServicoQuantitativo[index].pf2,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black54,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 15.0,
                          ),
                        ),
                      ])),
                ),
                SizedBox(height: 10.0),
                Flexible(
                  child: RichText(
                      textAlign: TextAlign.start,
                      softWrap: false,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'PF - 12 - 34 Mbps' + "\n ",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: ListaModelDistribuicaoFisicosServicoQuantitativo[index].pf12,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black54,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 15.0,
                          ),
                        ),
                      ])),
                ),
                SizedBox(height: 10.0),
                Flexible(
                  child: RichText(
                      textAlign: TextAlign.start,
                      softWrap: false,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'PF - Acima de 34 Mbps' + "\n ",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: ListaModelDistribuicaoFisicosServicoQuantitativo[index].pf34,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black54,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 15.0,
                          ),
                        ),
                      ])),
                ),
                SizedBox(height: 10.0),
                Flexible(
                  child: RichText(
                      textAlign: TextAlign.start,
                      softWrap: false,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'PJ - 0 - 512 Kbps' + "\n ",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: ListaModelDistribuicaoFisicosServicoQuantitativo[index].pj0,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black54,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 15.0,
                          ),
                        ),
                      ])),
                ),
                SizedBox(height: 10.0),
                Flexible(
                  child: RichText(
                      textAlign: TextAlign.start,
                      softWrap: false,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'PJ - 512 - 2 Mbps' + "\n ",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: ListaModelDistribuicaoFisicosServicoQuantitativo[index].pj512,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black54,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 15.0,
                          ),
                        ),
                      ])),
                ),
                SizedBox(height: 10.0),
                Flexible(
                  child: RichText(
                      textAlign: TextAlign.start,
                      softWrap: false,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'PJ - 2 - 12 Mbps' + "\n ",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: ListaModelDistribuicaoFisicosServicoQuantitativo[index].pj2,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black54,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 15.0,
                          ),
                        ),
                      ])),
                ),
                SizedBox(height: 10.0),
                Flexible(
                  child: RichText(
                      textAlign: TextAlign.start,
                      softWrap: false,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'PJ - 12 - 34 Mbps' + "\n ",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: ListaModelDistribuicaoFisicosServicoQuantitativo[index].pj12,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black54,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 15.0,
                          ),
                        ),
                      ])),
                ),
                SizedBox(height: 10.0),
                Flexible(
                  child: RichText(
                      textAlign: TextAlign.start,
                      softWrap: false,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'PJ - Acima de 34 Mbps' + "\n ",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: ListaModelDistribuicaoFisicosServicoQuantitativo[index].pj34,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black54,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 15.0,
                          ),
                        ),
                      ])),
                ),
                SizedBox(height: 10.0),
                Divider(),
                Container(
                  color: Colors.white,
                  height: 40,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton.icon(
                        color: Color(0xffa55eea),
                        icon: Icon(
                          Icons.visibility,
                          color: Colors.white,
                        ),
                        //`Icon` to display
                        label: Text(
                          'Visualizar',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 15.0,
                          ),
                        ),
                        //`Text` to display
                        onPressed: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          Navigator.of(context, rootNavigator: true).push(
                            new CupertinoPageRoute<ModelDistribuicaoFisicosServicoQuantitativoJson>(
                              maintainState: false,
                              fullscreenDialog: true,
                              builder: (BuildContext context) =>
                              new DistribuicaoFisicosServicoQuantitativoPage(sDistribuicaoFisicosServicoQuantitativo:ListaModelDistribuicaoFisicosServicoQuantitativo[index]),
                            ),
                          ).then((value) {
                            if(value != null)
                            {
                              ListaModelDistribuicaoFisicosServicoQuantitativo.add(value);
                            }
                          });
                        },
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      FlatButton.icon(
                        color: Colors.red,
                        icon: Icon(
                          Icons.delete_outline,
                          color: Colors.white,
                        ),
                        //`Icon` to display
                        label: Text(
                          'Remover ',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 15.0,
                          ),
                        ),
                        //`Text` to display
                        onPressed: () {},
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                      ),
                      SizedBox(width: 10.0),
                    ],
                  ),
                ),
              ],
            )),
      );

  _TipoWidget(BuildContext context) {
    switch (_StatusTipoWidget) {
      case "sem_internet":
        {
          return SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/imagens/img_sem_sinal.png",
                    width: 150.0,
                    height: 150.0,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    "Não há conexão com a internet",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: "avenir-lt-std-roman",
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "Verifique sua conexão com a internet e tente novamente.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: "avenir-lt-std-roman",
                      fontSize: 15.0,
                      color: Colors.black54,
                    ),),
                  SizedBox(height: 20.0),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        var connectivityResult = await (Connectivity().checkConnectivity());
                        if (connectivityResult == ConnectivityResult.none) {
                          setState(() {
                            _StatusTipoWidget = "sem_internet";
                          });
                          _ScaffoldKey.currentState.showSnackBar(SnackBar(
                            onVisible: () {
                              print('Visible');
                            },
                            elevation: 6.0,
                            backgroundColor: Colors.black,
                            behavior: SnackBarBehavior.floating,
                            content: SizedBox(
                              height: 30.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "Tentando reconectar a internet",
                                    softWrap: true,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontFamily: "avenir-lt-std-roman",
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    child: CircularProgressIndicator(
                                      valueColor:
                                      AlwaysStoppedAnimation<Color>(Color(0xff2fdf84)),
                                    ),
                                    height: 30.0,
                                    width: 30.0,
                                  ),
                                ],
                              ),
                            ),
                            duration: Duration(days: 365),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: Colors.black54,
                                width: 2,
                              ),
                            ),
                          ));
                        } else {
                          _ScaffoldKey.currentState.removeCurrentSnackBar();
                          setState(() {
                            _StatusTipoWidget = "renderizar_ficha_sici";
                          });
                        }
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
              ), /* add child content here */
            ),
          );
        }
        break;
      case "renderizar_ficha_sici":
        {
          return Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
            ),
            child: Stepper(
              controlsBuilder: (BuildContext context,
                  {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                return Row(
                  children: <Widget>[
                    Visibility(
                      visible: current_step == 2 ? false : true,
                      child: FlatButton(
                        color: Color(0xff018a8a),
                        //`Icon` to display
                        child: Text(
                          'Próximo',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 15.0,
                          ),
                        ),
                        //`Text` to display
                        onPressed: () async {
                          setState(() {
                            switch (current_step) {
                              case 0:
                                current_step = 1;
                                break;
                              case 1:
                                current_step = 2;
                                break;
                            }
                          });
                        },
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    new Padding(
                      padding: new EdgeInsets.all(10),
                    ),
                    Visibility(
                      visible: current_step > 0 ? true : false,
                      child: FlatButton(
                        onPressed: () async {
                          setState(() {
                            switch (current_step) {
                              case 2:
                                current_step = 1;
                                break;
                              case 1:
                                current_step = 0;
                                break;
                            }
                          });
                        },
                        child: Text(
                          'Cancelar',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff018a8a),
                            fontFamily: 'avenir-lt-std-roman',
                            fontSize: 15.0,
                          ),
                        ),
                        textColor: Color(0xff018a8a),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Color(0xff018a8a),
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    )
                  ],
                );
              },
              steps: <Step>[
                Step(
                  title: SizedBox(
                    width: MediaQuery.of(context).size.width - 90,
                    child: Text(
                      "INFORMAÇÕES DA EMPRESA",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xff000000),
                          fontFamily: "open-sans-regular"),
                    ),
                  ),
                  content: Container(
                    child: Column(
                      children: [
                        SizedBox(height: 20.0),
                        TextFormField(
                          onTap: () {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            OnSelecionarData(context);

                          },
                          controller: _TxtControllerPeriodoReferencia,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.datetime,
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'Período referência:',
                            hintText: '',
                          ),
                          maxLength: 20,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _TxtControllerRazaoSocial,
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
                            labelText: 'Razão social:',
                            hintText: 'Razão social LTDA - ME.',
                          ),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _TxtControllerNomeConsultor ,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          maxLength: 100,
                          decoration: InputDecoration(
                            labelText: 'Responsável - Preenchimento SICI e Fust:',
                            hintText: 'Nome consultor.',
                          ),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _TxtControllerNomeCliente,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          maxLength: 100,
                          decoration: InputDecoration(
                            labelText: 'Cliente:',
                            hintText: 'Nome cliente.',
                          ),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _TxtControllerTelefoneFixo,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          maxLength: 100,
                          decoration: InputDecoration(
                            labelText: 'Telefone Fixo:',
                            hintText: '',
                          ),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _TxtControllerCnpj ,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'CNPJ:',
                            hintText: '',
                          ),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _TxtControllerMesReferencia,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.datetime,
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'MÊS DE REFERÊNCIA:',
                            hintText: '',
                          ),
                          maxLength: 20,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _TxtControllerTelefoneMovel,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'TELEFONE CELULAR:',
                            hintText: '',
                          ),

                          maxLength: 20,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _TxtControllerEmailCliente,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'E-MAIL CLIENTE:',
                            hintText: 'cliente@empresa.com.br',
                          ),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _TxtControllerEmailConsutor,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'E-MAIL CONSULTOR:',
                            hintText: 'consultor@scmengenharia.com.br',
                          ),
                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                  state: current_step > 0 ? StepState.complete : StepState.disabled,
                  isActive: true,
                ),
                Step(
                  title: SizedBox(
                    width: MediaQuery.of(context).size.width - 90,
                    child: Text(
                      "INFORMAÇÕES FINANCEIRAS",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xff000000),
                          fontFamily: "open-sans-regular"),
                    ),
                  ),
                  content: Container(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _TxtControllerReceitaBruta,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'Receita Bruta',
                            hintText: '',
                          ),
                          maxLength: 12,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _TxtControllerSimples,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'Aliquota Simples',
                            hintText: '',
                          ),
                          maxLength: 12,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _TxtControllerSimplesPorc,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'Aliquota Simples %',
                            hintText: '',
                          ),
                          maxLength: 12,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _TxtControllerIcms,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'ICMS',
                            hintText: '',
                          ),
                          maxLength: 12,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _TxtControllerIcmsPorc,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'ICMS (%)',
                            hintText: '',
                          ),
                          maxLength: 12,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _TxtControllerPis,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'PIS',
                            hintText: '',
                          ),
                          maxLength: 12,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _TxtControllerPisPorc,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'PIS (%)',
                            hintText: '',
                          ),
                          maxLength: 12,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _TxtControllerCofins,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'COFINS',
                            hintText: '',
                          ),
                          maxLength: 12,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _TxtControllerCofinsPorc,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'COFINS (%)',
                            hintText: '',
                          ),
                          maxLength: 12,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _TxtControllerReceitaLiquida,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'Receita Liquida',
                            hintText: '',
                          ),
                          maxLength: 12,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _TxtControllerObservacoes,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'Observações Gerais',
                            hintText: '',
                          ),
                          maxLength: 1500,
                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                  state: current_step > 1 ? StepState.complete : StepState.disabled,
                  isActive: true,
                ),
                Step(
                  title: SizedBox(
                    width: MediaQuery.of(context).size.width - 90,
                    child: Text(
                      "DISTRIBUIÇÃO DO QUANTITATIVO DE ACESSOS FÍSICOS EM SERVIÇO",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xff000000),
                          fontFamily: "open-sans-regular"),
                    ),
                  ),
                  content: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 30.0),
                        Center(
                          child: InkWell(
                            onTap: () async {
                              FocusScope.of(context).requestFocus(new FocusNode());
                              Navigator.of(context, rootNavigator: true).push(
                                new CupertinoPageRoute<ModelDistribuicaoFisicosServicoQuantitativoJson>(
                                  maintainState: false,
                                  fullscreenDialog: true,
                                  builder: (BuildContext context) =>
                                  new DistribuicaoFisicosServicoQuantitativoPage(sDistribuicaoFisicosServicoQuantitativo:null),
                                ),
                              ).then((value) {
                                if(value != null)
                                {
                                  ListaModelDistribuicaoFisicosServicoQuantitativo.add(value);
                                }
                              });
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
                        Builder(
                          builder: (BuildContext context) {
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                              ListaModelDistribuicaoFisicosServicoQuantitativo.length,
                              itemBuilder: DistribuicaoFisicosServicoQuantitativoCard,
                            );
                          },
                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                  isActive: true,
                ),
              ],
              type: StepperType.vertical,
              currentStep: current_step,
              onStepTapped: (step) {
                setState(() {
                  current_step = step;
                });
              },
              onStepContinue: () {
                setState(() {
                  if (current_step < spr.length - 1) {
                    current_step = current_step + 1;
                  } else {
                    current_step = 0;
                  }
                });
              },
              onStepCancel: () {
                setState(() {
                  if (current_step > 0) {
                    current_step = current_step - 1;
                  } else {
                    current_step = 0;
                  }
                });
              },
            ),
          );
        }
        break;
    }
  }
}
