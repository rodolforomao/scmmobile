import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/app_scm_engenharia_mobile_bll.dart';
import '../../data/tb_environment_variable.dart';
import '../../help/components.dart';
import '../../help/parameter_result_view.dart';
import '../../models/input/input_sici_fust_form_model.dart';
import '../../models/operation.dart';
import '../../models/output/output_environment_variables_model.dart';
import '../help_views/global_scaffold.dart';
import '../help_views/global_view.dart';
import 'selecionar_municipio_view.dart';
import '../../thema/app_thema.dart';
import '../../help/navigation_service/route_paths.dart' as routes;



//ignore: must_be_immutable
class DadosEmServicosView extends StatefulWidget {
  InputDadosEmServicosModel? sInputDadosEmServicos;
  DadosEmServicosView({super.key, required this.sInputDadosEmServicos});

  @override
  DadosEmServicosState createState() => DadosEmServicosState();
}

class DadosEmServicosState extends State<DadosEmServicosView> with  ParameterView , ParameterResultViewEvent {



  onAdd() async {
    try {
      InputDadosEmServicosModel sInput = InputDadosEmServicosModel();
      if( widget.sInputDadosEmServicos != null)
        {
          sInput.idLancamento = widget.sInputDadosEmServicos!.idLancamento;
        }

      if(ufValue.uf != 'SELECIONE...') {
        sInput.uf = ufValue.uf;
      }
      else
      {
        throw 'Por favor, é necessário preencher o campo UF (Unidade Federativa)';
      }
      if(txtCounty.text.isNotEmpty) {
        sInput.codIbge = valueCodIbge.codIbge;
      }
      else
      {
        throw 'Por favor, é necessário preencher o campo ‘Código IBGE’ para prosseguir. Certifique-se de inserir o Código IBGE corretamente.';
      }

      if(customerTypeValue.descricao != 'SELECIONE...') {
        sInput.tipoCliente = customerTypeValue.descricao;
      }
      else
      {
        throw 'Por favor, é necessário selecionar o ‘Tipo de Cliente’ para prosseguir. Certifique-se de escolher a opção apropriada na lista.';
      }
      if(serviceTypeValue.descricao == 'SELECIONE...') {
        throw 'Por favor, é necessário selecionar o ‘Tipo de Atendimento’ para prosseguir.';
      }
      else
      {
        sInput.tipoAtendimento = serviceTypeValue.descricao;
      }
      if(mediumAccessTypeValue.descricao != 'SELECIONE...') {
        sInput.tipoAcesso = mediumAccessTypeValue.descricao;
      }
      else
      {
        throw 'Por favor, é necessário selecionar o ‘Tipos meio’ para prosseguir. ';
      }

      if(productTypeValue.descricao != 'SELECIONE...') {
        sInput.tipoProduto = productTypeValue.descricao;
      }
      else
      {
        throw 'Por favor, é necessário preencher o campo ‘Tipo de Produto’ para prosseguir. ';
      }
      if(technologyTypeValue.descricao != 'SELECIONE...') {
        sInput.tecnologia = technologyTypeValue.descricao;
      }
      else
      {
        throw 'Por favor, é necessário preencher o campo ‘Nome da Tecnologia’ para prosseguir.';
      }
      if(txtControllerVelocity.text.isNotEmpty) {
        sInput.velocidade = txtControllerVelocity.text;
      }
      else
      {
        throw 'Por favor, é necessário preencher o campo ‘Velocidade’ para prosseguir.';
      }
      if(txtControllerAccesses.text.isNotEmpty) {
        sInput.quantidadeAcesso = txtControllerAccesses.text;
      }
      else
      {
        throw 'Por favor, é necessário preencher o campo ‘Acesso’ para prosseguir.';
      }
      Navigator.pop(context, sInput);
    } catch (error) {
      OnAlert.onAlertError(context, error.toString());
    }
  }

