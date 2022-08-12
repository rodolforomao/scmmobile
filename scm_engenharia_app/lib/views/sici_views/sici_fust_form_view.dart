import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import "package:flutter/services.dart";
import 'package:realm/realm.dart';
import 'package:scm_engenharia_app/views/sici_views/physical_distribution_quantitative_service_view.dart';
import '../../data/app_scm_engenharia_mobile_bll.dart';
import '../../data/tb_form_sici_fust.dart';
import '../../data/tb_quantitative_distribution_physical_accesses_service.dart';
import '../../help/componentes.dart';
import '../../help/formatter/cnpj_input_formatter.dart';
import '../../help/formatter/telefone_input_formatter.dart';
import '../../help/formatter/telefone_sem_ddd_input_formatter.dart';
import '../../models/operation.dart';
import '../../models/quantitative_distribution_physical_accesses_service_model.dart';
import '../../models/sici_file_model.dart';
import '../help_views/global_scaffold.dart';
import '../help_views/global_view.dart';


class SiciFustFormView extends StatefulWidget {
  SiciFileModel? siciFileModel;

  SiciFustFormView({ Key? key, required this.siciFileModel}) : super(key: key);

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
      Uf = await Componentes.OnlistaEstados() as List<String>;
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
        siciFileModel.distribuicaoFisicosServicoQuantitativo = [];
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

  int current_step = 0;
  List<Step> spr = <Step>[];

