import 'dart:convert';
import 'package:flutter/material.dart';
import '../../help/components.dart';
import '../../models/output/output_environment_variables_model.dart';
import '../../thema/app_thema.dart';
import '../help_views/global_scaffold.dart';
import '../help_views/global_view.dart';
import 'package:flutter/services.dart';

class SelecionarMunicipioView extends StatefulWidget {
  List<CodIbge> sMunicipios;
  Uf? sUf;
  SelecionarMunicipioView(
      {Key? key, required this.sUf, required this.sMunicipios})
      : super(key: key);

  @override
  SelecionarMunicipioState createState() => SelecionarMunicipioState();
}

class SelecionarMunicipioState extends State<SelecionarMunicipioView> {
  TypeView statusView = TypeView.viewLoading;
  final txtMunicipalityName = TextEditingController();
  List<CodIbge> listMunicipios = [];
  late bool isSearching = false;

  onInc() async {}

  @override
  void initState() {
    super.initState();
    try {
      setState(() {
        statusView = TypeView.viewRenderInformation;
        listMunicipios = widget.sMunicipios;
      });
    } catch (error) {
      setState(() {
        statusView = TypeView.viewErrorInformation;
        GlobalScaffold.erroInformacao = error.toString();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140.0),
        child: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: StylesThemas.boxDecorationAppBar,
          ),
          elevation: 0.0,
          title: Text(
            'Municípios do estado ${widget.sUf!.uf}',
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0.0),
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(
                maxWidth: 900,
              ),
              padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 15.0),
              child: Row(
                children: [
                  Flexible(
                    flex: 6,
                    fit: FlexFit.tight,
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(splashColor: Colors.transparent),
                      child: TextField(
                        enableInteractiveSelection: true,
                        keyboardType: TextInputType.text,
                        controller: txtMunicipalityName,
                        textInputAction: TextInputAction.go,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Color(0xffFFFFFF),
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xff70FFFFFF),
                          hintStyle: const TextStyle(
                              fontSize: 14.0, color: Color(0xff80FFFFFF)),
                          hintText: 'Nome do município',
                          contentPadding:
                              const EdgeInsets.fromLTRB(10.0, 9.0, 10.0, 11.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 0.5),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.transparent, width: 0.9),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            if (Components.isNumeric(value)) {
                              listMunicipios = widget.sMunicipios
                                  .where((element) => element.codIbge!
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                                  .toList();
                            } else {
                              listMunicipios = widget.sMunicipios
                                  .where((element) => element.descricao!
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                                  .toList();
                            }
                            if (listMunicipios.isEmpty) {
                              setState(() {
                                statusView = TypeView.viewErrorInformation;
                                GlobalScaffold.erroInformacao =
                                    'Não a registro para esta solicitação';
                              });
                            } else {
                              setState(() {
                                statusView = TypeView.viewRenderInformation;
                              });
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: IconButton(
                      icon: const Icon(
                        Icons.search_outlined,
                        color: Colors.white,
                      ),
                      iconSize: 30,
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        setState(() {
                          if (Components.isNumeric(txtMunicipalityName.text)) {
                            listMunicipios = widget.sMunicipios
                                .where((element) => element.codIbge!
                                    .toLowerCase()
                                    .contains(
                                        txtMunicipalityName.text.toLowerCase()))
                                .toList();
                          } else {
                            listMunicipios = widget.sMunicipios
                                .where((element) => element.descricao!
                                    .toLowerCase()
                                    .contains(
                                        txtMunicipalityName.text.toLowerCase()))
                                .toList();
                          }
                          if (listMunicipios.isEmpty) {
                            setState(() {
                              statusView = TypeView.viewErrorInformation;
                              GlobalScaffold.erroInformacao =
                                  'Não a registro para esta solicitação';
                            });
                          } else {
                            setState(() {
                              statusView = TypeView.viewRenderInformation;
                            });
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: viewType(MediaQuery.of(context).size.height),
    );
  }

  viewType(double maxHeight) {
    switch (statusView) {
      case TypeView.viewLoading:
        return GlobalView.viewPerformingSearch(maxHeight, context);
      case TypeView.viewErrorInformation:
        return GlobalView.viewErrorInformation(
            maxHeight, GlobalScaffold.erroInformacao, context);
      case TypeView.viewRenderInformation:
        return Align(
          alignment: Alignment.topCenter,
          child: Container(
            alignment: Alignment.topCenter,
            constraints: const BoxConstraints(minHeight: 500, maxWidth: 1000),
            child: RefreshIndicator(
              onRefresh: () async {},
              child: Card(
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: listMunicipios.length,
                  itemBuilder: (BuildContext context, int index) => ListTile(
                      onTap: () {
                        //Navigator.of(context).pop(widget.sMunicipios[index]);
                        Navigator.of(context).pop(listMunicipios[index]);
                      },
                      contentPadding:
                          const EdgeInsets.fromLTRB(15.0, 7.0, 15.0, 7.0),
                      title: RichText(
                          textAlign: TextAlign.left,
                          softWrap: false,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(children: [
                            const TextSpan(
                              text: 'Código IBGE : ',
                              style: TextStyle(
                                fontSize: 17.0,
                                color: Color(0xff333333),
                              ),
                            ),
                            TextSpan(
                              text: listMunicipios[index].codIbge.toString(),
                              style: const TextStyle(
                                fontSize: 15.0,
                                color: Color(0xff333333),
                              ),
                            ),
                          ])),
                      subtitle: RichText(
                          textAlign: TextAlign.left,
                          softWrap: false,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(children: [
                            const TextSpan(
                              text: 'Descrição : ',
                              style: TextStyle(
                                fontSize: 17.0,
                                color: Color(0xff333333),
                              ),
                            ),
                            TextSpan(
                              text: listMunicipios[index].descricao.toString(),
                              style: const TextStyle(
                                fontSize: 15.0,
                                color: Color(0xff333333),
                              ),
                            ),
                          ])),
                      trailing: const Icon(Icons.keyboard_arrow_right,
                          color: Color(0xFF545454), size: 30.0)),
                ),
              ),
            ),
          ),
        );
    }
  }
}
