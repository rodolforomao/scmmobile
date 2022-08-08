import 'package:flutter/material.dart';
import '../../data/tb_uf_municipality.dart';
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

    } catch (error) {
      statusView = TypeView.viewErrorInformation;
      GlobalScaffold.ErroInformacao = error.toString();
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
        flexibleSpace: Container(
          decoration: BoxDecoration(
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
          "Variável de ambiente",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 19.0,
              color: Color(0xffFFFFFF),
              fontFamily: "open-sans-regular"),
        ),
        actions: <Widget>[

        ],
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
          decoration: BoxDecoration(
            color: Colors.white,
          ),
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
                    style: TextStyle(
                        fontSize: 19.0,
                        color: Color(0xff333333),
                        fontFamily: "avenir-lt-std-medium"),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right,
                      color: Color(0xFF545454), size: 30.0)),
            ),
          ),
        );
    }
  }
}

