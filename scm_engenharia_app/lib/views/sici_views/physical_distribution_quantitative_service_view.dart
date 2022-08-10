import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

import '../../data/app_scm_engenharia_mobile_bll.dart';
import '../../data/tb_quantitative_distribution_physical_accesses_service.dart';
import '../../data/tb_uf.dart';
import '../../data/tb_uf_municipality.dart';
import '../../models/operation.dart';
import '../../models/quantitative_distribution_physical_accesses_service_model.dart';
import '../../models/technology_model.dart';
import '../../models/uf_model.dart';
import '../../models/uf_municipality_model.dart';
import '../help_views/global_scaffold.dart';
import '../settings_views/environment_variable_view.dart';


class PhysicalDistributionQuantitativeServiceView extends StatefulWidget {

  QuantitativeDistributionPhysicalAccessesServiceModel? sDistribuicaoFisicosServicoQuantitativo;
  PhysicalDistributionQuantitativeServiceView({Key? key, required this.sDistribuicaoFisicosServicoQuantitativo}) : super(key: key);

  @override
  PhysicalDistributionQuantitativeServiceState createState() => PhysicalDistributionQuantitativeServiceState();
}

class PhysicalDistributionQuantitativeServiceState extends State<PhysicalDistributionQuantitativeServiceView> {

  final quantitativeDistributionPhysicalAccessesService = TbQuantitativeDistributionPhysicalAccessesService(ObjectId(),'','','','','','','','','','','','','','','','','','','','','');

  late List<TechnologyModel> ListTecnologiadb = [];
  late  List<UfModel> ListUfdb = [];
  late List<UfMunicipalityModel> ListUfMunicipiodb = [];

  TechnologyModel tbTecnologia = new TechnologyModel();
  UfModel ufModel = UfModel();
  UfMunicipalityModel tbUfMunicipio = UfMunicipalityModel();


  String id_uf = "0";
  String id_municipio = "0";
  String id_tecnologia = "0";

