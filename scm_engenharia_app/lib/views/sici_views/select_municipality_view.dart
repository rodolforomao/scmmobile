import 'dart:convert';
import 'package:flutter/material.dart';
import '../../models/environment_variables.dart';
import '../help_views/global_scaffold.dart';
import '../help_views/global_view.dart';
import 'package:flutter/services.dart';

class SelectMunicipalityView extends StatefulWidget {
  List<CodIbge> sMunicipios;
  Uf? sUf;
  SelectMunicipalityView({Key? key, required this.sUf,required this.sMunicipios}) : super(key: key);

  @override
  SelectMunicipalityState createState() => SelectMunicipalityState();
}

class SelectMunicipalityState extends State<SelectMunicipalityView>  {

  TypeView statusView = TypeView.viewLoading;

  onInc() async {
    try {
      setState((){statusView = TypeView.viewLoading;});
      String response = await rootBundle.loadString('assets/variavel_de_ambiente.json');
      setState(()  {
        EnvironmentVariables resul = EnvironmentVariables.fromJson(jsonDecode(response) as Map<String, dynamic>);
        statusView = TypeView.viewRenderInformation;
      });
    } catch (error) {
      setState(() {
        statusView = TypeView.viewErrorInformation;
        GlobalScaffold.ErroInformacao = error.toString();
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 0.0,
        title:  Text('Municípios do estado de ${widget.sUf!.uf}',),
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
        return Container(
          width: MediaQuery.of(context).size.width,
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: RefreshIndicator(
            onRefresh: () async {
              // OnGetCampanhas(context);
            },
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: widget.sMunicipios.length,
              itemBuilder: (BuildContext context, int index) => ListTile(
                  onTap: () {
                    Navigator.of(context).pop(widget.sMunicipios[index]);
                  },
                  contentPadding: const EdgeInsets.fromLTRB(15.0, 7.0, 15.0, 7.0),
                  title: RichText(
                      textAlign: TextAlign.left,
                      softWrap: false,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Código IBGE : ',
                          style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 15),
                        ),
                        TextSpan(
                          text: widget.sMunicipios[index].codIbge.toString(),
                          style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 13),
                        ),
                      ])),
                  subtitle:RichText(
                      textAlign: TextAlign.left,
                      softWrap: false,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Descrição : ',
                          style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 15),
                        ),
                        TextSpan(
                          text: widget.sMunicipios[index].descricao.toString(),
                          style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 13),
                        ),
                      ])),
                  trailing: const Icon(Icons.keyboard_arrow_right, color: Color(0xFF545454), size: 30.0)),
            ),
          ),
        );
    }
  }
}