  onInc() async {
    try {
      setState(() => statusView = TypeView.viewLoading);
      Operation respEnvironmentVariable = await AppScmEngenhariaMobileBll.instance.onSelectEnvironmentVariableAll();
      if (respEnvironmentVariable.erro) {
        throw respEnvironmentVariable.message!;
      } else if (respEnvironmentVariable.result == null) {
        Navigator.of(context).pushNamed(
          routes.variaveisDeAmbienteRoute,
        ).then((value) {
          onInc();
        });
      } else {
        setState(() {
          TbEnvironmntVariable inputEnvironmntVariable = respEnvironmentVariable.result as TbEnvironmntVariable;
          resulEnvironmentVariables = OutputEnvironmentVariablesModel.fromJson(jsonDecode(inputEnvironmntVariable.result) as Map<String, dynamic>);
          ufDropdownList = resulEnvironmentVariables.uf;
          ufDropdownList!.add(Uf(
            id: '0',
            uf: 'SELECIONE...',
          ));
          ufValue = ufDropdownList!.last;
          //-------------------------------------------------------------------------------------------------------------------
          customerTypeDropdownList = resulEnvironmentVariables.tipoCliente;
          customerTypeDropdownList!.add(TipoCliente(
            id: '0',
            descricao: 'SELECIONE...',
          ));
          customerTypeValue = customerTypeDropdownList!.last;
          //-------------------------------------------------------------------------------------------------------------------
          serviceTypeDropdownList = resulEnvironmentVariables.tipoAtendimento;
          serviceTypeDropdownList!.add(TipoAtendimento(
            id: '0',
            descricao: 'SELECIONE...',
          ));
          serviceTypeValue  = serviceTypeDropdownList!.last;
          //-------------------------------------------------------------------------------------------------------------------
          mediumAccessTypeDropdownList = resulEnvironmentVariables.tipoMeioAcesso;
          mediumAccessTypeDropdownList!.add(TipoMeioAcesso(
            id: '0',
            descricao: 'SELECIONE...',
          ));
          mediumAccessTypeValue  = mediumAccessTypeDropdownList!.last;
          //-------------------------------------------------------------------------------------------------------------------
          technologyTypeDropdownList = resulEnvironmentVariables.tipoTecnologia;
          technologyTypeDropdownList!.add(TipoTecnologia(
            id:'0',
            descricao:'SELECIONE...',
            idTipoMeioAcesso:'0',
            idTipoProduto:'0',
          ));
          technologyTypeValue   = technologyTypeDropdownList!.last;
          //-------------------------------------------------------------------------------------------------------------------
          productTypeDropdownList = resulEnvironmentVariables.tipoProduto;
          productTypeDropdownList!.add(TipoProduto(
            id: '0',
            descricao: 'SELECIONE...',
          ));
          productTypeValue = productTypeDropdownList!.last;
        });
        if(widget.sInputDadosEmServicos != null)
        {
          ufValue =  ufDropdownList!.firstWhere((i) => i.uf!.toUpperCase() == widget.sInputDadosEmServicos!.uf!.toUpperCase(), orElse: () => ufDropdownList!.last);
          valueCodIbge =  resulEnvironmentVariables.codIbge!.firstWhere((i) => i.codIbge!.toUpperCase() == widget.sInputDadosEmServicos!.codIbge!.toUpperCase(), orElse: () => resulEnvironmentVariables.codIbge!.last);

          customerTypeValue = resulEnvironmentVariables.tipoCliente!.firstWhere((i) => i.descricao?.toUpperCase() == widget.sInputDadosEmServicos!.tipoCliente?.toUpperCase(), orElse: () => resulEnvironmentVariables.tipoCliente!.first);
          serviceTypeValue = resulEnvironmentVariables.tipoAtendimento!.firstWhere((i) => i.descricao?.toUpperCase() == widget.sInputDadosEmServicos!.tipoAtendimento?.toUpperCase(), orElse: () => resulEnvironmentVariables.tipoAtendimento!.first);
          mediumAccessTypeValue = resulEnvironmentVariables.tipoMeioAcesso!.firstWhere((i) => i.descricao?.toUpperCase() == widget.sInputDadosEmServicos!.tipoAcesso?.toUpperCase(), orElse: () => resulEnvironmentVariables.tipoMeioAcesso!.first);
          technologyTypeValue = resulEnvironmentVariables.tipoTecnologia!.firstWhere((i) => i.descricao?.toUpperCase() == widget.sInputDadosEmServicos!.tecnologia?.toUpperCase(), orElse: () => resulEnvironmentVariables.tipoTecnologia!.first);
          productTypeValue = resulEnvironmentVariables.tipoProduto!.firstWhere((i) => i.descricao?.toUpperCase()== widget.sInputDadosEmServicos!.tipoProduto?.toUpperCase(), orElse: () => resulEnvironmentVariables.tipoProduto!.first);
          txtCounty.text = Components.onIsEmpty(valueCodIbge.codIbge!) ;
          hintTextCounty  = Components.onIsEmpty(valueCodIbge.descricao!);
          txtControllerVelocity.text = widget.sInputDadosEmServicos!.velocidade!;
          txtControllerAccesses.text = widget.sInputDadosEmServicos!.quantidadeAcesso!;
        }
        setState(() => statusView = TypeView.viewRenderInformation);
      }
    } catch (error) {
      Navigator.of(context).pushNamed(
        routes.errorInformationRoute,
        arguments: {
          'view': routes.splashScreenRoute,
          'error': error
        },
      ).then((value) {
        Navigator.of(context).pop();
      });
    }
  }

