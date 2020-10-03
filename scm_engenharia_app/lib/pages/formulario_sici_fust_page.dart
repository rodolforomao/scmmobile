import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:scm_engenharia_app/data/db_helper.dart';
import 'package:scm_engenharia_app/data/tb_distribuicao_quantitativo_acessos_fisicos_servico.dart';
import 'package:scm_engenharia_app/data/tb_ficha_sici.dart';
import 'dart:async';
import 'package:scm_engenharia_app/help/components.dart';
import 'package:scm_engenharia_app/help/masked_text_controller.dart';
import 'package:scm_engenharia_app/menu_navigation.dart';
import 'package:scm_engenharia_app/models/operacao.dart';
import 'package:scm_engenharia_app/pages/distribuicao_fisicos_servico_quantitativo_page.dart';
import "package:flutter/services.dart";

class FormularioSiciFustPage extends StatefulWidget {
  final TbFichaSici FichaSiciModel;

  FormularioSiciFustPage({Key key, @required this.FichaSiciModel})
      : super(key: key);

  @override
  _FormularioSiciFustPageState createState() => _FormularioSiciFustPageState();
}

class CurrencyPtBrInputFormatter extends TextInputFormatter {
  CurrencyPtBrInputFormatter({this.maxDigits});
  final int maxDigits;

  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    if (maxDigits != null && newValue.selection.baseOffset > maxDigits) {
      return oldValue;
    }

    double value = double.parse(newValue.text);
    final formatter = new NumberFormat("#,##0.00", "pt_BR");
    String newText = "R\$ " + formatter.format(value / 100);
    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}

class CurrencyPercentInputFormatter extends TextInputFormatter {
  CurrencyPercentInputFormatter({this.maxDigits});
  final int maxDigits;

  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    if (maxDigits != null && newValue.selection.baseOffset > maxDigits) {
      return oldValue;
    }

    double value = double.parse(newValue.text);
    final formatter = new NumberFormat("##0.00", "pt_BR");
    String newText = formatter.format(value / 100) + "\%";
    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}

class _FormularioSiciFustPageState extends State<FormularioSiciFustPage> {
  final _ScaffoldKey = GlobalKey<ScaffoldState>();
  BuildContext dialogContext;
  DBHelper dbHelper;
  TbFichaSici _FichaSici = new TbFichaSici();

  List<String> Uf = new List<String>();
  String UfTxt, _StatusTipoWidget = "renderizar_ficha_sici";

  DateTime _DataSelecionada = DateTime(DateTime.now().year, DateTime.now().month - 1, 1);

  StreamSubscription<ConnectivityResult> subscription;

  TextEditingController _TxtControllerCnpj =
      new MaskedTextController(mask: '00.000.000/0000-00');
  TextEditingController _TxtControllerRazaoSocial = TextEditingController();

  TextEditingController _TxtControllerTelefoneMovel =
      new MaskedTextController(mask: '(00) 0 0000-0000');
  TextEditingController _TxtControllerTelefoneFixo =
      new MaskedTextController(mask: '(00) 0 0000-0000');

  TextEditingController _TxtControllerPeriodoReferencia =
      TextEditingController();

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

  Future<Null> OnSalvarFormularioDbLocal() async {
    try {
      if (_TxtControllerCnpj.text.isEmpty) throw ("O campo cnpj é obrigatório");
      _FichaSici.periodoReferencia = _TxtControllerPeriodoReferencia.text;
      _FichaSici.isSincronizar = "S";
      _FichaSici.cnpj = _TxtControllerCnpj.text;
      if (_TxtControllerRazaoSocial.text.isEmpty)
        throw ("O campo Razão Social é obrigatório");
      _FichaSici.razaoSocial = _TxtControllerRazaoSocial.text;
      if (_TxtControllerTelefoneMovel.text.isEmpty &&
          _TxtControllerTelefoneFixo.text.isEmpty)
        throw ("Pelo menos um campo 'Telefone' é obrigatório");
      _FichaSici.telefoneMovel = _TxtControllerTelefoneMovel.text;
      _FichaSici.telefoneFixo = _TxtControllerTelefoneFixo.text;
      _FichaSici.receitaBruta = _TxtControllerReceitaBruta.text;
      _FichaSici.receitaLiquida = _TxtControllerReceitaLiquida.text;
      _FichaSici.simples = _TxtControllerSimples.text;
      _FichaSici.simplesPorc = _TxtControllerSimplesPorc.text;
      _FichaSici.icms = _TxtControllerIcms.text;
      _FichaSici.icmsPorc = _TxtControllerIcmsPorc.text;
      _FichaSici.pis = _TxtControllerPis.text;
      _FichaSici.pisPorc = _TxtControllerPisPorc.text;
      _FichaSici.cofins = _TxtControllerCofins.text;
      _FichaSici.cofinsPorc = _TxtControllerCofinsPorc.text;
      _FichaSici.observacoes = _TxtControllerObservacoes.text;
      if (_FichaSici.distribuicaoFisicosServicoQuantitativo.length == 0)
        throw ("Distribuição do quantitativo de acessos físicos em serviço é obrigatório,favor adicionar.");
      else {
        Operacao _respLocal = await dbHelper.OnAddFichaSici(_FichaSici);
        if (_respLocal.erro)
          throw (_respLocal.mensagem);
        else {
          if (dialogContext != null) {
            Navigator.pop(dialogContext);
            setState(() {
              dialogContext = null;
            });
          }
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
                            _respLocal.mensagem,
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
                              Navigator.of(context).pushAndRemoveUntil(
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new MenuNavigation()),
                                  (Route<dynamic> route) => false);
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
      }
    } catch (error) {
      if (dialogContext != null) {
        Navigator.pop(dialogContext);
        setState(() {
          dialogContext = null;
        });
      }
      OnAlertaInformacao(error);
    }
  }

