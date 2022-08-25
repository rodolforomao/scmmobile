import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import "package:flutter/services.dart";
import 'package:realm/realm.dart';
import 'package:scm_engenharia_app/views/sici_views/data_in_services_view.dart';
import '../../data/app_scm_engenharia_mobile_bll.dart';
import '../../data/tb_form_sici_fust.dart';
import '../../data/tb_quantitative_distribution_physical_accesses_service.dart';
import '../../help/components.dart';
import '../../help/formatter/cnpj_input_formatter.dart';
import '../../help/formatter/telefone_input_formatter.dart';
import '../../help/formatter/valor_input_formatter.dart';
import '../../models/input/sici_fust_form_model.dart';
import '../../models/operation.dart';
import '../../models/output/sici_fust_model.dart';
import '../help_views/global_scaffold.dart';
import '../help_views/global_view.dart';


class SiciFustFormView extends StatefulWidget {
  SiciFileModel? siciFileModel;
  SiciFustFormView({ Key? key, required this.siciFileModel}) : super(key: key);

  @override
  SiciFustFormState createState() => SiciFustFormState();
}

abstract class IsSilly {



}

class SiciFustFormState extends State<SiciFustFormView> implements IsSilly {

  final resulFormSiciFust = TbFormSiciFust(ObjectId(),'0','S','0','','','','','','','','','','','','','','','','','',);
  late List<TbQuantitativeDistributionPhysicalAccessesService> quantitativeDistributionPhysicalAccessesService;

  SiciFileModel siciFileModel = SiciFileModel();
  List<String> Uf = [];
  late String UfTxt;

  DateTime selectedDate = DateTime(DateTime.now().year, DateTime.now().month - 1, 1);

  //Período referência
  final txtControllerReferencePeriod =  TextEditingController();
  final focusNodeReferencePeriod = FocusNode();

 // Razão social LTDA - ME.
  final txtControllerSocialReason =  TextEditingController();
  final focusNodeSocialReason = FocusNode();

  //Telefone Fixo:
  final txtControllerLandline =  TextEditingController();
  final focusNodeLandline = FocusNode();

  //CNPJ:
  final txtControllerCnpj =  TextEditingController();
  final  focusNodeCnpj = FocusNode();

  //TELEFONE CELULAR:
  final txtControllerTelefoneMovel =  TextEditingController();
  final focusNodeTelefoneMovel = FocusNode();

 // Receita Bruta
  final  txtControllerGrossRevenue =  TextEditingController();
  final  focusNodeGrossRevenue = FocusNode();
 // Valor Simples
  final txtControllerSimpleValue = TextEditingController();
  final focusNodeSimpleValue = FocusNode();
 // Aliquota Simples %
  final txtControllerSimpleAliquot = TextEditingController();
  final focusNodeSimpleAliquot  = FocusNode();
 // Valor ICMS
  final txtControllerICMSvalue = TextEditingController();
  final focusNodeICMSvalue  = FocusNode();
  //ICMS (%)
  final txtControllerIcmsPorc = TextEditingController();
  final focusNodeIcmsPorc  = FocusNode();
 // Valor PIS
  final txtControllerPis = TextEditingController();
  final focusNodePis  = FocusNode();
  //PIS (%)
  final txtControllerPisPorc = TextEditingController();
  final  focusNodePisPorc  = FocusNode();
  //Valor COFINS
  final txtControllerCofins = TextEditingController();
  final focusNodeCofins  = FocusNode();
  //Valor COFINS (%)
  final txtControllerCofinsPorc = TextEditingController();
  final focusNodeCofinsPorc  = FocusNode();
 // Receita Liquida
  final txtControllerNetRevenue = TextEditingController();
  final focusNodeNetRevenue  = FocusNode();
 // Observações Gerais
  final txtControllerGeneralObservations = TextEditingController();
  final focusNodeGeneralObservations  = FocusNode();


