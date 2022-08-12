import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../../data/tb_uf_municipality.dart';
import '../../models/environment_variables.dart';
import '../../models/operation.dart';
import '../../web_service/servico_mobile_service.dart';
import '../help_views/global_scaffold.dart';
import '../help_views/global_view.dart';


class EnvironmentVariableView extends StatefulWidget {
  const EnvironmentVariableView({Key? key}) : super(key: key);
  @override
  EnvironmentVariableState createState() => EnvironmentVariableState();
}

class EnvironmentVariableState extends State<EnvironmentVariableView>  {

  List<TbUfMunicipality> ListMunicipio = [];
  TypeView statusView = TypeView.viewLoading;

  onInc() async {
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        OnAlertaInformacaoErro('Verifique sua conexão com a internet e tente novamente.',context);
      } else {
        setState((){statusView = TypeView.viewLoading;});
        Operation resultRest = await ServicoMobileService.onEnvironmentVariables();
        if (resultRest.erro) {
          throw (resultRest.message!);
        } else {
          setState(() {
            EnvironmentVariables resul = EnvironmentVariables.fromJson(resultRest.result as Map<String, dynamic>);
            statusView = TypeView.viewRenderInformation;
          });
        }
      }
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
        title: const Text(
          'Variável de ambiente',
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
              itemCount: ListMunicipio.length,
              itemBuilder: (BuildContext context, int index) => ListTile(
                  onTap: () {
                    // Navigator.pop(context,ListMunicipio[index],);
                    Navigator.of(context).pop(ListMunicipio[index]);
                    //Navigator.of(context).pop(context);
                  },
                  contentPadding: EdgeInsets.fromLTRB(15.0, 7.0, 15.0, 7.0),
                  title: Text(
                    ListMunicipio[index].municipality,
                    style: const TextStyle(
                        fontSize: 19.0,
                        color: Color(0xff333333),
                    ),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right,
                      color: Color(0xFF545454), size: 30.0)),
            ),
          ),
        );
    }
  }
}

