import 'package:flutter/material.dart';
import '../../data/tb_uf_municipality.dart';
import '../help_views/global_scaffold.dart';
import '../help_views/global_view.dart';



class SelectCityView extends StatefulWidget {

  List<TbUfMunicipality> sMunicipality;
  String Uf;
  SelectCityView({Key? key, required this.sMunicipality,required this.Uf}) : super(key: key);

  @override
  SelectCityState createState() => SelectCityState();
}

class SelectCityState extends State<SelectCityView>  {


  TypeView statusView = TypeView.viewLoading;
  List<TbUfMunicipality> ListMunicipio = [];


  onInc() async {
    try {
      if(widget.sMunicipality.isEmpty)
      {
        throw ('Não há  municípios selecionados');
      }
      else {
        setState(() {
          ListMunicipio =widget.sMunicipality;
        });
      }
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(20.0,20.0, 20.0, 0.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Color(0xFFF65100),
                  Color(0xFFf5821f),
                  Color(0xFFff8c49),
                ],
              ),
            ),
          ),
          elevation: 0.0,
          centerTitle: false,
          title:Text(
            "Os municípios  " + widget.Uf,
            style: TextStyle(
                fontSize: 19.0,
                color: Color(0xffFFFFFF),
                fontFamily: "open-sans-regular"),
          ),

          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Padding(padding: EdgeInsets.fromLTRB(15.0,0.0, 15.0, 20.0),child:Theme(
                data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                child: TextField(
                  maxLines: 1,
                  autofocus: false,
                  onChanged: (String value) async {
                    print(value);
                    if (value.length >= 1) {
                      setState(() {
                        ListMunicipio =  widget.sMunicipality.where((f) => f.municipality.toLowerCase().startsWith(value.toLowerCase())).toList();
                      });
                    } else if (value.length == 0) {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      setState(() {
                        ListMunicipio =  widget.sMunicipality.toList();
                      });
                    }
                  },
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'open-sans-regular',
                      color: const Color(0xFFffffff)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xff80FFFFFF),
                    hintText: "Digite o nome do município ...",
                    hintStyle: TextStyle(fontSize: 15.0, color: const Color(0xFF95ffffff) ,fontFamily: 'avenir-lt-std-medium'),
                    labelStyle: TextStyle(
                        fontSize: 15,
                        color: Color(0xFFb8b8b8),
                        fontFamily: 'avenir-lt-std-medium-oblique'),
                    contentPadding: EdgeInsets.fromLTRB(10.0, 11.0, 10.0, 11.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0.5),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent ,width: 0.9),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 20,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),)
          ),
        ),
      ),
      body: viewType(MediaQuery.of(context).size.height),);
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
          decoration: const BoxDecoration(
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
                  contentPadding: const EdgeInsets.fromLTRB(15.0, 7.0, 15.0, 7.0),
                  title: Text(
                    ListMunicipio[index].municipality,
                    style: const TextStyle(
                        fontSize: 19.0,
                        color: Color(0xff333333),),
                  ),
                  trailing: const Icon(Icons.keyboard_arrow_right,
                      color: Color(0xFF545454), size: 30.0)),
            ),
          ),
        );
    }
  }
}

