import 'package:flutter/cupertino.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:scm_engenharia_app/data/db_helper.dart';
import 'package:scm_engenharia_app/data/tb_usuario.dart';
import 'package:scm_engenharia_app/help/components.dart';
import 'package:scm_engenharia_app/models/operacao.dart';
import 'package:scm_engenharia_app/pages/erro_informacao_page.dart';

class ComponentsJWTToken {

  static Future<String?> JWTTokenPadrao() async {
    try {
      DBHelper  dbHelper = DBHelper();
      Operacao _UsuarioLogado = await dbHelper.onSelecionarUsuario();
      if (_UsuarioLogado.erro)
        throw (_UsuarioLogado.mensagem!);
      else if (_UsuarioLogado.resultado == null) {
        return Components.JWTTokenPadrao();
      }
      else {
        TbUsuario  _Usuariodb = _UsuarioLogado.resultado as TbUsuario;
        String key =
            "bc47f175a831996b652146d47e159349f75e6c4665570ef35606678a18054d13";
        final claimSet = new JwtClaim(otherClaims: <String, Object>{
          "user": "" + _Usuariodb.email! + "",
          "pass": "" + _Usuariodb.senha! + "",
        });
        // Generate a JWT from the claim set
        final token = issueJwtHS256(claimSet, key);
        return token;
      }

    } catch (error) {

    }
    return '';
  }

}