  @override
  void initState() {
    super.initState();
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
          centerTitle: true,
          flexibleSpace: Container(
            decoration: StylesThemas.boxDecorationAppBar,
          ),
          title: const Text(
            'Dados em serviços',
          ),
          toolbarHeight: 50,
          backgroundColor: Colors.transparent,
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
        return GlobalView.viewErrorInformation(maxHeight,erroInformation,context);
      case TypeView.viewRenderInformation:
        return GlobalView.viewRenderSingleChildScrollView(maxHeight,Container( padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 0.0),
            constraints: const BoxConstraints(
              maxWidth: 1000,
            ), child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

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
                        style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w100,
                      color: Color(0xFF323232)),

                      )),
                ).toList(),
                onChanged: (newValue) {
                  setState(() {
                    ufValue = newValue!;
                    valueCodIbge = CodIbge();
                    hintTextCounty = 'O código IBGE..';
                  });
                  txtCounty.text = "";
                },
              ),),

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
                       txtCounty.text = '';
                      setState((){
                        hintTextCounty = 'O código IBGE..';
                      });
                      Navigator.of(context, rootNavigator: false).push(
                        CupertinoPageRoute<CodIbge>(
                          maintainState: false,
                          fullscreenDialog: true,
                          builder: (BuildContext context) =>
                              SelecionarMunicipioView(sMunicipios:codIbges,sUf:ufValue),
                        ),
                      ).then((value) {
                        if(value != null)
                        {
                          setState((){
                            valueCodIbge = value;
                            hintTextCounty = value.descricao!;
                          });
                          txtCounty.text = value.codIbge!;
                        }
                        else
                          {
                            setState((){
                              valueCodIbge = CodIbge();
                              hintTextCounty = 'O código IBGE..';
                            });
                            txtCounty.text = "";
                          }
                      });
                    }
                  } catch (error) {
                    OnAlert.onAlertError(context, error.toString());
                  }},
                 onChanged: (value) {
                   FocusScope.of(context).requestFocus(FocusNode());
                 },
                controller: txtCounty,
                autofocus: false,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                textAlign: TextAlign.start,
                style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w100,
                      color: Color(0xFF323232)),
                decoration:  InputDecoration(
                  labelText: hintTextCounty,
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
                            style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w100,
                      color: Color(0xFF323232)),
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
                      items: serviceTypeDropdownList!.map((v) => DropdownMenuItem<TipoAtendimento>(
                            value: v,
                            child: Text(
                              v.descricao!,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 1,
                              style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w100,
                      color: Color(0xFF323232)),
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
                             style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w100,
                      color: Color(0xFF323232)),)),
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
                              style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w100,
                      color: Color(0xFF323232)),
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
                  border: InputBorder.none,
                  //focusColor: Colors.transparent,
                ),
                value: technologyTypeValue,
                items: technologyTypeDropdownList!.map(
                      (v) => DropdownMenuItem<TipoTecnologia>(
                      value: v,
                      child: Text(
                        v.descricao!,
                        style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins-Regular',
                            fontWeight: FontWeight.w100,
                            color: Color(0xFF323232)),
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
                       style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.w100,
                      color: Color(0xFF323232)),
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
                      textInputAction: TextInputAction.none,
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins-Regular',
                          fontWeight: FontWeight.w100,
                          color: Color(0xFF323232)),
                      onSubmitted: (term) {
                        txtFocusNodeAccesses!.unfocus();
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
                child: const Text(' Adicionar ' , style: TextStyle( color: Colors.white), ),
                onPressed: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  onAdd();
                },
              ),),),
            ],
          ),),context);
      case TypeView.viewThereIsNoInternet:
        // TODO: Handle this case.
    }
  }
}

mixin class ParameterView  {

  TypeView statusView = TypeView.viewLoading;
  OutputEnvironmentVariablesModel resulEnvironmentVariables = OutputEnvironmentVariablesModel();

  //CNPJ:

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

  final txtCounty = TextEditingController();
  String hintTextCounty = 'O código IBGE..';

  final txtControllerVelocity = TextEditingController();
  final txtControllerAccesses = TextEditingController();
  final txtMunicipalityName  = TextEditingController();

  FocusNode? txtFocusNodeVelocity;
  FocusNode? txtFocusNodeAccesses;

}