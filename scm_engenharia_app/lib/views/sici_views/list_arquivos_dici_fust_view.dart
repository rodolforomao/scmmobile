import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scm_engenharia_app/views/sici_views/selecione_arquivo_dici_fust_view.dart';
import 'dart:async';
import '../../data/app_scm_engenharia_mobile_bll.dart';
import '../../data/tb_arquivo_dici_fust.dart';
import '../../help/components.dart';
import '../../models/operation.dart';
import '../../thema/app_thema.dart';
import '../help_views/global_scaffold.dart';
import '../help_views/global_view.dart';


class ListArquivosDiciFustView extends StatefulWidget {
  const ListArquivosDiciFustView({Key? key}) : super(key: key);
  @override
  ListArquivosDiciFustState createState() => ListArquivosDiciFustState();
}

class ListArquivosDiciFustState extends State<ListArquivosDiciFustView> {

  List mapFileModelAllList = [];

  TypeView statusView = TypeView.viewLoading;
  final txtSocialReason = TextEditingController();
  late bool isSearching = false;


  onRestDb() async {
    try {
      setState(() {statusView = TypeView.viewLoading;});
      Operation respBll = await AppScmEngenhariaMobileBll.instance.onArquivoDiciFustAll();
      if (respBll.erro || respBll.result == null) {
        throw respBll.message!;
      } else {
        setState(() {
          List<TbArquivoDiciFust> res =  respBll.result as  List<TbArquivoDiciFust>;
          for (var v in res) {
            Map<String, dynamic> user = jsonDecode(v.result);
            mapFileModelAllList.add(user);
          }
          if(mapFileModelAllList.isNotEmpty)
          {
            statusView = TypeView.viewRenderInformation;
          }
        });
      }
    } catch (error) {
      setState(() {
        statusView = TypeView.viewErrorInformation;
        GlobalScaffold.erroInformacao = error.toString();
      });
    }
  }


  @override
  void initState() {
    super.initState();
    onRestDb();
    Future.delayed(Duration.zero, () {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: StylesThemas.boxDecorationAppBar,
          ),
          elevation: 0.0,
          title: Text('Arquivos/Dici'),
        ),
      ),
      body: viewType(MediaQuery.of(context).size.height),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              fullscreenDialog: true,
              pageBuilder: (c, a1, a2) => const SelecioneArquivoDiciFustView(),
              transitionsBuilder: (context, anim1, anim2, child) {
                return SlideTransition(
                  position: Tween<Offset>(end: const Offset(0, 0), begin: const Offset(1, 1)).animate(anim1),
                  child: const SelecioneArquivoDiciFustView(),
                );
              },
            ),
          ).then((value) {
            onRestDb();
          });
        },
        backgroundColor: Color(0xffef7d00),
        child: const Icon(Icons.attach_file ,color: Colors.white,size: 30,),
      ),
    );
  }

  viewType(double maxHeight) {
    switch (statusView) {
      case TypeView.viewLoading:
        return GlobalView.viewPerformingSearch(maxHeight,context);
      case TypeView.viewErrorInformation:
        return GlobalView.viewErrorInformation(maxHeight,GlobalScaffold.erroInformacao,context);
      case TypeView.viewRenderInformation:
        return  Align( alignment: Alignment.topCenter,child: Container(
          alignment: Alignment.topCenter,
          constraints:  const BoxConstraints(
              minHeight: 500,
              maxWidth: 1000
          ),
          child: RefreshIndicator(
            onRefresh: () async {

            },
            child: Card(
              child:  ListView.builder(
                padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: mapFileModelAllList.length,
                itemBuilder: (BuildContext context, int index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      height: 150.0,
                      padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                                child: RichText(
                                    textAlign: TextAlign.left,
                                    softWrap: false,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: 'Data cadastro \r\n',
                                          style: StylesThemas.textStyleTextSpanTitle().copyWith(fontSize: 12)
                                      ),
                                      TextSpan(
                                          text: Components.onFormatarData(mapFileModelAllList[index]['data']),
                                          style: StylesThemas.textStyleTextSpanSubtitle().copyWith(fontSize: 16)
                                      ),
                                    ]))),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                              child:  RichText(
                                  textAlign: TextAlign.start,
                                  softWrap: false,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Nome do arquivo\r\n ',
                                        style: StylesThemas.textStyleTextSpanTitle().copyWith(fontSize: 12)
                                    ),
                                    TextSpan(
                                        text: Components.onIsEmpty(mapFileModelAllList[index]['name']),
                                        style: StylesThemas.textStyleTextSpanSubtitle().copyWith(fontSize: 16)
                                    ),
                                  ])),),
                          ]),
                    ),
                    const  SizedBox(width: 25.0),
                    Align(alignment: Alignment.bottomRight,child: Padding( padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0), child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return Dialog(
                                child: Container(
                                  padding: const EdgeInsets.all(25.0),
                                  constraints: const BoxConstraints(
                                    minWidth: 70,
                                    maxWidth: 450,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
                                        height: 50.0,
                                        child: const Text(
                                          'Deseja realmente remover ?',
                                          textAlign: TextAlign.start,
                                          softWrap: false,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Color(0xFF000000),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        constraints: const BoxConstraints(
                                          maxWidth: 400,
                                        ),
                                        margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 14.0),
                                                child:  OutlinedButton(
                                                  style: TextButton.styleFrom(
                                                    backgroundColor: const Color(0xFFffffff),
                                                    side: const BorderSide(
                                                      color: Color(0xffef7d00), //Color of the border
                                                    ),
                                                    minimumSize: const Size(130, 43),
                                                    maximumSize: const Size(130, 43),
                                                    textStyle: const TextStyle(
                                                      color:  Color(0xffFFFFFF),
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    try {
                                                      Operation respUser = await AppScmEngenhariaMobileBll().onDeleteDiciFustId(Components.onIsEmpty(mapFileModelAllList[index]['id']));
                                                      if (respUser.erro || respUser.result == null) {
                                                        throw respUser.message!;
                                                      } else {
                                                        onRestDb();
                                                        GlobalScaffold.instance.onToastSuccess(respUser.message!);
                                                        Navigator.pop(context);
                                                      }
                                                    } catch (error) {
                                                      GlobalScaffold.instance.onToastError(error.toString());
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  child: const Text('  Sim  ',
                                                      style: TextStyle(
                                                        color: Color(0xffef7d00),
                                                      )),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 14.0),
                                                child: OutlinedButton(
                                                  style: TextButton.styleFrom(
                                                    minimumSize: const Size(130, 43),
                                                    maximumSize: const Size(130, 43),
                                                    textStyle: const TextStyle(
                                                      color:  Color(0xffFFFFFF),
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    try {
                                                      Navigator.pop(context);
                                                    } catch (error) {
                                                      GlobalScaffold.instance.onToastError(error.toString());
                                                    }
                                                  },
                                                  child: const Text('  Não  ',
                                                      style: TextStyle(
                                                        color: Color(0xFFffffff),
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                          },
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Icon(Icons.delete_outlined,
                              size: 20, color: Color(0xFF000000)),
                        ],
                      ),
                    ),),),
                    const  SizedBox(width: 10.0),
                    const Divider(
                      color:  Color(0xffCCCCCC),
                    ),
                  ],
                ),
              ),),
          ),),);
    }
  }
}
