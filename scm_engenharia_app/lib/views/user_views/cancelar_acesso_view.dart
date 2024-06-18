import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../help/formatter/cpf_input_formatter.dart';
import '../../help/parameter_result_view.dart';
import '../../help/responsive.dart';
import '../../models/operation.dart';
import '../../thema/app_thema.dart';
import '../../web_service/servico_mobile_service.dart';
import '../../help/navigation_service/route_paths.dart' as routes;
import 'package:scm_engenharia_app/models/global_user_logged.dart' as global_user_logged;
import '../help_views/global_scaffold.dart';



class CancelarAcessoView extends StatefulWidget {
  const CancelarAcessoView({super.key});
  @override
  CancelarAcessoState createState() => CancelarAcessoState();
}

class CancelarAcessoState extends State<CancelarAcessoView> with ParameterResultViewEvent {


  TextEditingController txtControllerUsuario = TextEditingController();

  onCancelarAcesso() async {
    try {
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
        OnAlert.onAlertError(context, "Parece que você está sem internet ! Por favor, verifique a sua conexão e tente novamente.");

      } else {
        if (txtControllerUsuario.text.isEmpty) {
          throw ('Credencial e obrigatório\n');
        }
        else if (txtControllerUsuario.text.replaceAll(".", '').replaceAll("-", '') != global_user_logged.globalUserLogged!.cpf) {
          throw ('Credencial não conferem\n');
        } else {
          GlobalScaffold.instance.onToastPerformingOperation('Realizando operação');
          Operation resultRest = await ServicoMobileService.onCancelAccess(global_user_logged.globalUserLogged!.idUser).whenComplete(() => GlobalScaffold.instance.onHideCurrentSnackBar());
          if (resultRest.erro) {
            throw (resultRest.message!);
          }
          else {
            OnAlertSuccess('Operação realizada com sucesso');
          }
        }
      }
    } catch (error) {
      OnAlert.onAlertError(context, error.toString().split('\r\n').first);
    }
  }

  onInc() async {
    try {
      erroInformation = '';
      if (await Connectivity().checkConnectivity() == ConnectivityResult.none)
      {
        GlobalScaffold.instance.navigatorKey.currentState?.pushNamed(
          routes.erroInternetRoute,
        ).then((value) async {
          onInc();
        });
      }
      else
      {

      }
    } catch (error) {
      GlobalScaffold.instance.navigatorKey.currentState?.pushNamed(
        routes.cancelarAcessoRoute,
        arguments:  {
          'view': routes.cancelarAcessoRoute,
          'error': error
        },
      ).then((value) {
        onInc();
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
    double maxHeight = maxHeightAppBar(context, 55);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: AppBar(
          centerTitle: true,
          flexibleSpace: Container(
            decoration: StylesThemas.boxDecorationAppBar,
          ),
          title: const Text(
            'Cancelar acesso',
          ),
          toolbarHeight: 50,
          backgroundColor: Colors.transparent,
        ),
      ),
      body:SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0, bottom: 10.0),
        child: Container(
          constraints:  BoxConstraints(
            minHeight: 500,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child:  Container(constraints: const BoxConstraints(
            maxWidth: 1000,
          ),child:  Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 10.0),
                child: RichText(
                    textAlign: TextAlign.start,
                    softWrap: false,
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                    text:  TextSpan(children: [
                      TextSpan(
                        text:
                        'Prezado cliente,\r\n',
                        style: StylesThemas.textStyleTextTitle().copyWith(fontSize: 20,color:  Colors.black, fontWeight: FontWeight.w600,),
                      ),
                      const TextSpan(
                        text: 'O cancelamento do serviço de participação implica no não-recebimento de relatórios pela Internet e revoga seu acesso. Para confirmar o cancelamento, informe sua credencial  e clique no botão "CONFIRMAR"',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins-Regular',
                            fontWeight: FontWeight.w100,
                            color: Color(0xFF323232)),
                      ),
                    ])),
              ),
              const SizedBox(height: 20.0),
              Padding(padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),child: TextField(
                controller: txtControllerUsuario,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins-Regular',
                    fontWeight: FontWeight.w100,
                    color: Color(0xFF323232)),
                inputFormatters: [
                  // obrigatório
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
                onSubmitted: (term) {

                },
                decoration: const InputDecoration(
                  hintText: 'Digite sua Credencial ',
                  labelText: 'Credencial',
                ),
              ),),
              const SizedBox(height: 25.0),
              ElevatedButton(
                style: TextButton.styleFrom(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  elevation: 0,
                  backgroundColor: const Color(0xffef7d00),
                  padding: const EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 3.0),
                  minimumSize: const Size(350, 50),
                  maximumSize: const Size(350, 50),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color:  Color(0xffFFFFFF),
                    fontSize: 15,
                  ),
                ),
                child: const Padding(
                  padding:
                  EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                  child: Text(
                    'CONFIRMAR',
                    style:  TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                ),
                onPressed: () async {
                  onCancelarAcesso();
                },
              ),
              const SizedBox(height: 25.0),
            ],
          ),),),),
    );
  }
}
