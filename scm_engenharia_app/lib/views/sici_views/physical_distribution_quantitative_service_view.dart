import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realm/realm.dart';
import '../../data/tb_quantitative_distribution_physical_accesses_service.dart';
import '../../help/components.dart';
import '../../help/formatter/cnpj_input_formatter.dart';
import '../../models/environment_variables.dart';
import '../../models/util_model/util_dropdown_list.dart';
import '../help_views/global_scaffold.dart';
import '../help_views/global_view.dart';
import 'select_municipality_view.dart';
import '../../thema/app_thema.dart';


class PhysicalDistributionQuantitativeServiceView extends StatefulWidget {

  TbQuantitativeDistributionPhysicalAccessesService? sDistribuicaoFisicosServicoQuantitativo;
  PhysicalDistributionQuantitativeServiceView({Key? key, required this.sDistribuicaoFisicosServicoQuantitativo}) : super(key: key);

  @override
  PhysicalDistributionQuantitativeServiceState createState() => PhysicalDistributionQuantitativeServiceState();
}

class PhysicalDistributionQuantitativeServiceState extends State<PhysicalDistributionQuantitativeServiceView> {

  TypeView statusView = TypeView.viewLoading;
  late var quantitativeDistributionPhysicalAccessesService = TbQuantitativeDistributionPhysicalAccessesService(ObjectId(),'','','','','','','','','','','','','','','','','','','','','','');
  EnvironmentVariables resulEnvironmentVariables = EnvironmentVariables();

  //CNPJ:
  final txtControllerCnpj =  TextEditingController();
  final  focusNodeCnpj = FocusNode();

  List<UtilDropdownList> listMonths = <UtilDropdownList>[];
  late UtilDropdownList utilDropdownListMonth;
  List<Uf>? ufDropdownList;
  late Uf ufValue;
  List<TipoCliente>? customerTypeDropdownList;
  late TipoCliente customerTypeValue;
  List<TipoAtendimento>? serviceTypeDropdownList;
  late TipoAtendimento serviceTypeValue;
  List<TipoMeioAcesso>? mediumAccessTypeDropdownList;
  late TipoMeioAcesso  mediumAccessTypeValue;
  List<TipoTecnologia>? technologyTypeDropdownList;
  late TipoTecnologia technologyTypeValue;
  List<TipoProduto>? productTypeDropdownList;
  late TipoProduto productTypeValue;
  late CodIbge valueCodIbge;

  final txtNumberYear = TextEditingController();
  final txtCounty = TextEditingController();
  final txtControllerVelocity = TextEditingController();
  final txtControllerAccesses = TextEditingController();

  FocusNode? txtFocusNodeVelocity;
  FocusNode? txtFocusNodeAccesses;

  onAdd() async {
    try {

    } catch (error) {
      OnAlertaInformacaoErro(error.toString(),context);
    }
  }

