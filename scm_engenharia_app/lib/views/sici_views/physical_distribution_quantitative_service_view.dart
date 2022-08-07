import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/quantitative_distribution_physical_accesses_service_model.dart';
import '../../models/technology_model.dart';
import '../../models/uf_model.dart';
import '../../models/uf_municipality_model.dart';
import '../help_views/global_scaffold.dart';


class PhysicalDistributionQuantitativeServiceView extends StatefulWidget {

  QuantitativeDistributionPhysicalAccessesServiceModel? sDistribuicaoFisicosServicoQuantitativo;
  PhysicalDistributionQuantitativeServiceView({Key? key, required this.sDistribuicaoFisicosServicoQuantitativo}) : super(key: key);

  @override
  PhysicalDistributionQuantitativeServiceState createState() => PhysicalDistributionQuantitativeServiceState();
}

class PhysicalDistributionQuantitativeServiceState extends State<PhysicalDistributionQuantitativeServiceView> {




  List<TechnologyModel> ListTecnologiadb = [];
  List<UfModel> ListUfdb = [];
  List<UfMunicipalityModel> ListUfMunicipiodb = [];
  UfMunicipalityModel tbUfMunicipio = UfMunicipalityModel();
  UfModel tbUf = UfModel();
  TechnologyModel tbTecnologia = new TechnologyModel();

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


  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
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
                value: tbUf,
                isExpanded: true,
                iconSize: 35,
                items: ListUfdb.map((UfModel value) {
                  return new DropdownMenuItem<UfModel>(
                    onTap: () {
                      setState(() {
                        tbUf = value;
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

              },
            ),),),
            SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
