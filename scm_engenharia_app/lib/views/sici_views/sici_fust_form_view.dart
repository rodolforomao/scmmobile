import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import "package:flutter/services.dart";
import '../../data/app_scm_engenharia_mobile_bll.dart';
import '../../data/tb_form_sici_fust.dart';
import '../../help/componentes.dart';
import '../../models/Operation.dart';
import '../../models/sici_file_model.dart';
import '../help_views/global_scaffold.dart';


class SiciFustFormView extends StatefulWidget {
  SiciFileModel? siciFileModel;

  SiciFustFormView({ Key? key, required this.siciFileModel})
      : super(key: key);

  @override
  SiciFustFormState createState() => SiciFustFormState();
}

class CurrencyPtBrInputFormatter extends TextInputFormatter {
  CurrencyPtBrInputFormatter({required this.maxDigits});
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
  CurrencyPercentInputFormatter({required this.maxDigits});
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

class SiciFustFormState extends State<SiciFustFormView> {



  List<String> Uf = [];
  late String UfTxt, _StatusTipoWidget = "renderizar_ficha_sici";

  DateTime _DataSelecionada = DateTime(DateTime.now().year, DateTime.now().month - 1, 1);



 // TextEditingController _TxtControllerCnpj = new MaskedTextController(mask: '00.000.000/0000-00');
  TextEditingController _TxtControllerRazaoSocial = TextEditingController();

 // TextEditingController _TxtControllerTelefoneMovel = new MaskedTextController(mask: '(00) 0 0000-0000');
 // TextEditingController _TxtControllerTelefoneFixo = new MaskedTextController(mask: '(00) 0 0000-0000');

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



   onSaveLocalDbForm()  async {
    try {

    } catch (error) {
     // onRealizandoOperacao('', false, context);
     // onAlertaInformacaoSucesso(error.toString(), context);
    }
  }

  OnSelecionarData(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.year,
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDate: _DataSelecionada,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(DateTime.now().year, DateTime.now().month - 1),
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
      Uf = await Componentes.OnlistaEstados() as List<String>;
      setState(() {
        UfTxt = Uf.first;
      });
      if (widget.siciFileModel != null) {
       // siciFileModel = widget.siciFileModel!;
        if (widget.siciFileModel!.periodoReferencia!.isNotEmpty) {
          _DataSelecionada =
              DateTime.parse(widget.siciFileModel!.periodoReferencia!);
          _TxtControllerPeriodoReferencia.text = DateFormat('dd/MM/yyyy')
              .format(DateTime.parse(widget.siciFileModel!.periodoReferencia!));
        }
       // _TxtControllerCnpj.text = widget.siciFileModel!.cnpj!;
        _TxtControllerRazaoSocial.text = widget.siciFileModel!.razaoSocial!;
       // _TxtControllerTelefoneMovel.text = widget.siciFileModel!.telefoneMovel!;
        //_TxtControllerTelefoneFixo.text = widget.siciFileModel!.telefoneFixo!;
        _TxtControllerReceitaBruta.text = widget.siciFileModel!.receitaBruta!;
        _TxtControllerReceitaLiquida.text = widget.siciFileModel!.receitaLiquida!;
        _TxtControllerSimples.text = widget.siciFileModel!.simples!;
        _TxtControllerSimplesPorc.text = widget.siciFileModel!.simplesPorc!;
        _TxtControllerIcms.text = widget.siciFileModel!.icms!;
        _TxtControllerIcmsPorc.text = widget.siciFileModel!.icmsPorc!;
        _TxtControllerPis.text = widget.siciFileModel!.pis!;
        _TxtControllerPisPorc.text = widget.siciFileModel!.pisPorc!;
        _TxtControllerCofins.text = widget.siciFileModel!.cofins!;
        _TxtControllerCofinsPorc.text = widget.siciFileModel!.cofinsPorc!;
        _TxtControllerObservacoes.text = widget.siciFileModel!.observacoes!;
      } else {
        //siciFileModel.distribuicaoFisicosServicoQuantitativo = [];
      }
    } catch (error) {
      OnAlertaInformacaoErro(error.toString(),context);
      //Navigator.of(context, rootNavigator: true).pop();
    }
  }



  @override
  void initState() {
    super.initState();
    _TxtControllerPeriodoReferencia.text =  DateFormat('dd/MM/yyyy').format(DateTime(DateTime.now().year, DateTime.now().month - 1));
    Inc();
  }

  int current_step = 0;
  List<Step> spr = <Step>[];

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
                  onSaveLocalDbForm();
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
        body: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: Stepper(
            controlsBuilder: (BuildContext context, ControlsDetails details)
            {
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
        )
    );
  }

  Card DistribuicaoFisicosServicoQuantitativoCard(BuildContext context, int index) =>
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

              ],
            )),
      );
}