  onInc() async {
    try {
      setState((){statusView = TypeView.viewLoading;});
      if(widget.sDistribuicaoFisicosServicoQuantitativo == null)
        {
          quantitativeDistributionPhysicalAccessesService = TbQuantitativeDistributionPhysicalAccessesService(ObjectId(),'','','','','','','','','','','','','','','','','','','','','','');
        }
      else
        {
          quantitativeDistributionPhysicalAccessesService = widget.sDistribuicaoFisicosServicoQuantitativo!;
        }

      String response = await rootBundle.loadString('assets/variavel_de_ambiente.json');
      setState(() {
        resulEnvironmentVariables = EnvironmentVariables.fromJson(jsonDecode(response) as Map<String, dynamic>);
         ufDropdownList = resulEnvironmentVariables.uf;
         ufValue = ufDropdownList!.first;

        customerTypeDropdownList = resulEnvironmentVariables.tipoCliente;
        customerTypeValue = customerTypeDropdownList!.first;

        serviceTypeDropdownList = resulEnvironmentVariables.tipoAtendimento;
        serviceTypeValue  = serviceTypeDropdownList!.first;

        mediumAccessTypeDropdownList = resulEnvironmentVariables.tipoMeioAcesso;
        mediumAccessTypeValue  = mediumAccessTypeDropdownList!.first;

        technologyTypeDropdownList = resulEnvironmentVariables.tipoTecnologia;
        technologyTypeValue   = technologyTypeDropdownList!.first;

        productTypeDropdownList = resulEnvironmentVariables.tipoProduto;
        productTypeValue   = productTypeDropdownList!.first;

        statusView = TypeView.viewRenderInformation;
      });

    } catch (error) {
      OnAlertaInformacaoErro(error.toString(),context);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      listMonths = <UtilDropdownList>[];
      listMonths = await Components.onMonths();
      utilDropdownListMonth = listMonths.first;

    });
    onInc();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = GlobalView.maxHeightAppBar(context, 55);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          elevation: 0.0,
          title: const Text(
            'Formulário Sici - Fust',
            textAlign: TextAlign.start,
          ),
        ),
      ),
      body: viewType(maxHeight),
    );
  }

  viewType(double maxHeight) {
    switch (statusView) {
      case TypeView.viewLoading:
        return GlobalView.viewPerformingSearch(maxHeight,context);
      case TypeView.viewErrorInformation:
        return GlobalView.viewErrorInformation(maxHeight,GlobalScaffold.ErroInformacao,context);
      case TypeView.viewRenderInformation:
        return GlobalView.viewRenderSingleChildScrollView(maxHeight,Container( padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 0.0),
            constraints: const BoxConstraints(
              maxWidth: 1000,
            ), child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),child: TextField(
                keyboardType: TextInputType.number,
                controller: txtControllerCnpj,
                focusNode: focusNodeCnpj,
                textInputAction: TextInputAction.next,
                onSubmitted: (term) {
                  focusNodeCnpj.unfocus();
                  // FocusScope.of(context).requestFocus(focusNodeTelefoneMovel);
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
              ),),
              Padding(padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),child:   DropdownButtonFormField<Uf>(
                elevation: 7,
                dropdownColor: AppThema.themeNotifierState.value.mode == ThemeMode.dark ? const Color(0xff000000) : const Color(0xffFFFFFF),
                isExpanded: true,
                isDense: true,
                icon: const Icon(
                  Icons.expand_more,
                  size: 23,
                  color: Color(0xFFb8b8b8),
                ),
                decoration:  const InputDecoration(
                  filled: true,
                  labelText: 'Mês',
                  hintText: 'Mês',
                  //contentPadding: const EdgeInsets.fromLTRB(10.0, 18.0, 18.0, 0.0),
                  border: InputBorder.none,
                  //focusColor: Colors.transparent,
                ),
                value: ufValue,
                items: ufDropdownList!.map(
                      (v) => DropdownMenuItem<Uf>(
                      value: v,
                      child: Text(
                        v.uf!,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 1,
                      )),
                ).toList(),
                onChanged: (newValue) {
                  setState(() {
                    ufValue = newValue!;
                  });
                },
              ),),
              Padding(padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),child:  Row(
                children: [
                  Expanded(
                    child: TextField(
                      autofocus: false,
                      keyboardType: TextInputType.number,
                      controller: txtNumberYear,
                      textInputAction: TextInputAction.go,
                      inputFormatters: [
                        // obrigatório
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                      onSubmitted: (value) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      decoration: const InputDecoration(
                        hintText: 'Digite Ano',
                        labelText: 'Ano',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child:  DropdownButtonFormField<UtilDropdownList>(
                      elevation: 7,
                      dropdownColor: AppThema.themeNotifierState.value.mode == ThemeMode.dark ? const Color(0xff000000) : const Color(0xffFFFFFF),
                      isExpanded: true,
                      isDense: true,
                      icon: const Icon(
                        Icons.expand_more,
                        size: 23,
                        color: Color(0xFFb8b8b8),
                      ),
                      decoration:  const InputDecoration(
                        filled: true,
                        labelText: 'Mês',
                        hintText: 'Mês',
                        //contentPadding: const EdgeInsets.fromLTRB(10.0, 18.0, 18.0, 0.0),
                        border: InputBorder.none,
                        //focusColor: Colors.transparent,
                      ),
                      value: utilDropdownListMonth,
                      items: listMonths.map(
                            (v) => DropdownMenuItem<UtilDropdownList>(
                            value: v,
                            child: Text(
                              v.txt!,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 1,
                            )),
                      ).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          utilDropdownListMonth = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              )),
              Padding( padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),child:TextField(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  try {
                    if (valueCodIbge.id == '0') {
                      throw ('A uf deve ser selecionado');
                    } else
                    {
                      final codIbges = resulEnvironmentVariables.codIbge!.where((i) => i.idUf == ufValue.id).toList();
                      valueCodIbge = CodIbge();
                      Navigator.of(context, rootNavigator: false).push(
                        CupertinoPageRoute<CodIbge>(
                          maintainState: false,
                          fullscreenDialog: true,
                          builder: (BuildContext context) =>
                              SelectMunicipalityView(sMunicipios:codIbges,sUf:ufValue),
                        ),
                      ).then((value) {
                        if(value != null)
                        {
                          setState((){valueCodIbge = value;});
                          txtCounty.text = value.descricao!;
                        }
                      });
                    }
                  } catch (error) {
                    OnAlertaInformacaoErro(error.toString(),context);
                  }},
                controller: txtCounty,
                autofocus: false,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                textAlign: TextAlign.start,
                decoration: const InputDecoration(
                  labelText: 'Selecione ..',
                  hintText: 'Selecione ..',
                ),
              ),),
              Padding(padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),child:  Row(
                children: [
                  Expanded(
                    child:  DropdownButtonFormField<TipoCliente>(
                      elevation: 7,
                      dropdownColor: AppThema.themeNotifierState.value.mode == ThemeMode.dark ? const Color(0xff000000) : const Color(0xffFFFFFF),
                      isExpanded: true,
                      isDense: true,
                      icon: const Icon(
                        Icons.expand_more,
                        size: 23,
                        color: Color(0xFFb8b8b8),
                      ),
                      decoration:  const InputDecoration(
                        filled: true,
                        labelText: 'Tipo cliente',
                        hintText: 'Tipo cliente',
                        //contentPadding: const EdgeInsets.fromLTRB(10.0, 18.0, 18.0, 0.0),
                        border: InputBorder.none,
                        //focusColor: Colors.transparent,
                      ),
                      value: customerTypeValue == null ? customerTypeValue : customerTypeDropdownList!.where( (i) => i.id == customerTypeValue.id).first,
                      items: customerTypeDropdownList!.map((v) => DropdownMenuItem<TipoCliente>(
                          value: v,
                          child: Text(
                            v.descricao!,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 1,
                          )),
                      ).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          customerTypeValue = newValue!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child:  DropdownButtonFormField<TipoAtendimento>(
                      elevation: 7,
                      dropdownColor: AppThema.themeNotifierState.value.mode == ThemeMode.dark ? const Color(0xff000000) : const Color(0xffFFFFFF),
                      isExpanded: true,
                      isDense: true,
                      icon: const Icon(
                        Icons.expand_more,
                        size: 23,
                        color: Color(0xFFb8b8b8),
                      ),
                      decoration:  const InputDecoration(
                        filled: true,
                        labelText: 'Tipo de Atendimento',
                        hintText: 'Tipo de Atendimento',
                        //contentPadding: const EdgeInsets.fromLTRB(10.0, 18.0, 18.0, 0.0),
                        border: InputBorder.none,
                        //focusColor: Colors.transparent,
                      ),
                      value: serviceTypeValue,
                      items: serviceTypeDropdownList!.map(
                            (v) => DropdownMenuItem<TipoAtendimento>(
                            value: v,
                            child: Text(
                              v.descricao!,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 1,
                            )),
                      ).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          serviceTypeValue = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              )),
              Padding(padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),child:  Row(
                children: [
                  Expanded(
                    child:  DropdownButtonFormField<TipoMeioAcesso>(
                      elevation: 7,
                      dropdownColor: AppThema.themeNotifierState.value.mode == ThemeMode.dark ? const Color(0xff000000) : const Color(0xffFFFFFF),
                      isExpanded: true,
                      isDense: true,
                      icon: const Icon(
                        Icons.expand_more,
                        size: 23,
                        color: Color(0xFFb8b8b8),
                      ),
                      decoration:  const InputDecoration(
                        filled: true,
                        labelText: 'Tipos meio',
                        hintText: 'Tipos meio',
                        //contentPadding: const EdgeInsets.fromLTRB(10.0, 18.0, 18.0, 0.0),
                        border: InputBorder.none,
                        //focusColor: Colors.transparent,
                      ),
                      value: mediumAccessTypeValue,
                      items: mediumAccessTypeDropdownList!.map(
                            (v) => DropdownMenuItem<TipoMeioAcesso>(
                            value: v,
                            child: Text(
                              v.descricao!,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 1,
                            )),
                      ).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          mediumAccessTypeValue = newValue!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child:  DropdownButtonFormField<TipoProduto>(
                      elevation: 7,
                      dropdownColor: AppThema.themeNotifierState.value.mode == ThemeMode.dark ? const Color(0xff000000) : const Color(0xffFFFFFF),
                      isExpanded: true,
                      isDense: true,
                      icon: const Icon(
                        Icons.expand_more,
                        size: 23,
                        color: Color(0xFFb8b8b8),
                      ),
                      decoration:  const InputDecoration(
                        filled: true,
                        labelText: 'Tipo produto',
                        hintText: 'Tipo produto',
                        //contentPadding: const EdgeInsets.fromLTRB(10.0, 18.0, 18.0, 0.0),
                        border: InputBorder.none,
                        //focusColor: Colors.transparent,
                      ),
                      value: productTypeValue,
                      items: productTypeDropdownList!.map(
                            (v) => DropdownMenuItem<TipoProduto>(
                            value: v,
                            child: Text(
                              v.descricao!,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 1,
                            )),
                      ).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          productTypeValue = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              )),
              Padding(padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),child:   Expanded(
                child:  DropdownButtonFormField<TipoTecnologia>(
                  elevation: 7,
                  dropdownColor: AppThema.themeNotifierState.value.mode == ThemeMode.dark ? const Color(0xff000000) : const Color(0xffFFFFFF),
                  isExpanded: true,
                  isDense: true,
                  icon: const Icon(
                    Icons.expand_more,
                    size: 23,
                    color: Color(0xFFb8b8b8),
                  ),
                  decoration:  const InputDecoration(
                    filled: true,
                    labelText: 'Nome tecnologia',
                    hintText: 'Nome tecnologia',
                    //contentPadding: const EdgeInsets.fromLTRB(10.0, 18.0, 18.0, 0.0),
                    border: InputBorder.none,
                    //focusColor: Colors.transparent,
                  ),
                  value: technologyTypeValue,
                  items: technologyTypeDropdownList!.map(
                        (v) => DropdownMenuItem<TipoTecnologia>(
                        value: v,
                        child: Text(
                          v.descricao!,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 1,
                        )),
                  ).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      technologyTypeValue = newValue!;
                    });
                  },
                ),
              ),),
              Padding(padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),child:   Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      autofocus: false,
                      keyboardType: TextInputType.number,
                      controller: txtControllerVelocity,
                      textAlign: TextAlign.start,
                      focusNode: txtFocusNodeVelocity,
                      onSubmitted: (term) {
                        txtFocusNodeVelocity!.unfocus();
                        FocusScope.of(context).requestFocus(txtFocusNodeAccesses);
                      },
                      decoration: const InputDecoration(
                        labelText: 'VELOCIDADE',
                        hintText: 'VELOCIDADE',
                      ),
                      maxLength: 6,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: TextField(
                      controller: txtControllerAccesses,
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.number,
                      focusNode: txtFocusNodeAccesses,
                      onSubmitted: (term) {
                        txtFocusNodeAccesses!.unfocus();
                        onAdd();
                      },
                      decoration: const InputDecoration(
                        labelText: 'ACESSOS',
                        hintText: 'ACESSOS',
                      ),
                      maxLength: 6,
                    ),
                  ),
                ],
              ),),
              Center(child: Padding(padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),child: TextButton(
                style: TextButton.styleFrom(
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
                  FocusScope.of(context).requestFocus(FocusNode());
                  onAdd();
                },
              ),),),
            ],
          ),),context);
    }
  }
}
