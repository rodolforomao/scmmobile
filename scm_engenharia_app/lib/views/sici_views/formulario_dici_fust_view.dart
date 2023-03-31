import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import "package:flutter/services.dart";
import 'package:realm/realm.dart';
import '../../data/app_scm_engenharia_mobile_bll.dart';
import '../../data/tb_form_sici_fust.dart';
import '../../help/components.dart';
import '../../help/formatter/cnpj_input_formatter.dart';
import '../../help/formatter/telefone_input_formatter.dart';
import '../../help/formatter/util_fields.dart';
import '../../help/formatter/valor_input_formatter.dart';
import '../../models/input/input_sici_fust_form_model.dart';
import '../../models/operation.dart';
import '../../thema/app_thema.dart';
import '../help_views/global_scaffold.dart';
import '../help_views/global_view.dart';
import 'dados_em_servicos_view.dart';

class FormularioDiciFustView extends StatefulWidget {
  InputSiciFileModel? siciFileModel;
  FormularioDiciFustView({Key? key, required this.siciFileModel})
      : super(key: key);

  @override
  FormularioDiciFustState createState() => FormularioDiciFustState();
}

abstract class IsSilly {}

class FormularioDiciFustState extends State<FormularioDiciFustView>
    implements IsSilly {
  InputSiciFileModel inputSiciFustForm = InputSiciFileModel();

  List<String> Uf = [];
  late String UfTxt;

  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month - 1, 1);

  //Período referência
  final txtControllerReferencePeriod = TextEditingController();
  final focusNodeReferencePeriod = FocusNode();

  // Razão social LTDA - ME.
  final txtControllerSocialReason = TextEditingController();
  final focusNodeSocialReason = FocusNode();

  //Telefone Fixo:
  final txtControllerLandline = TextEditingController();
  final focusNodeLandline = FocusNode();

  //CNPJ:
  final txtControllerCnpj = TextEditingController();
  final focusNodeCnpj = FocusNode();

  //TELEFONE CELULAR:
  final txtControllerTelefoneMovel = TextEditingController();
  final focusNodeTelefoneMovel = FocusNode();

  // Receita Bruta
  final txtControllerGrossRevenue = TextEditingController();
  final focusNodeGrossRevenue = FocusNode();
  // Valor Simples
  final txtControllerSimpleValue = TextEditingController();
  final focusNodeSimpleValue = FocusNode();
  // Aliquota Simples %
  final txtControllerSimpleAliquot = TextEditingController();
  final focusNodeSimpleAliquot = FocusNode();
  // Valor ICMS
  final txtControllerICMSvalue = TextEditingController();
  final focusNodeICMSvalue = FocusNode();
  //ICMS (%)
  final txtControllerIcmsPorc = TextEditingController();
  final focusNodeIcmsPorc = FocusNode();
  // Valor PIS
  final txtControllerPis = TextEditingController();
  final focusNodePis = FocusNode();
  //PIS (%)
  final txtControllerPisPorc = TextEditingController();
  final focusNodePisPorc = FocusNode();
  //Valor COFINS
  final txtControllerCofins = TextEditingController();
  final focusNodeCofins = FocusNode();
  //Valor COFINS (%)
  final txtControllerCofinsPorc = TextEditingController();
  final focusNodeCofinsPorc = FocusNode();
  // Receita Liquida
  final txtControllerNetRevenue = TextEditingController();
  final focusNodeNetRevenue = FocusNode();
  // Observações Gerais
  final txtControllerGeneralObservations = TextEditingController();
  final focusNodeGeneralObservations = FocusNode();

  onSaveLocalDbForm() async {
    try {
      if (txtControllerCnpj.text.isEmpty) throw ('O campo cnpj é obrigatório');
      inputSiciFustForm.periodoReferencia = txtControllerReferencePeriod.text;
      inputSiciFustForm.cnpj = txtControllerCnpj.text;
      if (txtControllerSocialReason.text.isEmpty) {
        throw ('O campo Razão Social é obrigatório');
      }
      inputSiciFustForm.razaoSocial = txtControllerSocialReason.text;
      if (txtControllerTelefoneMovel.text.isEmpty &&
          txtControllerLandline.text.isEmpty) {
        throw ("Pelo menos um campo Telefone é obrigatório");
      }
      inputSiciFustForm.telefoneMovel = txtControllerTelefoneMovel.text;
      inputSiciFustForm.telefoneFixo = txtControllerLandline.text;
      inputSiciFustForm.receitaBruta = txtControllerGrossRevenue.text;
      inputSiciFustForm.receitaLiquida = txtControllerNetRevenue.text;
      inputSiciFustForm.simples = txtControllerSimpleValue.text;
      inputSiciFustForm.simplesPorc = txtControllerSimpleAliquot.text;
      inputSiciFustForm.icms = txtControllerICMSvalue.text;
      inputSiciFustForm.icmsPorc = txtControllerIcmsPorc.text;
      inputSiciFustForm.pis = txtControllerPis.text;
      inputSiciFustForm.pisPorc = txtControllerPisPorc.text;
      inputSiciFustForm.cofins = txtControllerCofins.text;
      inputSiciFustForm.cofinsPorc = txtControllerCofinsPorc.text;
      inputSiciFustForm.observacoes = txtControllerGeneralObservations.text;
      if (inputSiciFustForm.dadosEmServicos!.isEmpty) {
        throw ('Distribuição do quantitativo de acessos físicos em serviço é obrigatório,favor adicionar.');
      } else {
        GlobalScaffold.instance
            .onToastPerformingOperation('Realizando operação');
        var formSiciFust = TbFormSiciFust(
            ObjectId(),
            inputSiciFustForm.id ?? "",
            jsonEncode(inputSiciFustForm.toJson() ?? ""));
        if (inputSiciFustForm.idFichaSiciApp!.isNotEmpty) {
          formSiciFust = TbFormSiciFust(
              ObjectId.fromHexString(inputSiciFustForm.idFichaSiciApp!),
              inputSiciFustForm.id ?? "",
              jsonEncode(inputSiciFustForm.toJson() ?? ""));
        }
        Operation respFormSiciFust = await AppScmEngenhariaMobileBll.instance
            .onSaveUpdateFormSiciFust(
                inputSiciFustForm.idFichaSiciApp!, formSiciFust)
            .whenComplete(
                () => GlobalScaffold.instance.onHideCurrentSnackBar());
        if (respFormSiciFust.erro) {
          throw respFormSiciFust.message!;
        } else if (respFormSiciFust.result == null) {
          throw respFormSiciFust.message!;
        } else {
          TbFormSiciFust res = respFormSiciFust.result as TbFormSiciFust;
          inputSiciFustForm.idFichaSiciApp = res.idFichaSiciApp.toString();
          showDialog(
            context: GlobalScaffold.instance.navigatorKey.currentContext!,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Dialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 70,
                      maxWidth: 600,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 15.0),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Informação',
                              style: Theme.of(GlobalScaffold
                                      .instance.navigatorKey.currentContext!)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(
                                    fontSize: 20,
                                    color: const Color(0xff737373),
                                    fontWeight: FontWeight.w200,
                                  ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              color: Colors.black12,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  15.0, 10.0, 15.0, 10.0),
                              child: Text(
                                respFormSiciFust.message!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 10,
                                softWrap: false,
                                style: Theme.of(GlobalScaffold
                                        .instance.navigatorKey.currentContext!)
                                    .textTheme
                                    .headline4
                                    ?.copyWith(
                                      fontSize: 15,
                                      color: const Color(0xff737373),
                                      fontWeight: FontWeight.w100,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.black12,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
                          child: Center(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                backgroundColor: const Color(0xff2ecd8f),
                                side: const BorderSide(
                                  color:
                                      Color(0xff2ecd8f), //Color of the border
                                  style:
                                      BorderStyle.solid, //Style of the border
                                  width: 1.0, //width of the border
                                ),
                              ),
                              child: const Text(
                                'OK',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                              //`Text` to display
                              onPressed: () {
                                Navigator.pop(context);
                                GlobalScaffold.instance.navigatorKey.currentState?.pop(true);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
            },
          );
        }
      }
    } catch (error) {
      OnAlertError(error.toString());
    }
  }

  onSelectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.year,
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDate: selectedDate,
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
        selectedDate = DateTime(picked.year, picked.month, 1);
        txtControllerReferencePeriod.text = DateFormat('dd/MM/yyyy')
            .format(DateTime(picked.year, picked.month, 1));
      });
    }
  }

  onInc() async {
    try {
      Uf = await Components.OnlistaEstados() as List<String>;
      setState(() {
        UfTxt = Uf.first;
      });
      if (widget.siciFileModel != null) {
        inputSiciFustForm = widget.siciFileModel!;
        if (widget.siciFileModel!.periodoReferencia!.isNotEmpty) {
          selectedDate = DateFormat("dd/MM/yyyy")
              .parse(widget.siciFileModel!.periodoReferencia!);
          txtControllerReferencePeriod.text =
              DateFormat('dd/MM/yyyy').format(selectedDate);
        }
        // Razão social LTDA - ME.
        txtControllerSocialReason.text = widget.siciFileModel!.razaoSocial!;
        //Telefone Fixo:
        txtControllerLandline.text = widget.siciFileModel!.telefoneFixo!;
        //CNPJ:
        txtControllerCnpj.text = CNPJValidator.format(widget.siciFileModel!.cnpj!);
        //TELEFONE CELULAR:
        txtControllerTelefoneMovel.text = widget.siciFileModel!.telefoneMovel! ;
        // Receita Bruta
        txtControllerGrossRevenue.text = widget.siciFileModel!.receitaBruta!;
        // Valor Simples
        txtControllerSimpleValue.text = widget.siciFileModel!.simples!;
        // Aliquota Simples %
        txtControllerSimpleAliquot.text = widget.siciFileModel!.simplesPorc!;
        // Valor ICMS
        txtControllerICMSvalue.text = widget.siciFileModel!.icms!;
        //ICMS (%)
        txtControllerIcmsPorc.text = widget.siciFileModel!.icmsPorc!;
        // Valor PIS
        txtControllerPis.text = widget.siciFileModel!.pis!;
        //PIS (%)
        txtControllerPisPorc.text = widget.siciFileModel!.pisPorc!;
        //Valor COFINS
        txtControllerCofins.text = widget.siciFileModel!.cofins!;
        // Receita Liquida
        txtControllerNetRevenue.text = widget.siciFileModel!.receitaLiquida!;
        // Observações Gerais
        txtControllerGeneralObservations.text =
            widget.siciFileModel!.observacoes!;
      } else {}
    } catch (error) {
      OnAlertError(error.toString());
      //Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    txtControllerReferencePeriod.text = DateFormat('dd/MM/yyyy')
        .format(DateTime(DateTime.now().year, DateTime.now().month - 1));
    onInc();
  }

  int currentStep = 0;
  List<Step> spr = <Step>[];

  @override
  Widget build(BuildContext context) {
    double maxHeight = GlobalView.maxHeightAppBar(context, 55);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: AppBar(
          centerTitle: true,
          flexibleSpace: Container(
            decoration: StylesThemas.boxDecorationAppBar,
          ),
          title: const Text(
            'Formulário Dici - Fust',
          ),
          actions: <Widget>[
            InkWell(
                onTap: () {
                  onSaveLocalDbForm();
                },
                child: const Center(
                  child: Text(
                    ' Salvar   ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Poppins-Regular',
                      fontSize: 15.0,
                    ),
                  ),
                )),
          ],
          toolbarHeight: 50,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          alignment: Alignment.topCenter,
          constraints: const BoxConstraints(
            maxWidth: 1000,
          ),
          child: GlobalView.viewRenderSingleChildScrollView(
              maxHeight,
              Stepper(
                physics: const ClampingScrollPhysics(),
                controlsBuilder:
                    (BuildContext context, ControlsDetails details) {
                  return Align( alignment: Alignment.bottomRight, child: Container(
                    alignment: Alignment.bottomRight,
                    constraints: const BoxConstraints(
                      maxWidth: 300,
                      minWidth: 300,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Visibility(
                          visible: currentStep > 0 ? true : false,
                          child:Expanded(
                            flex: 2,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xff888888),
                                padding:
                                const EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 3.0),
                                minimumSize: const Size(130, 43),
                                maximumSize: const Size(130, 43),
                                textStyle: const TextStyle(
                                  color: Color(0xffFFFFFF),
                                  fontSize: 13,
                                ),
                              ),
                              onPressed: () async {
                                setState(() {
                                  switch (currentStep) {
                                    case 2:
                                      currentStep = 1;
                                      break;
                                    case 1:
                                      currentStep = 0;
                                      break;
                                  }
                                });
                              },
                              child: const Text(
                                'Anterior',
                                style: TextStyle(
                                  color: Color(0xffFFFFFF),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10),
                        ),
                        Visibility(
                          visible: currentStep == 2 ? false : true,
                          child: Expanded(
                            flex: 2,
                            child:  TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xffef7d00),
                                padding:
                                const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
                                minimumSize: const Size(130, 43),
                                maximumSize: const Size(130, 43),
                                textStyle: const TextStyle(
                                  color: Color(0xffFFFFFF),
                                  fontSize: 13,
                                ),
                              ),
                              onPressed: () async {
                                setState(() {
                                  switch (currentStep) {
                                    case 0:
                                      currentStep = 1;
                                      break;
                                    case 1:
                                      currentStep = 2;
                                      break;
                                  }
                                });
                              },
                              child: const Text(
                                'Próximo',
                                style: TextStyle(
                                  color: Color(0xffFFFFFF),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),);
                },
                steps: <Step>[
                  Step(
                    title: SizedBox(
                      width: MediaQuery.of(context).size.width - 90,
                      child: Text(
                        'informações da empresa',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(fontSize: 17),
                      ),
                    ),
                    content: GlobalView.viewResponsiveGridTextField(
                        context,
                        5,
                        600,
                        [
                          TextField(
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              onSelectedDate(context);
                            },
                            keyboardType: TextInputType.datetime,
                            controller: txtControllerReferencePeriod,
                            focusNode: focusNodeReferencePeriod,
                            textInputAction: TextInputAction.next,
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins-Regular',
                                fontWeight: FontWeight.w100,
                                color: Color(0xFF323232)),
                            onSubmitted: (term) {
                              focusNodeReferencePeriod.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(focusNodeSocialReason);
                            },
                            decoration: const InputDecoration(
                              labelText: 'Período referência:',
                              hintText: '',
                            ),
                            maxLength: 20,
                          ),
                          TextField(
                            keyboardType: TextInputType.text,
                            controller: txtControllerSocialReason,
                            focusNode: focusNodeSocialReason,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (term) {
                              focusNodeSocialReason.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(focusNodeLandline);
                            },
                            maxLength: 100,
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins-Regular',
                                fontWeight: FontWeight.w100,
                                color: Color(0xFF323232)),
                            decoration: const InputDecoration(
                              labelText: 'Razão social:',
                              hintText: 'Razão social LTDA - ME.',
                            ),
                          ),
                          TextField(
                            keyboardType: TextInputType.phone,
                            controller: txtControllerLandline,
                            focusNode: focusNodeLandline,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (term) {
                              focusNodeLandline.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(focusNodeCnpj);
                            },
                            inputFormatters: [
                              // obrigatório
                              FilteringTextInputFormatter.digitsOnly,
                              TelefoneInputFormatter(),
                            ],
                            maxLength: 100,
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins-Regular',
                                fontWeight: FontWeight.w100,
                                color: Color(0xFF323232)),
                            decoration: const InputDecoration(
                              labelText: 'Telefone Fixo:',
                              hintText: '',
                            ),
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            controller: txtControllerCnpj,
                            focusNode: focusNodeCnpj,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (term) {
                              focusNodeCnpj.unfocus();
                              FocusScope.of(context).requestFocus(focusNodeTelefoneMovel);
                            },
                            inputFormatters: [
                              // obrigatório
                              CurrencyInputFormatter(),
                              FilteringTextInputFormatter.digitsOnly,
                              CnpjInputFormatter(),
                            ],
                            autofocus: false,
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins-Regular',
                                fontWeight: FontWeight.w100,
                                color: Color(0xFF323232)),
                            decoration: const InputDecoration(
                              labelText: 'CNPJ:',
                              hintText: '',
                            ),
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            controller: txtControllerTelefoneMovel,
                            focusNode: focusNodeTelefoneMovel,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (term) {
                              focusNodeTelefoneMovel.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(focusNodeGrossRevenue);
                            },
                            inputFormatters: [
                              // obrigatório
                              FilteringTextInputFormatter.digitsOnly,
                              TelefoneInputFormatter(),
                            ],
                            autofocus: false,
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins-Regular',
                                fontWeight: FontWeight.w100,
                                color: Color(0xFF323232)),
                            decoration: const InputDecoration(
                              labelText: 'TELEFONE CELULAR:',
                              hintText: '',
                            ),
                            maxLength: 20,
                          ),
                        ].toList()),
                    state: currentStep > 0
                        ? StepState.complete
                        : StepState.disabled,
                    isActive: true,
                  ),
                  Step(
                    title: SizedBox(
                      width: MediaQuery.of(context).size.width - 90,
                      child: Text(
                        'informações financeiras',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(fontSize: 15),
                      ),
                    ),
                    content: GlobalView.viewResponsiveGridTextField(
                        context,
                        7,
                        600,
                        [
                          TextField(
                            keyboardType: TextInputType.number,
                            controller: txtControllerGrossRevenue,
                            focusNode: focusNodeGrossRevenue,
                            textInputAction: TextInputAction.next,
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins-Regular',
                                fontWeight: FontWeight.w100,
                                color: Color(0xFF323232)),
                            onSubmitted: (term) {
                              focusNodeGrossRevenue.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(focusNodeSimpleValue);
                            },
                            textAlign: TextAlign.start,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CurrencyPtBrInputFormatter()
                            ],
                            decoration: const InputDecoration(
                              labelText: 'Receita Bruta',
                              hintText: '',
                            ),
                            maxLength: 20,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: txtControllerSimpleValue,
                                  focusNode: focusNodeSimpleValue,
                                  textInputAction: TextInputAction.next,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins-Regular',
                                      fontWeight: FontWeight.w100,
                                      color: Color(0xFF323232)),
                                  onSubmitted: (term) {
                                    focusNodeSimpleValue.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(focusNodeSimpleAliquot);
                                  },
                                  textAlign: TextAlign.start,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    CurrencyPtBrInputFormatter()
                                  ],
                                  autofocus: false,
                                  decoration: const InputDecoration(
                                    labelText: 'Valor Simples',
                                    hintText: '',
                                  ),
                                  maxLength: 20,
                                ),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: txtControllerSimpleAliquot,
                                  focusNode: focusNodeSimpleAliquot,
                                  textInputAction: TextInputAction.next,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins-Regular',
                                      fontWeight: FontWeight.w100,
                                      color: Color(0xFF323232)),
                                  onSubmitted: (term) {
                                    focusNodeSimpleAliquot.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(focusNodeICMSvalue);
                                  },
                                  textAlign: TextAlign.start,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    CurrencyPercentInputFormatter()
                                  ],
                                  autofocus: false,
                                  decoration: const InputDecoration(
                                    labelText: 'Aliquota Simples %',
                                    hintText: '',
                                  ),
                                  maxLength: 7,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  controller: txtControllerICMSvalue,
                                  focusNode: focusNodeICMSvalue,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins-Regular',
                                      fontWeight: FontWeight.w100,
                                      color: Color(0xFF323232)),
                                  onSubmitted: (term) {
                                    focusNodeICMSvalue.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(focusNodeIcmsPorc);
                                  },
                                  textAlign: TextAlign.start,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    CurrencyPtBrInputFormatter()
                                  ],
                                  autofocus: false,
                                  decoration: const InputDecoration(
                                    labelText: 'Valor ICMS',
                                    hintText: '',
                                  ),
                                  maxLength: 20,
                                ),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: TextField(
                                  controller: txtControllerIcmsPorc,
                                  keyboardType: TextInputType.number,
                                  focusNode: focusNodeIcmsPorc,
                                  textInputAction: TextInputAction.next,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins-Regular',
                                      fontWeight: FontWeight.w100,
                                      color: Color(0xFF323232)),
                                  onSubmitted: (term) {
                                    focusNodeIcmsPorc.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(focusNodePis);
                                  },
                                  textAlign: TextAlign.start,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    CurrencyPercentInputFormatter()
                                  ],
                                  decoration: const InputDecoration(
                                    labelText: 'ICMS (%)',
                                    hintText: '',
                                  ),
                                  maxLength: 12,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  controller: txtControllerPis,
                                  focusNode: focusNodePis,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins-Regular',
                                      fontWeight: FontWeight.w100,
                                      color: Color(0xFF323232)),
                                  onSubmitted: (term) {
                                    focusNodePis.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(focusNodePisPorc);
                                  },
                                  textAlign: TextAlign.start,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    CurrencyPtBrInputFormatter()
                                  ],
                                  decoration: const InputDecoration(
                                    labelText: 'Valor PIS',
                                    hintText: '',
                                  ),
                                  maxLength: 20,
                                ),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: TextField(
                                  controller: txtControllerPisPorc,
                                  focusNode: focusNodePisPorc,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins-Regular',
                                      fontWeight: FontWeight.w100,
                                      color: Color(0xFF323232)),
                                  onSubmitted: (term) {
                                    focusNodePisPorc.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(focusNodeCofins);
                                  },
                                  textAlign: TextAlign.start,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    CurrencyPercentInputFormatter()
                                  ],
                                  decoration: const InputDecoration(
                                    labelText: 'PIS (%)',
                                    hintText: '',
                                  ),
                                  maxLength: 12,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  controller: txtControllerCofins,
                                  textAlign: TextAlign.start,
                                  focusNode: focusNodeCofins,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins-Regular',
                                      fontWeight: FontWeight.w100,
                                      color: Color(0xFF323232)),
                                  onSubmitted: (term) {
                                    focusNodeCofins.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(focusNodeCofinsPorc);
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    CurrencyPtBrInputFormatter()
                                  ],
                                  decoration: const InputDecoration(
                                    labelText: 'Valor COFINS',
                                    hintText: '',
                                  ),
                                  maxLength: 20,
                                ),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: TextField(
                                  controller: txtControllerCofinsPorc,
                                  textAlign: TextAlign.start,
                                  focusNode: focusNodeCofinsPorc,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins-Regular',
                                      fontWeight: FontWeight.w100,
                                      color: Color(0xFF323232)),
                                  onSubmitted: (term) {
                                    focusNodeCofinsPorc.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(focusNodeNetRevenue);
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    CurrencyPercentInputFormatter()
                                  ],
                                  decoration: const InputDecoration(
                                    labelText: 'COFINS (%)',
                                    hintText: '',
                                  ),
                                  maxLength: 12,
                                ),
                              ),
                            ],
                          ),
                          TextField(
                            controller: txtControllerNetRevenue,
                            textAlign: TextAlign.start,
                            focusNode: focusNodeNetRevenue,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins-Regular',
                                fontWeight: FontWeight.w100,
                                color: Color(0xFF323232)),
                            onSubmitted: (term) {
                              focusNodeNetRevenue.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(focusNodeGeneralObservations);
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CurrencyPtBrInputFormatter()
                            ],
                            decoration: const InputDecoration(
                              labelText: 'Receita Liquida',
                              hintText: '',
                            ),
                            maxLength: 20,
                          ),
                          TextField(
                            controller: txtControllerGeneralObservations,
                            textAlign: TextAlign.start,
                            focusNode: focusNodeGeneralObservations,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins-Regular',
                                fontWeight: FontWeight.w100,
                                color: Color(0xFF323232)),
                            onSubmitted: (term) {
                              focusNodeGeneralObservations.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(focusNodeIcmsPorc);
                            },
                            decoration: const InputDecoration(
                              labelText: 'Observações Gerais',
                              hintText: '',
                            ),
                            maxLength: 1500,
                          ),
                        ].toList()),
                    state: currentStep > 1
                        ? StepState.complete
                        : StepState.disabled,
                    isActive: true,
                  ),
                  Step(
                    title: SizedBox(
                      width: MediaQuery.of(context).size.width - 90,
                      child: Text(
                        'dados em serviços',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(fontSize: 15),
                      ),
                    ),
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30.0),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 15.0, 20.0, 15.0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.fromLTRB(
                                    15.0, 2.0, 15.0, 2.0),
                                minimumSize: const Size(200, 45),
                                maximumSize: const Size(200, 45),
                                textStyle: const TextStyle(
                                  color: Color(0xffef7d00),
                                  fontSize: 15,
                                ),
                              ),
                              child: const Text(
                                ' Adicionar ',
                                style: TextStyle(
                                  color: Color(0xffFFFFFF),
                                  fontSize: 13,
                                ),
                              ),
                              onPressed: () async {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute<
                                            InputDadosEmServicosModel>(
                                        fullscreenDialog: true,
                                        builder: (BuildContext context) =>
                                            DadosEmServicosView(
                                                sInputDadosEmServicos:
                                                    null))).then((value) {
                                  if (value != null) {
                                    if (inputSiciFustForm.dadosEmServicos ==
                                        null) {
                                      inputSiciFustForm.dadosEmServicos = [];
                                      inputSiciFustForm.dadosEmServicos!
                                          .add(value);
                                    } else {
                                      inputSiciFustForm.dadosEmServicos!
                                          .add(value);
                                    }
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        Builder(
                          builder: (BuildContext context) {
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: inputSiciFustForm.dadosEmServicos == null ? 0 : inputSiciFustForm.dadosEmServicos!.length,
                              itemBuilder: (context,index)
                                {
                                  return Card(
                                    elevation: 0.9,
                                    child: Container(
                                        alignment: Alignment.topLeft,
                                        height: 475,
                                        constraints: const BoxConstraints(
                                          minWidth: 200,
                                          maxWidth: 600,
                                        ),
                                        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                                        decoration: BoxDecoration(
                                          color: const Color(0xffFFFFFF), //new Color.fromRGBO(255, 0, 0, 0.0),
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                                              child: RichText(
                                                  textAlign: TextAlign.start,
                                                  softWrap: false,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  text: TextSpan(children: [
                                                    const TextSpan(
                                                      text: 'UF' + "\n ",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.normal,
                                                        color: Colors.black,
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: inputSiciFustForm.dadosEmServicos![index].uf,
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.normal,
                                                        color: Colors.black54,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),
                                                  ])),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                                              child: RichText(
                                                  textAlign: TextAlign.start,
                                                  softWrap: false,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  text: TextSpan(children: [
                                                    const TextSpan(
                                                      text: 'Tipo cliente' + '\n ',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.normal,
                                                        color: Colors.black,
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: inputSiciFustForm
                                                          .dadosEmServicos![index].tipoCliente,
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.normal,
                                                        color: Colors.black54,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),
                                                  ])),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                                              child: RichText(
                                                  textAlign: TextAlign.start,
                                                  softWrap: false,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  text: TextSpan(children: [
                                                    const TextSpan(
                                                      text: 'Tipo de Atendimento' + "\n ",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.normal,
                                                        color: Colors.black,
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: inputSiciFustForm
                                                          .dadosEmServicos![index].tipoAtendimento,
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.normal,
                                                        color: Colors.black54,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),
                                                  ])),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                                              child: RichText(
                                                  textAlign: TextAlign.start,
                                                  softWrap: false,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  text: TextSpan(children: [
                                                    const TextSpan(
                                                      text: 'Tipo acesso' "\n ",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.normal,
                                                        color: Colors.black,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: inputSiciFustForm
                                                          .dadosEmServicos![index].tipoAcesso,
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.normal,
                                                        color: Colors.black54,
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                  ])),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                                              child: RichText(
                                                  textAlign: TextAlign.start,
                                                  softWrap: false,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  text: TextSpan(children: [
                                                    const TextSpan(
                                                      text: 'Tecnologia' + "\n ",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.normal,
                                                        color: Colors.black,
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: inputSiciFustForm
                                                          .dadosEmServicos![index].tecnologia,
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.normal,
                                                        color: Colors.black54,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),
                                                  ])),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                                              child: RichText(
                                                  textAlign: TextAlign.start,
                                                  softWrap: false,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  text: TextSpan(children: [
                                                    const TextSpan(
                                                      text: 'Tipo produto' + "\n ",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.normal,
                                                        color: Colors.black,
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: inputSiciFustForm
                                                          .dadosEmServicos![index].tipoProduto,
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.normal,
                                                        color: Colors.black54,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),
                                                  ])),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                                              child: RichText(
                                                  textAlign: TextAlign.start,
                                                  softWrap: false,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  text: TextSpan(children: [
                                                    const TextSpan(
                                                      text: 'Velocidade' "\n ",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.normal,
                                                        color: Colors.black,
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: inputSiciFustForm
                                                          .dadosEmServicos![index].velocidade,
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.normal,
                                                        color: Colors.black54,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),
                                                  ])),
                                            ),
                                            const Divider(),
                                            const SizedBox(height: 10.0),
                                            Align( alignment: Alignment.bottomRight, child: Container(
                                              alignment: Alignment.bottomRight,
                                              constraints: const BoxConstraints(
                                                maxWidth: 300,
                                                minWidth: 300,
                                              ),
                                              height: 40,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 2,
                                                    child:  TextButton.icon(
                                                      style: TextButton.styleFrom(
                                                        minimumSize: const Size(150, 40),
                                                        maximumSize: const Size(150, 40),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(5.0),
                                                        ),
                                                      ),
                                                      icon: const Icon(
                                                        Icons.visibility,
                                                        color: Colors.white,
                                                      ),
                                                      //`Icon` to display
                                                      label: const Text(
                                                        'Visualizar',
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 1,
                                                        softWrap: false,
                                                        style: TextStyle(color: Colors.white),
                                                      ),
                                                      //`Text` to display
                                                      onPressed: () {
                                                        FocusScope.of(context).requestFocus(FocusNode());
                                                        Navigator.push(
                                                            context,
                                                            CupertinoPageRoute<InputDadosEmServicosModel>(
                                                                fullscreenDialog: true,
                                                                builder: (BuildContext context) =>
                                                                    DadosEmServicosView(sInputDadosEmServicos: inputSiciFustForm.dadosEmServicos![index]))).then((value) {
                                                          if (value != null) {
                                                            setState(() {
                                                              inputSiciFustForm.dadosEmServicos!.insert(index, value);
                                                            });
                                                          }
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10.0),
                                                  Expanded(
                                                    flex: 2,
                                                    child: TextButton.icon(
                                                      style: TextButton.styleFrom(
                                                        minimumSize: const Size(150, 40),
                                                        maximumSize: const Size(150, 40),
                                                        backgroundColor: Colors.red,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(5.0),
                                                        ),
                                                      ),
                                                      icon: const Icon(
                                                        Icons.delete_outline,
                                                        color: Colors.white,
                                                      ),
                                                      //`Icon` to display
                                                      label: const Text(
                                                        'Remover',
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 1,
                                                        softWrap: false,
                                                        style: TextStyle(color: Colors.white),
                                                      ),
                                                      //`Text` to display
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          barrierDismissible: false,
                                                          builder: (BuildContext context) {
                                                            return Dialog(
                                                                child: Container(
                                                                  padding: const EdgeInsets.all(25.0),
                                                                  constraints: const BoxConstraints(
                                                                    minWidth: 70,
                                                                    maxWidth: 450,
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    children: [
                                                                      Container(
                                                                        margin: const EdgeInsets.fromLTRB(
                                                                            0.0, 10.0, 0.0, 15.0),
                                                                        height: 50.0,
                                                                        child: Text(
                                                                          'Deseja realmente remover ?',
                                                                          textAlign: TextAlign.start,
                                                                          softWrap: false,
                                                                          maxLines: 2,
                                                                          overflow: TextOverflow.ellipsis,
                                                                          style: Theme.of(GlobalScaffold.instance
                                                                              .navigatorKey.currentContext!)
                                                                              .textTheme
                                                                              .headline4
                                                                              ?.copyWith(
                                                                            fontSize: 15,
                                                                            color: const Color(0xff737373),
                                                                            fontWeight: FontWeight.w100,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        constraints: const BoxConstraints(
                                                                          maxWidth: 400,
                                                                        ),
                                                                        margin: const EdgeInsets.fromLTRB(
                                                                            0.0, 10.0, 0.0, 15.0),
                                                                        child: Row(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                          CrossAxisAlignment.center,
                                                                          mainAxisSize: MainAxisSize.max,
                                                                          children: <Widget>[
                                                                            Expanded(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(
                                                                                    left: 14.0),
                                                                                child: OutlinedButton(
                                                                                  style: TextButton.styleFrom(
                                                                                    backgroundColor:
                                                                                    const Color(0xFFffffff),
                                                                                    side: const BorderSide(
                                                                                      color: Color(
                                                                                          0xffef7d00), //Color of the border
                                                                                    ),
                                                                                    minimumSize:
                                                                                    const Size(130, 43),
                                                                                    maximumSize:
                                                                                    const Size(130, 43),
                                                                                    textStyle: const TextStyle(
                                                                                      color: Color(0xffFFFFFF),
                                                                                      fontSize: 15,
                                                                                    ),
                                                                                  ),
                                                                                  onPressed: () async {
                                                                                    try {
                                                                                      setState(() {
                                                                                        //var sd =  inputSiciFustForm.dadosEmServicos;
                                                                                        inputSiciFustForm.dadosEmServicos!.remove(inputSiciFustForm.dadosEmServicos![index]);
                                                                                        //var sds =  inputSiciFustForm.dadosEmServicos;
                                                                                        //inputSiciFustForm.dadosEmServicos = inputSiciFustForm.dadosEmServicos;
                                                                                      });
                                                                                      Navigator.pop(context);
                                                                                    } catch (error) {
                                                                                      GlobalScaffold.instance
                                                                                          .onToastError(
                                                                                          error.toString());
                                                                                    }
                                                                                  },
                                                                                  child: const Text('  Sim  ',
                                                                                      style: TextStyle(
                                                                                        color: Color(0xffef7d00),
                                                                                      )),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(
                                                                                    left: 14.0),
                                                                                child: OutlinedButton(
                                                                                  style: TextButton.styleFrom(
                                                                                    minimumSize:
                                                                                    const Size(130, 43),
                                                                                    maximumSize:
                                                                                    const Size(130, 43),
                                                                                    textStyle: const TextStyle(
                                                                                      color: Color(0xffFFFFFF),
                                                                                      fontSize: 15,
                                                                                    ),
                                                                                  ),
                                                                                  onPressed: () async {
                                                                                    try {
                                                                                      Navigator.pop(context);
                                                                                    } catch (error) {
                                                                                      GlobalScaffold.instance
                                                                                          .onToastError(
                                                                                          error.toString());
                                                                                    }
                                                                                  },
                                                                                  child: const Text('  Não  ',
                                                                                      style: TextStyle(
                                                                                        color: Color(0xFFffffff),
                                                                                      )),
                                                                                ),
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
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),)
                                          ],
                                        )),
                                  );
                                },
                            );
                          },
                        ),
                        const SizedBox(height: 20.0),
                      ],
                    ),
                    isActive: true,
                  ),
                ],
                type: StepperType.vertical,
                currentStep: currentStep,
                onStepTapped: (step) {
                  setState(() {
                    currentStep = step;
                  });
                },
                elevation: 8,
                onStepContinue: () {
                  setState(() {
                    if (currentStep < spr.length - 1) {
                      currentStep = currentStep + 1;
                    } else {
                      currentStep = 0;
                    }
                  });
                },
                onStepCancel: () {
                  setState(() {
                    if (currentStep > 0) {
                      currentStep = currentStep - 1;
                    } else {
                      currentStep = 0;
                    }
                  });
                },
              ),
              context),
        ),
      ),
    );
  }
}
