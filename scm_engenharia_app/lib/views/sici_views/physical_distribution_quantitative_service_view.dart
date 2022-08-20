import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realm/realm.dart';
import '../../data/tb_quantitative_distribution_physical_accesses_service.dart';
import '../../help/components.dart';
import '../../help/formatter/cnpj_input_formatter.dart';
import '../../models/environment_variables.dart';
import '../../models/quantitative_distribution_physical_accesses_service_model.dart';
import '../../models/util_model/util_dropdown_list.dart';
import '../help_views/global_scaffold.dart';
import '../help_views/global_view.dart';
import 'select_municipality_view.dart';
import '../../thema/app_thema.dart';


class PhysicalDistributionQuantitativeServiceView extends StatefulWidget {

  QuantitativeDistributionPhysicalAccessesServiceModel? sDistribuicaoFisicosServicoQuantitativo;
  PhysicalDistributionQuantitativeServiceView({Key? key, required this.sDistribuicaoFisicosServicoQuantitativo}) : super(key: key);

  @override
  PhysicalDistributionQuantitativeServiceState createState() => PhysicalDistributionQuantitativeServiceState();
}

class PhysicalDistributionQuantitativeServiceState extends State<PhysicalDistributionQuantitativeServiceView> {

  TypeView statusView = TypeView.viewLoading;
  final quantitativeDistributionPhysicalAccessesService = TbQuantitativeDistributionPhysicalAccessesService(ObjectId(),'','','','','','','','','','','','','','','','','','','','','');
  EnvironmentVariables resulEnvironmentVariables = EnvironmentVariables();

  //CNPJ:
  final txtControllerCnpj =  TextEditingController();
  final  focusNodeCnpj = FocusNode();

  late UtilDropdownList utilDropdownListMonth;
  List<UtilDropdownList> listMonths = <UtilDropdownList>[];



  TipoTecnologia tbTecnologia = TipoTecnologia();
  Uf ufModel = Uf();
  CodIbge codIbge = CodIbge();


  String id_uf = "0";
  String id_municipio = "0";
  String id_tecnologia = "0";

  final txtControllerPis = TextEditingController();
  final focusNodePis  = FocusNode();

  TextEditingController txtNumberYear = TextEditingController();



  final txtControllerMunicipio = TextEditingController();
  final txtControllerCod_ibge = TextEditingController();
  final txtControllerPf_0 = TextEditingController();
  final txtControllerPf_512 = TextEditingController();
  final txtControllerPf_2 = TextEditingController();
  final txtControllerPf_12 = TextEditingController();
  final txtControllerPf_34 = TextEditingController();
  final txtControllerPj_0 = TextEditingController();
  final txtControllerPj_512 = TextEditingController();
  final txtControllerPj_2 = TextEditingController();
  final txtControllerPj_12 = TextEditingController();
  final txtControllerPj_34 = TextEditingController();

  onAdd() async {
    try {
      if (id_uf == "0") {
        throw ("O estado deve ser selecionado");
      } else if (id_municipio == "0") {
        throw ("O município  deve ser selecionado");
      } else if (id_tecnologia == "0") {
        throw ("O tecnologia  deve ser selecionado");
      } else if ( txtControllerCod_ibge.text.isEmpty) {
        txtControllerCod_ibge.text = '';
      } else if ( txtControllerPf_0.text.isEmpty) {
        txtControllerPf_0.text = '';
      } else if ( txtControllerPf_512.text.isEmpty) {
        txtControllerPf_512.text = '';
      } else if ( txtControllerPf_2.text.isEmpty) {
        txtControllerPf_2.text = '';
      } else if ( txtControllerPf_12.text.isEmpty) {
        txtControllerPf_12.text = '';
      } else if (txtControllerPf_34.text.isEmpty) {
        txtControllerPf_34.text = '';
      } else if ( txtControllerPj_0.text.isEmpty) {
        txtControllerPj_0.text = '';
      } else if ( txtControllerPj_512.text.isEmpty) {
        txtControllerPj_512.text = '';
      } else if ( txtControllerPj_2.text.isEmpty) {
        txtControllerPj_2.text = '';
      } else if (txtControllerPj_12.text.isEmpty) {
        txtControllerPj_12.text = '';
      } else if (txtControllerPj_34.text.isEmpty) {
        txtControllerPj_34.text = "";
      }
      quantitativeDistributionPhysicalAccessesService.id_uf = id_uf;
      quantitativeDistributionPhysicalAccessesService.id_municipio = id_municipio;
      quantitativeDistributionPhysicalAccessesService.id_tecnologia = id_tecnologia;

      quantitativeDistributionPhysicalAccessesService.cod_ibge = txtControllerCod_ibge.text;
      quantitativeDistributionPhysicalAccessesService.pf_0 =txtControllerPf_0.text;
      quantitativeDistributionPhysicalAccessesService.pf_512 = txtControllerPf_512.text;
      quantitativeDistributionPhysicalAccessesService.pf_2 = txtControllerPf_2.text;
      quantitativeDistributionPhysicalAccessesService.pf_12 = txtControllerPf_12.text;
      quantitativeDistributionPhysicalAccessesService.pf_34 = txtControllerPf_34.text;
      quantitativeDistributionPhysicalAccessesService.pj_0 = txtControllerPj_0.text;
      quantitativeDistributionPhysicalAccessesService.pj_512 = txtControllerPj_512.text;
      quantitativeDistributionPhysicalAccessesService.pj_2 = txtControllerPj_2.text;
      quantitativeDistributionPhysicalAccessesService.pj_12 = txtControllerPj_12.text;
      quantitativeDistributionPhysicalAccessesService.pj_34 = txtControllerPj_34.text;
      Navigator.pop(context, quantitativeDistributionPhysicalAccessesService);
    } catch (error) {
      OnAlertaInformacaoErro(error.toString(),context);
    }
  }

