import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../help/components.dart';
import '../../help/formatter/cnpj_input_formatter.dart';
import '../../models/input/sici_fust_form_model.dart';
import '../../models/output/environment_variables.dart';
import '../../models/util_model/util_dropdown_list.dart';
import '../help_views/global_scaffold.dart';
import '../help_views/global_view.dart';
import 'select_municipality_view.dart';
import '../../thema/app_thema.dart';


class DataInServicesView extends StatefulWidget {

  DadosEmServicos? sDadosEmServicos;
  DataInServicesView({Key? key, required this.sDadosEmServicos}) : super(key: key);

  @override
  DataInServicesState createState() => DataInServicesState();
}

class DataInServicesState extends State<DataInServicesView> {

  TypeView statusView = TypeView.viewLoading;
  EnvironmentVariables resulEnvironmentVariables = EnvironmentVariables();

  //CNPJ:
  final txtControllerCnpj =  TextEditingController();
  final  focusNodeCnpj = FocusNode();

  List<UtilDropdownList> listMonths = <UtilDropdownList>[];
  late UtilDropdownList utilDropdownListMonth;
  List<Uf>? ufDropdownList;
  Uf ufValue = Uf();
  List<TipoCliente>? customerTypeDropdownList;
  TipoCliente customerTypeValue = TipoCliente();
  List<TipoAtendimento>? serviceTypeDropdownList;
  TipoAtendimento serviceTypeValue = TipoAtendimento();
  List<TipoMeioAcesso>? mediumAccessTypeDropdownList;
  TipoMeioAcesso mediumAccessTypeValue = TipoMeioAcesso();
  List<TipoTecnologia>? technologyTypeDropdownList;
  TipoTecnologia technologyTypeValue = TipoTecnologia();
  List<TipoProduto>? productTypeDropdownList;
  TipoProduto productTypeValue = TipoProduto();
  CodIbge valueCodIbge = CodIbge();
  final txtNumberYear = TextEditingController();
  final txtCounty = TextEditingController();

  final txtControllerVelocity = TextEditingController();
  final txtControllerAccesses = TextEditingController();
  final txtMunicipalityName  = TextEditingController();

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
      String response = await rootBundle.loadString('assets/variavel_de_ambiente.json');
      setState(() {
        resulEnvironmentVariables = EnvironmentVariables.fromJson(jsonDecode(response) as Map<String, dynamic>);
        ufDropdownList = resulEnvironmentVariables.uf;
        ufValue.id = '0';
        ufValue.uf = 'SELECIONE...';
        ufDropdownList!.add(ufValue);
        ufValue = ufDropdownList!.last;
       //-------------------------------------------------------------------------------------------------------------------
        customerTypeDropdownList = resulEnvironmentVariables.tipoCliente;
        customerTypeValue.id ='0';
        customerTypeValue.descricao = 'SELECIONE...';
        customerTypeDropdownList!.add(customerTypeValue);
        customerTypeValue = customerTypeDropdownList!.last;
      //-------------------------------------------------------------------------------------------------------------------
        serviceTypeDropdownList = resulEnvironmentVariables.tipoAtendimento;
        serviceTypeValue.id ='0';
        serviceTypeValue.descricao = 'SELECIONE...';
        serviceTypeDropdownList!.add(serviceTypeValue);
        serviceTypeValue  = serviceTypeDropdownList!.last;
       //-------------------------------------------------------------------------------------------------------------------
        mediumAccessTypeDropdownList = resulEnvironmentVariables.tipoMeioAcesso;
        mediumAccessTypeValue.id ='0';
        mediumAccessTypeValue.descricao = 'SELECIONE...';
        mediumAccessTypeDropdownList!.add(mediumAccessTypeValue);
        mediumAccessTypeValue  = mediumAccessTypeDropdownList!.last;
       //-------------------------------------------------------------------------------------------------------------------
        technologyTypeDropdownList = resulEnvironmentVariables.tipoTecnologia;
        technologyTypeValue.id  ='0';
        technologyTypeValue.descricao = 'SELECIONE...';
        technologyTypeValue.idTipoMeioAcesso  ='0';
        technologyTypeValue.idTipoProduto  ='0';
        technologyTypeDropdownList!.add(technologyTypeValue);
        technologyTypeValue   = technologyTypeDropdownList!.last;
       //-------------------------------------------------------------------------------------------------------------------
        productTypeDropdownList = resulEnvironmentVariables.tipoProduto;
        productTypeValue.id ='0';
        productTypeValue.descricao = 'SELECIONE...';
        productTypeDropdownList!.add(productTypeValue);
        productTypeValue   = productTypeDropdownList!.last;
      });
      if(widget.sDadosEmServicos == null)
        {

        }
      else
        {
          ufValue = ufDropdownList!.where((i) => i.uf!.toUpperCase() == widget.sDadosEmServicos!.uf!.toUpperCase()).first;
          valueCodIbge = resulEnvironmentVariables.codIbge!.where((i) => i.codIbge == widget.sDadosEmServicos!.codIbge).first;
          customerTypeValue = resulEnvironmentVariables.tipoCliente!.where((i) => i.descricao == widget.sDadosEmServicos!.tipoCliente).first;
          serviceTypeValue = resulEnvironmentVariables.tipoAtendimento!.where((i) => i.descricao == widget.sDadosEmServicos!.tipoAtendimento).first;
          mediumAccessTypeValue = resulEnvironmentVariables.tipoMeioAcesso!.where((i) => i.descricao == widget.sDadosEmServicos!.tipoAcesso).first;
          technologyTypeValue = resulEnvironmentVariables.tipoTecnologia!.where((i) => i.descricao == widget.sDadosEmServicos!.tecnologia).first;
          productTypeValue = resulEnvironmentVariables.tipoProduto!.where((i) => i.descricao == widget.sDadosEmServicos!.tipoProduto).first;
          txtCounty.text = valueCodIbge.descricao!;
          txtControllerVelocity.text = widget.sDadosEmServicos!.velocidade!;
          txtControllerAccesses.text = widget.sDadosEmServicos!.quantidadeAcesso!;
        }
      setState((){statusView = TypeView.viewRenderInformation;});
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
    double maxHeight = GlobalView.maxHeightAppBar(context, 140);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          elevation: 0.0,
          title: const Text(
            'Dados em serviços',
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
                  labelText: 'Estado',
                  hintText: 'Estado',
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
                    if (ufValue.id == '0') {
                      throw ('UF deve ser selecionado');
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
                  labelText: 'O código IBGE..',
                  hintText: 'O código IBGE..',
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
              Padding(padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),child:DropdownButtonFormField<TipoTecnologia>(
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
              ),),
              Padding(padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),child:   Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    flex:1,
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
                      flex:1,
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