  @override
  Widget build(BuildContext context) {
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
                    visible: current_step > 0 ? true : false,
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
                      child: const Text(
                        'Anterior'
                      ),
                    ),
                  ),
                   const Padding(
                    padding:  EdgeInsets.all(10),
                  ),
                  Visibility(
                    visible: current_step == 2 ? false : true,
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
                state: current_step > 0 ? StepState.complete : StepState.disabled,
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

                            ],
                            autofocus: false,
                            decoration: InputDecoration(
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

                            ],
                            decoration: InputDecoration(
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

                            ],
                            decoration: InputDecoration(
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

                            ],
                            decoration: InputDecoration(
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
                      inputFormatters: [

                      ],
                      decoration: const InputDecoration(
                        labelText: 'Observações Gerais',
                        hintText: '',
                      ),
                      maxLength: 1500,
                    ),
                  ].toList()),
                ),
                state: current_step > 1
                    ? StepState.complete
                    : StepState.disabled,
                isActive: true,
              ),
              Step(
                title: SizedBox(
                  width: MediaQuery.of(context).size.width - 90,
                  child:  Text(
                    "DISTRIBUIÇÃO DO QUANTITATIVO DE ACESSOS FÍSICOS EM SERVIÇO",
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
                              CupertinoPageRoute<QuantitativeDistributionPhysicalAccessesServiceModel>(
                                  fullscreenDialog: true, builder: (BuildContext context) => PhysicalDistributionQuantitativeServiceView(sDistribuicaoFisicosServicoQuantitativo: null))).then((value) {
                            if (value != null) {
                              if (quantitativeDistributionPhysicalAccessesService.isEmpty) {
                                value.index = 1;
                                quantitativeDistributionPhysicalAccessesService = [];
                              } else {
                                value.index = quantitativeDistributionPhysicalAccessesService.length + 1;
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
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: siciFileModel
                                .distribuicaoFisicosServicoQuantitativo == null ? 0 : siciFileModel.distribuicaoFisicosServicoQuantitativo!.length, itemBuilder: physicalDistributionServiceQuantitativeCard,
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

  Card physicalDistributionServiceQuantitativeCard(BuildContext context, int index) =>
      Card(
        elevation: 0.9,
        child:GlobalView.viewResponsiveGridTextField(context,3,500,[
          Flexible(
            child: RichText(
                textAlign: TextAlign.start,
                softWrap: false,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(children: [
                  TextSpan(
                    text: 'UF' + "\n ",
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 15),

                  ),
                  TextSpan(
                    text: widget.siciFileModel!.distribuicaoFisicosServicoQuantitativo![index].uf,
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 17),
                  ),
                ])),
          ),
          Flexible(
            child: RichText(
                textAlign: TextAlign.start,
                softWrap: false,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Nome município' + "\n ",
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 15),
                  ),
                  TextSpan(
                    text: widget.siciFileModel!.distribuicaoFisicosServicoQuantitativo![index].municipio,
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 17),
                  ),
                ])),
          ),
          Flexible(
            child: RichText(
                textAlign: TextAlign.start,
                softWrap: false,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Nome tecnologia' + "\n ",
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 15),
                  ),
                  TextSpan(
                    text: widget.siciFileModel!.distribuicaoFisicosServicoQuantitativo![index].tecnologia,
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 17),
                  ),
                ])),
          ),
          Flexible(
            child: RichText(
                textAlign: TextAlign.start,
                softWrap: false,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Código IBGE' + "\n ",
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 15),
                  ),
                  TextSpan(
                    text:widget.siciFileModel!.distribuicaoFisicosServicoQuantitativo![index]
                        .cod_ibge,
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 17),
                  ),
                ])),
          ),
          Flexible(
            child: RichText(
                textAlign: TextAlign.start,
                softWrap: false,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(children: [
                  TextSpan(
                    text: 'PF - 0 - 512 Kbps' + "\n ",
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 15),
                  ),
                  TextSpan(
                    text:widget.siciFileModel!.distribuicaoFisicosServicoQuantitativo![index]
                        .pf_0,
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 17),
                  ),
                ])),
          ),
          Flexible(
            child: RichText(
                textAlign: TextAlign.start,
                softWrap: false,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(children: [
                  TextSpan(
                    text: 'PF - 512 - 2 Mbps' + "\n ",
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 15),
                  ),
                  TextSpan(
                    text: widget.siciFileModel!.distribuicaoFisicosServicoQuantitativo![index]
                        .pf_512,
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 17),
                  ),
                ])),
          ),
          Flexible(
            child: RichText(
                textAlign: TextAlign.start,
                softWrap: false,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(children: [
                  TextSpan(
                    text: 'PF - 2 - 12 Mbps' + "\n ",
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 15),
                  ),
                  TextSpan(
                    text:widget.siciFileModel!.distribuicaoFisicosServicoQuantitativo![index]
                        .pf_2,
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 17),
                  ),
                ])),
          ),
          Flexible(
            child: RichText(
                textAlign: TextAlign.start,
                softWrap: false,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(children: [
                  TextSpan(
                    text: 'PF - 12 - 34 Mbps' + "\n ",
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 15),
                  ),
                  TextSpan(
                    text:widget.siciFileModel!.distribuicaoFisicosServicoQuantitativo![index]
                        .pf_12,
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 17),
                  ),
                ])),
          ),
          Flexible(
            child: RichText(
                textAlign: TextAlign.start,
                softWrap: false,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(children: [
                  TextSpan(
                    text: 'PF - Acima de 34 Mbps' + "\n ",
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 15),
                  ),
                  TextSpan(
                    text: widget.siciFileModel!.distribuicaoFisicosServicoQuantitativo![index]
                        .pf_34,
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 17),
                  ),
                ])),
          ),
          Flexible(
            child: RichText(
                textAlign: TextAlign.start,
                softWrap: false,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(children: [
                  TextSpan(
                    text: 'PJ - 0 - 512 Kbps' + "\n ",
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 15),
                  ),
                  TextSpan(
                    text: widget.siciFileModel!.distribuicaoFisicosServicoQuantitativo![index]
                        .pj_0,
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 17),
                  ),
                ])),
          ),
          Flexible(
            child: RichText(
                textAlign: TextAlign.start,
                softWrap: false,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(children: [
                  TextSpan(
                    text: 'PJ - 512 - 2 Mbps' + "\n ",
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 15),
                  ),
                  TextSpan(
                    text: widget.siciFileModel!.distribuicaoFisicosServicoQuantitativo![index]
                        .pj_512,
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 17),
                  ),
                ])),
          ),
          Flexible(
            child: RichText(
                textAlign: TextAlign.start,
                softWrap: false,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(children: [
                  TextSpan(
                    text: 'PJ - 2 - 12 Mbps' + "\n ",
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 15),
                  ),
                  TextSpan(
                    text:widget.siciFileModel!.distribuicaoFisicosServicoQuantitativo![index]
                        .pj_2,
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 17),
                  ),
                ])),
          ),
          Flexible(
            child: RichText(
                textAlign: TextAlign.start,
                softWrap: false,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(children: [
                  TextSpan(
                    text: 'PJ - 12 - 34 Mbps' + "\n ",
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 15),
                  ),
                  TextSpan(
                    text: widget.siciFileModel!.distribuicaoFisicosServicoQuantitativo![index]
                        .pj_12,
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 17),
                  ),
                ])),
          ),
          Flexible(
            child: RichText(
                textAlign: TextAlign.start,
                softWrap: false,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(children: [
                  TextSpan(
                    text: 'PJ - Acima de 34 Mbps' + "\n ",
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 15),
                  ),
                  TextSpan(
                    text:widget.siciFileModel!.distribuicaoFisicosServicoQuantitativo![index].pj_34,
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 17),
                  ),
                ])),
          ),
          const Divider(),
        ].toList()),
      );
  
}