  final txtControllerPis = TextEditingController();
  final focusNodePis  = FocusNode();


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
      Operation thereisAnEnvironmentVariable = await AppScmEngenhariaMobileBll.instance.onThereisAnEnvironmentVariable();
      if (thereisAnEnvironmentVariable.erro) {
        throw (thereisAnEnvironmentVariable.message!);
      } else if (thereisAnEnvironmentVariable.result == true) {
        Navigator.push(
            context,
            CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (BuildContext context) =>
                new EnvironmentVariableView())).then((value) {
          onInc();
        });
      } else {

        ufModel.idUfApp = 0;
        ufModel.id = '0';
        ufModel.uf = 'Selecione...';

        tbTecnologia.idTecnologiaApp = 0;
        tbTecnologia.id = '0';
        tbTecnologia.tecnologia = 'Selecione...';

        ListTecnologiadb.add(tbTecnologia);
        ListUfdb.add(ufModel);
        ListUfMunicipiodb.add(tbUfMunicipio);

        Operation uf = await AppScmEngenhariaMobileBll.instance.onSelectUFAll();
        if (uf.erro) {
          throw (uf.message!);
        } else if (uf.result == null) {
          throw (uf.message!);
        } else {
          for (var prop in uf.resultList as List<TbUf>) {
            setState(() {
              final ufModel = UfModel();
              ufModel.idUfApp = prop.idUfApp as int?;
              ufModel.id = prop.id;
              ufModel.uf = prop.uf;
              ListUfdb.add(ufModel);
            });
          }
        }
        Operation technology = await AppScmEngenhariaMobileBll.instance.onSelectTechnologyAll();
        if (technology.erro) {
          throw (technology.message!);
        } else if (technology.result == null) {
          throw (technology.message!);
        } else {
          for (var prop in technology.result as List<TbUfMunicipality>) {
            final technologyModel = TechnologyModel();
            technologyModel.idTecnologiaApp = prop.idMunicipalityApp as int?;
            technologyModel.id = prop.id;
            technologyModel.tecnologia = prop.municipality;
            setState(() {
              ListTecnologiadb.add(technologyModel);
            });
            if (prop.id == "8") {
              tbTecnologia.idTecnologiaApp = prop.idMunicipalityApp as int?;
              tbTecnologia.id = prop.id;
             // tbTecnologia.tecnologia = prop.;_DistribuicaoFisicosServicoQuantitativo.id_tecnologia =  prop.id;
              id_tecnologia = prop.id;
              //_DistribuicaoFisicosServicoQuantitativo .tecnologia = prop.tecnologia;
            }
          }
        }
        if (widget.sDistribuicaoFisicosServicoQuantitativo == null) {
        } else {
         // _DistribuicaoFisicosServicoQuantitativo = widget.sDistribuicaoFisicosServicoQuantitativo;
          UfModel resUf = ListUfdb.where((i) => i.id == widget.sDistribuicaoFisicosServicoQuantitativo?.id_uf).first;
          ufModel.idUfApp = resUf.idUfApp;
          ufModel.id = resUf.id;
          ufModel.uf = resUf.uf;
          id_uf = resUf.id!;
          Operation municipalityModel = await AppScmEngenhariaMobileBll.instance.onSelectUfMunicipalityById(ufModel.id.toString());
          if (municipalityModel.erro) {
            throw (municipalityModel.message!);
          } else if (municipalityModel.result == null) {
            GlobalScaffold.instance.onToastInformacaoErro("Para o estado ${ ufModel.uf} não a município cadastrado");
          } else {
            for (var prop in municipalityModel.result as List<UfMunicipalityModel>) {
              setState(() {
                ListUfMunicipiodb.add(prop);
              });
            }
            UfMunicipalityModel resMunicipio = ListUfMunicipiodb.where((i) =>
            i.id == widget.sDistribuicaoFisicosServicoQuantitativo!.id_municipio).first;
            tbUfMunicipio.idMunicipioApp = resMunicipio.idMunicipioApp;
            tbUfMunicipio.ufId = resMunicipio.ufId;
            tbUfMunicipio.uf = resMunicipio.uf;
            tbUfMunicipio.id = resMunicipio.id;
            tbUfMunicipio.municipio = resMunicipio.municipio;
            id_municipio = resMunicipio.id!;
          }

          TechnologyModel resTecnologia = ListTecnologiadb.where((i) => i.id == widget.sDistribuicaoFisicosServicoQuantitativo!.id_tecnologia).first;
          tbTecnologia.idTecnologiaApp = resTecnologia.idTecnologiaApp;
          tbTecnologia.id = resTecnologia.id;
          tbTecnologia.tecnologia = resTecnologia.tecnologia;
          id_tecnologia = resTecnologia.id!;

          txtControllerMunicipio.text = tbUfMunicipio.municipio!;
          txtControllerCod_ibge.text = widget.sDistribuicaoFisicosServicoQuantitativo!.cod_ibge!;
          txtControllerPf_0.text = widget.sDistribuicaoFisicosServicoQuantitativo!.pf_0!;
          txtControllerPf_512.text = widget.sDistribuicaoFisicosServicoQuantitativo!.pf_512!;
          txtControllerPf_2.text = widget.sDistribuicaoFisicosServicoQuantitativo!.pf_2!;
          txtControllerPf_12.text = widget.sDistribuicaoFisicosServicoQuantitativo!.pf_12!;
          txtControllerPf_34.text = widget.sDistribuicaoFisicosServicoQuantitativo!.pf_34!;
          txtControllerPj_0.text = widget.sDistribuicaoFisicosServicoQuantitativo!.pj_0!;
          txtControllerPj_512.text = widget.sDistribuicaoFisicosServicoQuantitativo!.pj_512!;
          txtControllerPj_2.text = widget.sDistribuicaoFisicosServicoQuantitativo!.pj_2!;
          txtControllerPj_12.text = widget.sDistribuicaoFisicosServicoQuantitativo!.pj_12!;
          txtControllerPj_34.text = widget.sDistribuicaoFisicosServicoQuantitativo!.pj_34!;
        }
      }
    } catch (error) {
      OnAlertaInformacaoErro(error.toString(),context);
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 0.0,
        title: const Text(
          'Formulário Sici - Fust',
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 19.0,
              color: Color(0xffFFFFFF),
              fontFamily: "open-sans-regular"),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20.0),
            Container(
              height: 58.0,
              margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
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
                items: ListUfdb.map((UfModel value) {
                  return new DropdownMenuItem<UfModel>(
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
                onChanged: (UfModel? newValue) async {
                  try {

                  } catch (error) {

                  }
                },
              ),),
            SizedBox(height: 20.0),
            Padding( padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),child:TextField(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                try {

                } catch (error) {
                  OnAlertaInformacaoErro(error.toString(),context);
                }},
              controller: txtControllerMunicipio,
              autofocus: false,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                labelText: 'Selecione ..',
                hintText: 'Selecione ..',
              ),
            ),),
            SizedBox(height: 20.0),
            Container(
              height: 58.0,
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child:  DropdownButtonFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 16.0),
                  labelText: 'Nome tecnologia',
                  hintText: '',
                ),
                hint: Text(
                  "Selecione ..",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: const Color(0xFF90ffffff)),
                ),
                elevation: 16,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'avenir-lt-std-medium',
                  color: Color(0xFF000000),
                ),
                iconEnabledColor: Colors.white,
                value: tbTecnologia != null ? tbTecnologia : null,
                isExpanded: true,
                iconSize: 35,
                items:
                ListTecnologiadb.map((TechnologyModel value) {
                  return new DropdownMenuItem<TechnologyModel>(
                    value: value,
                    child: Text(
                      value.tecnologia!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 19.0,
                          color: Color(0xFF000000),
                          fontFamily:
                          "avenir-next-rounded-pro-regular"),
                    ),
                  );
                }).toList(),
                onChanged: (TechnologyModel? newValue) {
                  setState(() {
                    tbTecnologia = newValue!;
                    id_tecnologia = newValue.id!;
                    //_DistribuicaoFisicosServicoQuantitativo.tecnologia = newValue.tecnologia;
                  });
                },
              ),

            ),
            SizedBox(height: 10.0),
            Divider(),
            SizedBox(height: 10.0),
            TextField(
              controller: txtControllerCod_ibge,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                labelText: 'Código IBGE',
                hintText: '',
              ),
              keyboardType: TextInputType.text,
              maxLength: 500,
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller:txtControllerPf_0,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      labelText: 'PF - 0 - 512 Kbps',
                      hintText: '',
                    ),
                    keyboardType: TextInputType.text,
                    maxLength: 6,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: TextFormField(
                    controller: txtControllerPf_512,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      labelText: 'PF - 512 - 2',
                      hintText: '',
                    ),
                    keyboardType: TextInputType.text,
                    maxLength: 6,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: TextField(
                    controller: txtControllerPf_2,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      labelText: 'PF - 2 - 12',
                      hintText: '',
                    ),
                    keyboardType: TextInputType.text,
                    maxLength: 500,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: txtControllerPf_12,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      labelText: 'PF - 12 - 34 Mbps',
                      hintText: '',
                    ),
                    keyboardType: TextInputType.text,
                    maxLength: 6,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: TextField(
                    controller: txtControllerPf_34,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      labelText: 'PF - Maior 34 Mbps',
                      hintText: '',
                    ),
                    keyboardType: TextInputType.text,
                    maxLength: 6,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: txtControllerPj_0,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      labelText: 'PJ - 0 - 512 Kbps',
                      hintText: '',
                    ),
                    keyboardType: TextInputType.text,
                    maxLength: 6,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: TextField(
                    controller: txtControllerPj_512,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      labelText: 'PJ - 512 - 2',
                      hintText: '',
                    ),
                    keyboardType: TextInputType.text,
                    maxLength: 6,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: TextField(
                    controller: txtControllerPj_2,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      labelText: 'PJ - 2 - 12',
                      hintText: '',
                    ),
                    keyboardType: TextInputType.text,
                    maxLength: 500,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: txtControllerPj_12,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      labelText: 'PJ - 12 - 34 Mbps',
                      hintText: '',
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
                      labelText: 'PJ - Maior 34 Mbps',
                      hintText: '',
                    ),
                    keyboardType: TextInputType.text,
                    maxLength: 6,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.0),
            Center(child: Padding(padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),child: TextButton(
              child: const Text(' Adicionar '),
              onPressed: () async {
                onAdd();
              },
            ),),),
            SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