   onSaveLocalDbForm()  async {
    try {
      if (txtControllerCnpj.text.isEmpty) throw ("O campo cnpj é obrigatório");
      resulFormSiciFust.periodoReferencia = txtControllerReferencePeriod.text;
      resulFormSiciFust.isSincronizar = "S";
      resulFormSiciFust.cnpj = txtControllerCnpj.text;
      if (txtControllerSocialReason.text.isEmpty)
        throw ("O campo Razão Social é obrigatório");
      resulFormSiciFust.razaoSocial = txtControllerSocialReason.text;
      if (txtControllerTelefoneMovel.text.isEmpty && txtControllerLandline.text.isEmpty) {
        throw ("Pelo menos um campo 'Telefone' é obrigatório");
      }
      resulFormSiciFust.telefoneMovel = txtControllerTelefoneMovel.text;
      resulFormSiciFust.telefoneFixo = txtControllerLandline.text;
      resulFormSiciFust.receitaBruta = txtControllerGrossRevenue.text;
      resulFormSiciFust.receitaLiquida = txtControllerNetRevenue.text;
      resulFormSiciFust.simples = txtControllerSimpleValue.text;
      resulFormSiciFust.simplesPorc = txtControllerSimpleAliquot.text;
      resulFormSiciFust.icms = txtControllerICMSvalue.text;
      resulFormSiciFust.icmsPorc = txtControllerIcmsPorc.text;
      resulFormSiciFust.pis = txtControllerPis.text;
      resulFormSiciFust.pisPorc = txtControllerPisPorc.text;
      resulFormSiciFust.cofins = txtControllerCofins.text;
      resulFormSiciFust.cofinsPorc = txtControllerCofinsPorc.text;
      resulFormSiciFust.observacoes = txtControllerGeneralObservations.text;
     // if (_FichaSici.distribuicaoFisicosServicoQuantitativo.length == 0) {
     //   throw ("Distribuição do quantitativo de acessos físicos em serviço é obrigatório,favor adicionar.");
     // }
      Operation respFormSiciFust = await AppScmEngenhariaMobileBll.instance.onSaveFormSiciFust(resulFormSiciFust,quantitativeDistributionPhysicalAccessesService);
      if (respFormSiciFust.erro) {
        throw respFormSiciFust.message!;
      } else if (respFormSiciFust.result == null) {
        throw respFormSiciFust.message!;
      } else {

      }

    } catch (error) {
      OnRealizandoOperacao('', false,context);
      OnAlertaInformacaoErro(error.toString(),context);
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
        txtControllerReferencePeriod.text = DateFormat('dd/MM/yyyy').format(DateTime(picked.year, picked.month, 1));
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
      if (widget.siciFileModel != null) {
        siciFileModel = widget.siciFileModel!;
        if (widget.siciFileModel!.periodoReferencia!.isNotEmpty) {
          selectedDate = DateTime.parse(widget.siciFileModel!.periodoReferencia!);
          txtControllerReferencePeriod.text = DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.siciFileModel!.periodoReferencia!));
        }

        // Razão social LTDA - ME.
         txtControllerSocialReason.text = widget.siciFileModel!.razaoSocial!;
        //Telefone Fixo:
         txtControllerLandline.text = widget.siciFileModel!.telefoneFixo!;
        //CNPJ:
         txtControllerCnpj.text = widget.siciFileModel!.razaoSocial!;
        //TELEFONE CELULAR:
         txtControllerTelefoneMovel.text = widget.siciFileModel!.telefoneMovel!;
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
         txtControllerGeneralObservations.text = widget.siciFileModel!.observacoes!;

      } else {
      }
    } catch (error) {
      OnAlertaInformacaoErro(error.toString(),context);
      //Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    txtControllerReferencePeriod.text =  DateFormat('dd/MM/yyyy').format(DateTime(DateTime.now().year, DateTime.now().month - 1));
    Inc();
  }

  int currentStep = 0;
  List<Step> spr = <Step>[];

  @override
  Widget build(BuildContext context) {
    double maxHeight = GlobalView.maxHeightAppBar(context, 55);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 0.0,
          title: const Text(
            'Formulário Sici - Fust',
            textAlign: TextAlign.start,
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
                      fontFamily: 'avenir-lt-std-roman',
                      fontSize: 15.0,
                    ),
                  ),
                )),
          ],
        ),
        body: GlobalView.viewRenderSingleChildScrollView(maxHeight,Stepper(
          controlsBuilder: (BuildContext context, ControlsDetails details)
          {
            return Row(
              children: <Widget>[
                Visibility(
                  visible: currentStep > 0 ? true : false,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xffdc3545),
                      padding: const EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 3.0),
                      minimumSize: const Size(130, 43),
                      maximumSize: const Size(130, 43),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color:  Color(0xffFFFFFF),
                        fontSize: 15,
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
                        'Anterior'
                    ),
                  ),
                ),
                const Padding(
                  padding:  EdgeInsets.all(10),
                ),
                Visibility(
                  visible: currentStep == 2 ? false : true,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xff018a8a),
                      padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
                      minimumSize: const Size(130, 43),
                      maximumSize: const Size(130, 43),
                      textStyle: const TextStyle(
                        color:  Color(0xffFFFFFF),
                        fontSize: 15,
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
                        'Próximo'
                    ),
                  ),
                ),
              ],
            );
          },
          steps: <Step>[
            Step(
              title: SizedBox(
                width: MediaQuery.of(context).size.width - 90,
                child:  Text(
                  'INFORMAÇÕES DA EMPRESA',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 15),
                ),
              ),
              content:  Container(
                constraints: const BoxConstraints(
                  maxWidth: 1000,
                ),
                child: GlobalView.viewResponsiveGridTextField(context,5,600,[
                  TextField(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      onSelectedDate(context);
                    },
                    keyboardType: TextInputType.datetime,
                    controller: txtControllerReferencePeriod,
                    focusNode: focusNodeReferencePeriod,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (term) {
                      focusNodeReferencePeriod.unfocus();
                      FocusScope.of(context).requestFocus(focusNodeSocialReason);
                    },
                    style: const TextStyle(
                        fontSize: 15.0),
                    decoration:  const InputDecoration(
                      labelText: 'Período referência:',
                      hintText: '',
                    ),
                    maxLength: 20,
                  ),
                  TextField(
                    keyboardType: TextInputType.datetime,
                    controller: txtControllerSocialReason,
                    focusNode: focusNodeSocialReason,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (term) {
                      focusNodeSocialReason.unfocus();
                      FocusScope.of(context).requestFocus(focusNodeLandline);
                    },
                    maxLength: 100,
                    style: const TextStyle(
                        fontSize: 15.0),
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
                      FocusScope.of(context).requestFocus(focusNodeCnpj);
                    },
                    inputFormatters: [
                      // obrigatório
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter(),
                    ],
                    maxLength: 100,
                    style: const TextStyle(
                        fontSize: 15.0),
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
                      FilteringTextInputFormatter.digitsOnly,
                      CnpjInputFormatter(),
                    ],
                    autofocus: false,
                    style: const TextStyle(
                        fontSize: 15.0),
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
                      FocusScope.of(context).requestFocus(focusNodeGrossRevenue);
                    },
                    inputFormatters: [
                      // obrigatório
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter(),
                    ],
                    autofocus: false,
                    style: const TextStyle(
                        fontSize: 15.0),
                    decoration: const InputDecoration(
                      labelText: 'TELEFONE CELULAR:',
                      hintText: '',
                    ),
                    maxLength: 20,
                  ),
                ].toList()),
              ),
              state: currentStep > 0 ? StepState.complete : StepState.disabled,
              isActive: true,
            ),
            Step(
              title: SizedBox(
                width: MediaQuery.of(context).size.width - 90,
                child:  Text(
                  'INFORMAÇÕES FINANCEIRAS',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 15),
                ),
              ),
              content: Container(
                constraints: const BoxConstraints(
                  maxWidth: 1000,
                ),
                child:  GlobalView.viewResponsiveGridTextField(context,7,600,[
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: txtControllerGrossRevenue,
                    focusNode: focusNodeGrossRevenue,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (term) {
                      focusNodeGrossRevenue.unfocus();
                      FocusScope.of(context).requestFocus(focusNodeSimpleValue);
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
                          onSubmitted: (term) {
                            focusNodeSimpleValue.unfocus();
                            FocusScope.of(context).requestFocus(focusNodeSimpleAliquot);
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
                          onSubmitted: (term) {
                            focusNodeSimpleAliquot.unfocus();
                            FocusScope.of(context).requestFocus(focusNodeICMSvalue);
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
                          onSubmitted: (term) {
                            focusNodeICMSvalue.unfocus();
                            FocusScope.of(context).requestFocus(focusNodeIcmsPorc);
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
                          onSubmitted: (term) {
                            focusNodeIcmsPorc.unfocus();
                            FocusScope.of(context).requestFocus(focusNodePis);
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
                          onSubmitted: (term) {
                            focusNodePis.unfocus();
                            FocusScope.of(context).requestFocus(focusNodePisPorc);
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
                          onSubmitted: (term) {
                            focusNodePisPorc.unfocus();
                            FocusScope.of(context).requestFocus(focusNodeCofins);
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
                          onSubmitted: (term) {
                            focusNodeCofins.unfocus();
                            FocusScope.of(context).requestFocus(focusNodeCofinsPorc);
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
                          onSubmitted: (term) {
                            focusNodeCofinsPorc.unfocus();
                            FocusScope.of(context).requestFocus(focusNodeNetRevenue);
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
                    onSubmitted: (term) {
                      focusNodeNetRevenue.unfocus();
                      FocusScope.of(context).requestFocus(focusNodeGeneralObservations);
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
                    keyboardType: TextInputType.number,
                    onSubmitted: (term) {
                      focusNodeGeneralObservations.unfocus();
                      FocusScope.of(context).requestFocus(focusNodeIcmsPorc);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Observações Gerais',
                      hintText: '',
                    ),
                    maxLength: 1500,
                  ),
                ].toList()),
              ),
              state: currentStep > 1
                  ? StepState.complete
                  : StepState.disabled,
              isActive: true,
            ),
            Step(
              title: SizedBox(
                width: MediaQuery.of(context).size.width - 90,
                child:  Text(
                  'DADOS EM SERVIÇOS',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 15),
                ),
              ),
              content: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30.0),
                    Center(child: Padding(padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFF3F7EC1),
                        padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 2.0),
                        minimumSize: const Size(200, 47),
                        maximumSize: const Size(200, 47),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color:  Color(0xffFFFFFF),
                          fontSize: 15,
                        ),
                      ),
                      child: const Text(' Adicionar '),
                      onPressed: () async {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        Navigator.push(
                            context,
                            CupertinoPageRoute<TbQuantitativeDistributionPhysicalAccessesService>(
                                fullscreenDialog: true, builder: (BuildContext context) => DataInServicesView(sDadosEmServicos: null))).then((value) {
                          if (value != null) {
                            if (quantitativeDistributionPhysicalAccessesService.isEmpty) {
                              //value.index = 1;
                              quantitativeDistributionPhysicalAccessesService = [];
                            } else {
                              //value.index = quantitativeDistributionPhysicalAccessesService.length + 1;
                            }
                            //quantitativeDistributionPhysicalAccessesService.add(value);
                          }
                        });
                      },
                    ),),),
                    SizedBox(height: 30.0),
                    Builder(
                      builder: (BuildContext context) {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: siciFileModel.dadosEmServicos == null ? 0 : siciFileModel.dadosEmServicos!.length,
                          itemBuilder:
                          dataInServicesCard,
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
          type:  StepperType.vertical,
          currentStep: currentStep,
          onStepTapped: (step) {
            setState(() {
              currentStep = step;
            });
          },
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
        ),context),
    );
  }


  Card dataInServicesCard(BuildContext context, int index) => Card(
    elevation: 0.9,
    child: Container(
        alignment: Alignment.topLeft,
        height: 450,
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 20.0),
        decoration: BoxDecoration(
          color: const Color(0xffFFFFFF), //new Color.fromRGBO(255, 0, 0, 0.0),
          borderRadius: BorderRadius.circular(5.0),
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
                    const TextSpan(
                      text: 'UF' + "\n ",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                    TextSpan(
                      text: siciFileModel.dadosEmServicos![index].uf,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black54,
                        fontSize: 15.0,
                      ),
                    ),
                  ])),
            ),
            const SizedBox(height: 10.0),
            Flexible(
              child: RichText(
                  textAlign: TextAlign.start,
                  softWrap: false,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(children: [
                    const TextSpan(
                      text: 'Tipo cliente' + "\n ",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                    TextSpan(
                      text: siciFileModel.dadosEmServicos![index].tipoCliente,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black54,
                        fontSize: 15.0,
                      ),
                    ),
                  ])),
            ),
            const SizedBox(height: 10.0),
            Flexible(
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
                      text: siciFileModel.dadosEmServicos![index].tipoAtendimento,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black54,
                        fontSize: 15.0,
                      ),
                    ),
                  ])),
            ),
            const SizedBox(height: 10.0),
            Flexible(
              child: RichText(
                  textAlign: TextAlign.start,
                  softWrap: false,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(children: [
                    const TextSpan(
                      text: 'Tipo acesso' + "\n ",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 15.0,
                      ),
                    ),
                    TextSpan(
                      text: siciFileModel.dadosEmServicos![index].tipoAcesso,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black54,
                        fontSize: 16.0,
                      ),
                    ),
                  ])),
            ),
            const SizedBox(height: 10.0),
            Flexible(
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
                      text: siciFileModel.dadosEmServicos![index].tecnologia,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black54,
                        fontSize: 15.0,
                      ),
                    ),
                  ])),
            ),
            const SizedBox(height: 10.0),
            Flexible(
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
                      text: siciFileModel.dadosEmServicos![index].tipoProduto,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black54,
                        fontSize: 15.0,
                      ),
                    ),
                  ])),
            ),
            const SizedBox(height: 10.0),
            Flexible(
              child: RichText(
                  textAlign: TextAlign.start,
                  softWrap: false,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(children: [
                    const TextSpan(
                      text: 'Velocidade' + "\n ",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                    TextSpan(
                      text: siciFileModel.dadosEmServicos![index].velocidade,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black54,
                        fontSize: 15.0,
                      ),
                    ),
                  ])),
            ),
            const SizedBox(height: 10.0),
            const Divider(),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      minimumSize: const Size(150, 40),
                      maximumSize: const Size(150, 40),
                      backgroundColor:  const Color(0xff00A5B2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    icon: Icon(
                      Icons.visibility,
                      color: Colors.white,
                    ),
                    //`Icon` to display
                    label: const Text('Visualizar',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                    ),
                    //`Text` to display
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Navigator.push(
                          context,
                          CupertinoPageRoute<DadosEmServicos>(
                              fullscreenDialog: true, builder: (BuildContext context) => DataInServicesView(sDadosEmServicos: siciFileModel.dadosEmServicos![index]))).then((value) {
                        if (value != null) {
                          if (quantitativeDistributionPhysicalAccessesService.isEmpty) {
                            //value.index = 1;
                            quantitativeDistributionPhysicalAccessesService = [];
                          } else {
                            //value.index = quantitativeDistributionPhysicalAccessesService.length + 1;
                          }
                          //quantitativeDistributionPhysicalAccessesService.add(value);
                        }
                      });
                    },
                  ),
                  const SizedBox(width: 10.0),
                  TextButton.icon(
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
                    label: const Text('Remover',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                    ),
                    //`Text` to display
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Dialog(
                              child: Padding(
                                padding: EdgeInsets.all(25.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0.0, 10.0, 0.0, 15.0),
                                      height: 50.0,
                                      child: const Text(
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
                                      margin: const EdgeInsets.fromLTRB(
                                          0.0, 10.0, 0.0, 15.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[

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
                  const SizedBox(width: 10.0),
                ],
              ),
            ),
          ],
        )),
  );
}
