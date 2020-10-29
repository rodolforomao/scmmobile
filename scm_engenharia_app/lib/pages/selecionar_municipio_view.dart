import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scm_engenharia_app/data/tb_uf_municipio.dart';


class SelecionarMunicipioView extends StatefulWidget {

  List<TbUfMunicipio> sMunicipios;
  String Uf;
  SelecionarMunicipioView({Key key, @required this.sMunicipios,@required this.Uf}) : super(key: key);

  @override
  _SelecionarMunicipioView createState() => _SelecionarMunicipioView();
}



class _SelecionarMunicipioView extends State<SelecionarMunicipioView>  {
  ScrollController _scrollController;
  List<TbUfMunicipio> ListMunicipio = new List<TbUfMunicipio>();
  String _StatusTipoWidget = "view_realizando_busca", ErroInformacao = "";

  Inc() async {
    try {
      setState(() {
        _StatusTipoWidget = "view_renderizar_tela";
        ListMunicipio = widget.sMunicipios;
      });
    } catch (error) {
      setState(() {
        ErroInformacao = error.toString();
        _StatusTipoWidget = "view_erro_informacao";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _scrollController.addListener(() => setState(() {}));
    Inc();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController?.dispose();
  }
  double scale = 1.0;
  bool get _showTitle {

    //starting fab position
    final double defaultTopMargin = 100.0;
    //pixels from top where scaling should start
    final double scaleStart = 30.0;
    //pixels from top where scaling should end
    final double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;

    if (_scrollController.hasClients) {
      print(scale);
      double offset = _scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        //offset between scaleStart and scaleEnd => scale down
        setState(() {
          scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
        });

      } else {
        //offset passed scaleEnd => hide fab
        setState(() {
          scale = 0.0;
        });

      }
    }
    print(_scrollController.hasClients && _scrollController.offset > 200.0 - kToolbarHeight);
    return _scrollController.hasClients && _scrollController.offset > 200.0 - kToolbarHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            title: Text(
              "Os municípios  " + widget.Uf,
              style: TextStyle(
                  fontSize: 19.0,
                  color: Color(0xffFFFFFF),
                  fontFamily: "open-sans-regular"),
            ),
            expandedHeight: 150.0,
            floating: true,
            pinned: true,
            elevation: 0.0,
            flexibleSpace: Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
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
              child: _showTitle
                  ?  Container() : Opacity(
                opacity: scale,
                child: Container(
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 15.0),
                  child:  Theme(
                    data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                    child: TextField(
                      maxLines: 1,
                      autofocus: false,
                      onChanged: (String value) async {
                        print(value);
                        if (value.length >= 1) {
                          //ListMunicipio.sort((a, b) => a.Valor.compareTo(b.Valor));
                          ListMunicipio =  widget.sMunicipios.where((f) => f.municipio.toLowerCase().startsWith(value.toLowerCase())).toList();
                        } else if (value.length == 0) {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          ListMunicipio =  widget.sMunicipios.toList();
                        }
                      },
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat-Regular',
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
                        contentPadding: EdgeInsets.fromLTRB(10.0, 13.0, 10.0, 11.0),
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
                  ),
                ),
              ) ,
            ),
          ),
          _TipoWidget()
        ],
      ),);
  }

  _TipoWidget() {
    switch (_StatusTipoWidget) {
      case "view_realizando_busca":
        {
          return SliverToBoxAdapter(child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              constraints: BoxConstraints(

                maxWidth: MediaQuery.of(context).size.width,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 30.0),
                    Text(
                      "Realizando busca das cidades...",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: "avenir-lt-std-medium",
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    SizedBox(
                      child: CircularProgressIndicator(
                        valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xff0071bc)),
                      ),
                      height: 70.0,
                      width: 70.0,
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              )),);
        }
        break;
      case "view_renderizar_tela":
        {
          return  SliverList(
            delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                    color: Color(0xffFFFFFF),
                    border: Border(
                        bottom: BorderSide(color: Colors.grey.shade300, width: 0.5))),
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
                width: MediaQuery.of(context).size.width,
                child: ListTile(
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      Navigator.pop(context,ListMunicipio[index]);
                    },
                    contentPadding: EdgeInsets.fromLTRB(15.0, 7.0, 15.0, 7.0),
                    dense: true,
                    title: Text(
                      ListMunicipio[index].municipio,
                      style: TextStyle(
                          fontSize: 19.0,
                          color: Color(0xff333333),
                          fontFamily: "avenir-lt-std-medium"),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right,
                        color: Color(0xFF545454), size: 30.0)),
              );},
              childCount:ListMunicipio.length,
            ),
          );
        }
        break;
      case "view_erro_informacao":
        {
          return SliverToBoxAdapter(child:Container(
              alignment: Alignment.center,

              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/imagens/img_informacao.png",
                      width: 110.0,
                      height: 110.0,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(height: 45.0),
                    Text(
                      "Desculpe houve um problema.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: "avenir-lt-std-medium",
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      ErroInformacao,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: "avenir-lt-std-medium-oblique",
                        fontSize: 15.0,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              )),);
        }
        break;
    }
  }
}