  onInc() async {
    try {
      setState((){statusView = TypeView.viewLoading;});
      String response = await rootBundle.loadString('assets/variavel_de_ambiente.json');
      setState(() {
        resulEnvironmentVariables = EnvironmentVariables.fromJson(jsonDecode(response) as Map<String, dynamic>);
        ufModel = resulEnvironmentVariables.uf!.first;
        tbTecnologia = resulEnvironmentVariables.tipoTecnologia!.first;
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 0.0,
        title: const Text(
          'Formulário Sici - Fust',
          textAlign: TextAlign.start,
        ),
      ),
      body: viewType(MediaQuery.of(context).size.height),
    );
  }


  viewType(double maxHeight) {
    switch (statusView) {
      case TypeView.viewLoading:
        return GlobalView.viewPerformingSearch(maxHeight,context);
      case TypeView.viewErrorInformation:
        return GlobalView.viewErrorInformation(maxHeight,GlobalScaffold.ErroInformacao,context);
      case TypeView.viewRenderInformation:
        return  SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: Column(
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
              Container(
                height: 58.0,
                margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                child:  DropdownButtonFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 16.0),
                    labelText: 'UF',
                    hintText: '',
                  ),
                  elevation: 16,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'avenir-lt-std-medium',
                    color: Color(0xFF000000),
                  ),
                  iconEnabledColor: Colors.white,
                  value: ufModel,
                  isExpanded: true,
                  iconSize: 35,
                  items: resulEnvironmentVariables.uf!.map((Uf value) {
                    return DropdownMenuItem<Uf>(
                      onTap: () {
                        setState(() {
                          ufModel = value;
                          id_uf = value.id!;
                        });
                      },
                      value: value,
                      child: Text(
                        value.uf!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 19.0,
                            color: Color(0xFF000000),
                            fontFamily:
                            "avenir-next-rounded-pro-regular"),
                      ),
                    );
                  }).toList(),
                  onChanged: (Uf? newValue) async {
                    try {

                    } catch (error) {

                    }
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
                 if (codIbge.id == '0') {
                   throw ('A uf deve ser selecionado');
                 } else
                  {
                    final codIbges = resulEnvironmentVariables.codIbge!.where((i) => i.idUf == ufModel.id).toList();
                    codIbge = CodIbge();
                    Navigator.of(context, rootNavigator: false).push(
                      CupertinoPageRoute<CodIbge>(
                        maintainState: false,
                        fullscreenDialog: true,
                        builder: (BuildContext context) =>
                            SelectMunicipalityView(sMunicipios:codIbges,sUf:ufModel),
                      ),
                    ).then((value) {
                      if(value != null)
                      {
                        setState((){codIbge = value;});
                        txtControllerMunicipio.text = value.descricao!;
                      }
                    });
                  }
                  } catch (error) {
                    OnAlertaInformacaoErro(error.toString(),context);
                  }},
                controller: txtControllerMunicipio,
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
                        labelText: 'Tipo cliente',
                        hintText: 'Tipo cliente',
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
                        labelText: 'Tipo de Atendimento',
                        hintText: 'Tipo de Atendimento',
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
              Padding(padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),child:  Row(
                children: [
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
                        labelText: 'Tipos meio',
                        hintText: 'Tipos meio',
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
                        labelText: 'Tipo produto',
                        hintText: 'Tipo produto',
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
              Padding(padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),child:   Expanded(
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
                    labelText: 'Nome tecnologia',
                    hintText: 'Nome tecnologia',
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
              ),),
              Padding(padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),child:   Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: txtControllerPj_12,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        labelText: 'VELOCIDADE',
                        hintText: 'VELOCIDADE',
                      ),
                      keyboardType: TextInputType.text,
                      maxLength: 6,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: TextField(
                      controller: txtControllerPj_34,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        labelText: 'ACESSOS',
                        hintText: 'ACESSOS',
                      ),
                      keyboardType: TextInputType.text,
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
          ),
        );
    }
  }
}
