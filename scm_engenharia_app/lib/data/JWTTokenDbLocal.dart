import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:scm_engenharia_app/models/operation.dart';
import '../help/componentes.dart';
import 'app_scm_engenharia_mobile_bll.dart';
import 'tb_user.dart';

class ComponentsJWTToken {

  static Future<String?> JWTTokenPadrao() async {
    try {
      Operation loggedInuser = await AppScmEngenhariaMobileBll.instance.onSelectUser();
      if (loggedInuser.erro) {
        throw loggedInuser.message!;
      } else if (loggedInuser.result == null) {
        return Componentes.JWTTokenPadrao();
      } else {
        TbUser respUser =  loggedInuser.result as TbUser;
        String key =
            "bc47f175a831996b652146d47e159349f75e6c4665570ef35606678a18054d13";
        final claimSet = JwtClaim(otherClaims: <String, Object>{
          "user": respUser.email,
          "pass": respUser.password,
        });
        // Generate a JWT from the claim set
        final token = issueJwtHS256(claimSet, key);
        return token;
      }

    } catch (error) {
      throw (error.toString());
    }
  }

}