  OnSelecionarData(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.day,
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDate: _DataSelecionada,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(DateTime.now().year, DateTime.now().month - 1, 1),
      errorFormatText: 'Insira uma data válida',
      errorInvalidText: 'Insira a data em um intervalo válido',
      fieldLabelText: 'Período referência ',
      fieldHintText: 'Dia/Mês/Ano',
      helpText: 'Selecione o período referência',
    );
    if (picked != null) {
      setState(() {
        _DataSelecionada = DateTime(picked.year, picked.month, 1);
        _TxtControllerPeriodoReferencia.text = DateFormat('dd/MM/yyyy').format(DateTime(picked.year, picked.month, 1));
      });
    }

    // DateTime selectedDate = DateTime.parse("01-07-2020");

    // showMonthPicker(
    //   context: context,
    //   firstDate: DateTime(DateTime.now().year - 2, 5),
    //   lastDate: DateTime(DateTime.now().year, 9),
    //   initialDate: selectedDate ?? DateTime.parse("01-07-2020"),
    //   locale: Locale("us"),
    // ).then((date) {
    //   if (date != null) {
    //     setState(() {
    //       selectedDate = date;
    //     });
    //   }
    // });

    // if (selectedDate != null && selectedDate != _DataSelecionada) {
    //   setState(() {
    //     _DataSelecionada =
    //         DateTime(selectedDate.year, selectedDate.month - 1, 1);
    //     _TxtControllerPeriodoReferencia.text = DateFormat('dd/MM/yyyy')
    //         .format(DateTime(selectedDate.year, selectedDate.month, 1));
    //   });
    // }
  }

  Inc() async {
    try {
      Uf = await Components.OnlistaEstados() as List<String>;
      setState(() {
        UfTxt = Uf.first;
      });
      if (widget.FichaSiciModel != null) {
        _FichaSici = widget.FichaSiciModel;
        if(widget.FichaSiciModel.periodoReferencia.isNotEmpty)
          {
            _DataSelecionada = DateTime.parse(widget.FichaSiciModel.periodoReferencia);
            _TxtControllerPeriodoReferencia.text = DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.FichaSiciModel.periodoReferencia));
          }
        _TxtControllerCnpj.text = widget.FichaSiciModel.cnpj;
        _TxtControllerRazaoSocial.text = widget.FichaSiciModel.razaoSocial;
        _TxtControllerTelefoneMovel.text = widget.FichaSiciModel.telefoneMovel;
        _TxtControllerTelefoneFixo.text = widget.FichaSiciModel.telefoneFixo;
        _TxtControllerReceitaBruta.text = widget.FichaSiciModel.receitaBruta;
        _TxtControllerReceitaLiquida.text =
            widget.FichaSiciModel.receitaLiquida;
        _TxtControllerSimples.text = widget.FichaSiciModel.simples;
        _TxtControllerSimplesPorc.text = widget.FichaSiciModel.simplesPorc;
        _TxtControllerIcms.text = widget.FichaSiciModel.icms;
        _TxtControllerIcmsPorc.text = widget.FichaSiciModel.icmsPorc;
        _TxtControllerPis.text = widget.FichaSiciModel.pis;
        _TxtControllerPisPorc.text = widget.FichaSiciModel.pisPorc;
        _TxtControllerCofins.text = widget.FichaSiciModel.cofins;
        _TxtControllerCofinsPorc.text = widget.FichaSiciModel.cofinsPorc;
        _TxtControllerObservacoes.text = widget.FichaSiciModel.observacoes;
      } else {
        _FichaSici.distribuicaoFisicosServicoQuantitativo =
            new List<TbDistribuicaoQuantitativoAcessosFisicosServico>();
      }
    } catch (error) {
      OnAlertaInformacao(error.toString());
      //Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  void initState() {
    dbHelper = DBHelper();
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
                OnSalvarFormularioDbLocal();
              },
              child: Center(
                child: Text(
                  'Salvar   ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'avenir-lt-std-roman',
                    fontSize: 15.0,
                  ),
                ),
              )),
        ],
      ),
      body: _TipoWidget(context),
    );
  }

  Card DistribuicaoFisicosServicoQuantitativoCard(
          BuildContext context, int index) =>
      Card(
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
                          text: _FichaSici
                              .distribuicaoFisicosServicoQuantitativo[index].uf,
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
                          text: _FichaSici
                              .distribuicaoFisicosServicoQuantitativo[index]
                              .municipio,
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
                          text: _FichaSici
                              .distribuicaoFisicosServicoQuantitativo[index]
                              .tecnologia,
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
                          text: _FichaSici
                              .distribuicaoFisicosServicoQuantitativo[index]
                              .cod_ibge,
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
                          text: _FichaSici
                              .distribuicaoFisicosServicoQuantitativo[index]
                              .pf_0,
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
                          text: _FichaSici
                              .distribuicaoFisicosServicoQuantitativo[index]
                              .pf_512,
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
                          text: _FichaSici
                              .distribuicaoFisicosServicoQuantitativo[index]
                              .pf_2,
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
                          text: _FichaSici
                              .distribuicaoFisicosServicoQuantitativo[index]
                              .pf_12,
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
                          text: _FichaSici
                              .distribuicaoFisicosServicoQuantitativo[index]
                              .pf_34,
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
                          text: _FichaSici
                              .distribuicaoFisicosServicoQuantitativo[index]
                              .pj_0,
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
                          text: _FichaSici
                              .distribuicaoFisicosServicoQuantitativo[index]
                              .pj_512,
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
                          text: _FichaSici
                              .distribuicaoFisicosServicoQuantitativo[index]
                              .pj_2,
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
                          text: _FichaSici
                              .distribuicaoFisicosServicoQuantitativo[index]
                              .pj_12,
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
                          text: _FichaSici
                              .distribuicaoFisicosServicoQuantitativo[index]
                              .pj_34,
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
                          Navigator.of(context, rootNavigator: true)
                              .push(
                            new CupertinoPageRoute<
                                TbDistribuicaoQuantitativoAcessosFisicosServico>(
                              maintainState: false,
                              fullscreenDialog: true,
                              builder: (BuildContext context) =>
                                  new DistribuicaoFisicosServicoQuantitativoPage(
                                      sDistribuicaoFisicosServicoQuantitativo:
                                          _FichaSici
                                                  .distribuicaoFisicosServicoQuantitativo[
                                              index]),
                            ),
                          )
                              .then((value) {
                            if (value != null) {
                              int Index = _FichaSici
                                  .distribuicaoFisicosServicoQuantitativo
                                  .indexWhere(
                                      (item) => item.index == value.index);
                              setState(() {
                                _FichaSici
                                        .distribuicaoFisicosServicoQuantitativo[
                                    Index] = value;
                              });
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
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return Dialog(
                                  child: new Padding(
                                padding: EdgeInsets.all(25.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0.0, 10.0, 0.0, 15.0),
                                      height: 50.0,
                                      child: new Text(
                                        "Deseja realmente remover ?",
                                        textAlign: TextAlign.start,
                                        softWrap: false,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontFamily: 'open-sans-regular',
                                            fontSize: 17.0,
                                            color: Color(0xFF000000)),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0.0, 10.0, 0.0, 15.0),
                                      child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          OutlineButton(
                                            color: Color(0xFFf2f2f2),
                                            //`Icon` to display
                                            child: Text('Sim',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily:
                                                      'avenir-lt-std-roman',
                                                  color: Color(0xff018a8a),
                                                  fontSize: 16.0,
                                                )),
                                            onPressed: () async {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      new FocusNode());
                                              if (_FichaSici
                                                          .distribuicaoFisicosServicoQuantitativo[
                                                              index]
                                                          .idApp ==
                                                      null ||
                                                  _FichaSici
                                                          .distribuicaoFisicosServicoQuantitativo[
                                                              index]
                                                          .idApp ==
                                                      0) {
                                                setState(() {
                                                  _FichaSici
                                                      .distribuicaoFisicosServicoQuantitativo
                                                      .remove(_FichaSici
                                                              .distribuicaoFisicosServicoQuantitativo[
                                                          index]);
                                                });
                                              } else {
                                                Operacao _respLocal = await dbHelper
                                                    .OnDeletarDistribuicaoQuantitativoAcessosFisicosServico(
                                                        _FichaSici
                                                            .distribuicaoFisicosServicoQuantitativo[
                                                                index]
                                                            .idApp);
                                                if (_respLocal.erro)
                                                  throw (_respLocal.mensagem);
                                                else {
                                                  setState(() {
                                                    _FichaSici
                                                        .distribuicaoFisicosServicoQuantitativo
                                                        .remove(_FichaSici
                                                                .distribuicaoFisicosServicoQuantitativo[
                                                            index]);
                                                  });
                                                  OnAlertaInformacao(
                                                      _respLocal.mensagem);
                                                }
                                              }
                                              Navigator.pop(context);
                                            },
                                            borderSide: BorderSide(
                                              color: Color(0xFFf2f2f2),
                                              //Color of the border
                                              style: BorderStyle.solid,
                                              //Style of the border
                                              width: 1.0, //width of the border
                                            ),
                                          ),
                                          SizedBox(width: 15.0),
                                          FlatButton(
                                            color: Color(0xff018a8a),
                                            //`Icon` to display
                                            child: Text('Não',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily:
                                                      'avenir-lt-std-roman',
                                                  color: Color(0xffFFFFFF),
                                                  fontSize: 16.0,
                                                )),
                                            //`Text` to display
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      5.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                            },
                          );
                        },
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
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        var connectivityResult =
                            await (Connectivity().checkConnectivity());
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(0xff2fdf84)),
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
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
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
                          controller: _TxtControllerTelefoneFixo,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
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
                          controller: _TxtControllerCnpj,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'CNPJ:',
                            hintText: '',
                          ),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _TxtControllerTelefoneMovel,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'TELEFONE CELULAR:',
                            hintText: '',
                          ),
                          maxLength: 20,
                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                  state: current_step > 0
                      ? StepState.complete
                      : StepState.disabled,
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
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            CurrencyPtBrInputFormatter()
                          ],
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'Receita Bruta',
                            hintText: '',
                          ),
                          maxLength: 20,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _TxtControllerSimples,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            CurrencyPtBrInputFormatter()
                          ],
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'Aliquota Simples',
                            hintText: '',
                          ),
                          maxLength: 20,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _TxtControllerSimplesPorc,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            CurrencyPercentInputFormatter()
                          ],
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
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            CurrencyPtBrInputFormatter()
                          ],
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'ICMS',
                            hintText: '',
                          ),
                          maxLength: 20,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _TxtControllerIcmsPorc,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            CurrencyPercentInputFormatter()
                          ],
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
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            CurrencyPtBrInputFormatter()
                          ],
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'PIS',
                            hintText: '',
                          ),
                          maxLength: 20,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _TxtControllerPisPorc,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            CurrencyPercentInputFormatter()
                          ],
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
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            CurrencyPtBrInputFormatter()
                          ],
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'COFINS',
                            hintText: '',
                          ),
                          maxLength: 20,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _TxtControllerCofinsPorc,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            CurrencyPercentInputFormatter()
                          ],
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
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            CurrencyPtBrInputFormatter()
                          ],
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'Receita Liquida',
                            hintText: '',
                          ),
                          maxLength: 20,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _TxtControllerObservacoes,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
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
                  state: current_step > 1
                      ? StepState.complete
                      : StepState.disabled,
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
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              Navigator.of(context, rootNavigator: true)
                                  .push(
                                new CupertinoPageRoute<
                                    TbDistribuicaoQuantitativoAcessosFisicosServico>(
                                  maintainState: false,
                                  fullscreenDialog: true,
                                  builder: (BuildContext context) =>
                                      new DistribuicaoFisicosServicoQuantitativoPage(
                                          sDistribuicaoFisicosServicoQuantitativo:
                                              null),
                                ),
                              )
                                  .then((value) {
                                if (value != null) {
                                  if (_FichaSici
                                          .distribuicaoFisicosServicoQuantitativo ==
                                      null) {
                                    value.index = 1;
                                    _FichaSici
                                            .distribuicaoFisicosServicoQuantitativo =
                                        List<
                                            TbDistribuicaoQuantitativoAcessosFisicosServico>();
                                  } else
                                    value.index = _FichaSici
                                            .distribuicaoFisicosServicoQuantitativo
                                            .length +
                                        1;
                                  _FichaSici
                                      .distribuicaoFisicosServicoQuantitativo
                                      .add(value);
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
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
                              itemCount: _FichaSici
                                          .distribuicaoFisicosServicoQuantitativo ==
                                      null
                                  ? 0
                                  : _FichaSici
                                      .distribuicaoFisicosServicoQuantitativo
                                      .length,
                              itemBuilder:
                                  DistribuicaoFisicosServicoQuantitativoCard,
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
