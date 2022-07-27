import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


import '../data/JWTTokenDbLocal.dart';
import '../help/componentes.dart';
import '../models/Operation.dart';

class ServicoMobileService {
  static final Url = "http://sici.scmengenharia.com.br";
  //static final Url = "http://10.0.2.2:8083";
  //static final Url = "http://192.168.0.122:8083";
  //static final Url = "http://wsscm.ddns.net";

  Future<Operation> OnLogin(ModelLoginJson _Modelo) async {
    Operation operacao = Operation();
    try {
      String? token = await Componentes.JWTToken(_Modelo.usuario.toString(), _Modelo.password!);
      final response = await http
          .post(Uri.parse(Url + "/login_ws"),
              headers: {
                //"Content-type": "multipart/form-data",
                "token": token!,
              },
              encoding: Encoding.getByName("utf-8"))
          .timeout(const Duration(seconds: 10));
      operacao.statusCode = response.statusCode;
      if (response.statusCode == 200) {
        if (!response.body.isNotEmpty) {
          throw (ApiRestInformation.problemOfComunication);
        }
        else
          {
            Map<String, dynamic> map = jsonDecode(Componentes.removeAllHtmlTags(response.body));
            OperationJson resp = OperationJson.fromJson(map);
            operacao.erro = !resp.status!;
            operacao.message = resp.mensagem;
            operacao.result = resp.resultado;
          }
        if (operacao.message == null) {
          throw ('Não foi identificado resposta');
        }
      } else {
        operacao = await ApiRestStatusAnswerHTTP.AnswersHTTP(response.statusCode, response.body);
      }
    } catch (e) {
      operacao.erro = true;
      operacao.message = e.toString();
    }
    return operacao;
  }

  Future<Operation> OnAlterarSenha(String _Senha) async {
    Operation operacao = Operation();
    try {
      String? token = await ComponentsJWTToken.JWTTokenPadrao();
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=utf-8',
        "token": token!,
      };
      http.MultipartRequest response;
      response = http.MultipartRequest('POST', Uri.parse(Url + "/usuario/alterar_senha_ws"));
      response.headers.addAll(headers);
      response.fields['nova_senha'] = _Senha;
      var streamedResponse = await response.send();
      final respStr = await streamedResponse.stream.bytesToString();
      var jsonResp = Componentes.removeAllHtmlTags(respStr);
      operacao.statusCode = streamedResponse.statusCode;
      if (streamedResponse.statusCode == 200) {
        if (!streamedResponse.body.isNotEmpty) {
          throw (ApiRestInformation.problemOfComunication);
        }
        else
        {
          Map<String, dynamic> map = jsonDecode(Componentes.removeAllHtmlTags(response.body));
          OperationJson resp = OperationJson.fromJson(map);
          operacao.erro = !resp.status!;
          operacao.message = resp.mensagem;
          operacao.result = resp.resultado;
        }
        if (operacao.message == null) {
          throw ('Não foi identificado resposta');
        }
      } else {
        operacao = await ApiRestStatusAnswerHTTP.AnswersHTTP(response.statusCode, response.body);
      }
    } catch (e) {
      operacao.erro = true;
      operacao.message = e.toString();
    }
    return operacao;
  }

  Future<Operation> OnVariaveisDeAmbiente() async {
    Operation operacao = Operation();
    try {
      String? token = await ComponentsJWTToken.JWTTokenPadrao();
      final response = await http
          .post(Uri.parse(Url + "/analise/Analise/recuperarVariaveisAmbiente_ws"),
              body: null,
              headers: {
                //"Content-type": "multipart/form-data",
                "token": token!,
              },
              encoding: Encoding.getByName("utf-8"))
          .timeout(const Duration(seconds: 10));
      operacao.erro = false;
      _Operacao.mensagem = "Operação realizada com sucesso";
      _Operacao.resultado = null;
      if (response.statusCode == 200) {
        if (!response.body.isNotEmpty) {
          throw (ApiRestInformation.problemOfComunication);
        }
        else
        {
          Map<String, dynamic> map = jsonDecode(Componentes.removeAllHtmlTags(response.body));
          OperationJson resp = VariaveisDeAmbiente.fromJson(map);
          operacao.erro = !resp.status!;
          operacao.message = resp.mensagem;
          operacao.result = resp.resultado;
        }
        if (operacao.message == null) {
          throw ('Não foi identificado resposta');
        }
      } else {
        operacao = await ApiRestStatusAnswerHTTP.AnswersHTTP(response.statusCode, response.body);
      }
    } catch (e) {
      operacao.erro = true;
      operacao.message = e.toString();
    }
    return operacao;
  }

  Future<Operation> OnRealizarLancamentosSici(TbFichaSici _Modelo) async {
    Operation operacao = Operation();
    try {
      print(_Modelo.toJson());
      String json = jsonEncode(_Modelo.toJson());
      String jsons = jsonEncode(_Modelo.distribuicaoFisicosServicoQuantitativo);
      var re = _Modelo.toJson();
      _Operacao.erro = false;
      _Operacao.mensagem = "Operação realizada com sucesso";
      _Operacao.resultado = null;
      String? token = await ComponentsJWTToken.JWTTokenPadrao();
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=utf-8',
        "token": token!,
      };
      http.MultipartRequest response;
      response = new http.MultipartRequest(
          'POST', Uri.parse(Url + "/analise/lancamento_ws"));
      response.headers.addAll(headers);
      response.fields['controllerPeriodoReferencia'] =
          (_Modelo.periodoReferencia == null ? "" : _Modelo.periodoReferencia)!;
      response.fields['controllerRazaoSocial'] =
          (_Modelo.razaoSocial == null ? "" : _Modelo.razaoSocial)!;

      response.fields['controllerTelefoneFixo'] = _Modelo.telefoneFixo == null ? "" : _Modelo.telefoneFixo!;
      response.fields['controllerCNPJ'] =
          _Modelo.cnpj == null ? "" : _Modelo.cnpj!;

      response.fields['controllerTelefoneCelular'] =
          _Modelo.telefoneMovel == null ? "" : _Modelo.telefoneMovel!;

      response.fields['controllerReceitaBruta'] =
          _Modelo.receitaBruta == null ? "" : _Modelo.receitaBruta!;
      response.fields['controllerAliqSimples'] =
          _Modelo.simples == null ? "" : _Modelo.simples!;
      response.fields['controllerAliqSimplesPorc'] =
          _Modelo.simplesPorc == null ? "" : _Modelo.simplesPorc!;
      response.fields['controllerICMS'] =
          _Modelo.icms == null ? "" : _Modelo.icms!;
      response.fields['controllerICMSPorc'] =
          _Modelo.icmsPorc == null ? "" : _Modelo.icmsPorc!;
      response.fields['controllerPIS'] = _Modelo.pis == null ? "" : _Modelo.pis!;
      response.fields['controllerPISPorc'] =
          _Modelo.pisPorc == null ? "" : _Modelo.pisPorc!;
      response.fields['controllerCOFINS'] =
          _Modelo.cofins == null ? "" : _Modelo.cofins!;
      response.fields['controllerCOFINSPorc'] =
          _Modelo.cofinsPorc == null ? "" : _Modelo.cofinsPorc!;
      response.fields['controllerReceitaLiquida'] =
          _Modelo.receitaLiquida == null ? "" : _Modelo.receitaLiquida!;
      response.fields['controllerObservacoes'] =
          _Modelo.observacoes == null ? "" : _Modelo.observacoes!;
      int index = 1;
      if (_Modelo.distribuicaoFisicosServicoQuantitativo == null)
        throw ("Distribuição do quantitativo de acessos físicos em serviço e obrigatório,favor adicionar.");
      for (var item in _Modelo.distribuicaoFisicosServicoQuantitativo!) {
        print('controllerUF_' + index.toString());
        response.fields['controllerCodIBGE_' + index.toString()] =
            item.cod_ibge.toString() == null ? "" : item.cod_ibge.toString();
        response.fields['controllerUF_' + index.toString()] =
            item.id_uf.toString() == null ? "" : item.id_uf.toString();
        response.fields['controllerMunicipio_' + index.toString()] =
            item.id_municipio.toString() == null
                ? ""
                : item.id_municipio.toString();
        response.fields['controllerTecnologia_' + index.toString()] =
            item.id_tecnologia.toString() == null
                ? ""
                : item.id_tecnologia.toString();
        response.fields['controllerCodIBGE_' + index.toString()] =
            item.cod_ibge == null ? "" : item.cod_ibge!;
        response.fields['controllerPF0_' + index.toString()] =
            item.pf_0 == null ? "" : item.pf_0!;
        response.fields['controllerPF512_' + index.toString()] =
            item.pf_512 == null ? "" : item.pf_512!;
        response.fields['controllerPF2_' + index.toString()] =
            item.pf_2 == null ? "" : item.pf_2!;
        response.fields['controllerPF12_' + index.toString()] =
            item.pf_12 == null ? "" : item.pf_12!;
        response.fields['controllerPF34_' + index.toString()] =
            item.pf_34 == null ? "" : item.pf_34!;
        response.fields['controllerPJ0_' + index.toString()] =
            item.pj_0 == null ? "" : item.pj_0!;
        response.fields['controllerPJ512_' + index.toString()] =
            item.pj_512 == null ? "" : item.pj_512!;
        response.fields['controllerPJ2_' + index.toString()] =
            item.pj_2 == null ? "" : item.pj_2!;
        response.fields['controllerPJ12_' + index.toString()] =
            item.pj_12 == null ? "" : item.pj_12!;
        response.fields['controllerPJ34_' + index.toString()] =
            item.pj_34 == null ? "" : item.pj_34!;
        index++;
      }
      var streamedResponse = await response.send();
      final respStr = await streamedResponse.stream.bytesToString();
      var jsonResp = Componentes.removeAllHtmlTags(respStr);
      if (response.statusCode == 200) {
        if (!response.body.isNotEmpty) {
          throw (ApiRestInformation.problemOfComunication);
        }
        else
        {
          Map<String, dynamic> map = jsonDecode(Componentes.removeAllHtmlTags(response.body));
          OperationJson resp = OperationJson.fromJson(map);
          operacao.erro = !resp.status!;
          operacao.message = resp.mensagem;
          operacao.result = resp.resultado;
        }
        if (operacao.message == null) {
          throw ('Não foi identificado resposta');
        }
      } else {
        operacao = await ApiRestStatusAnswerHTTP.AnswersHTTP(response.statusCode, response.body);
      }
    } catch (e) {
      operacao.erro = true;
      operacao.message = e.toString();
    }
    return operacao;
  }

  Future<Operation> OnRecuperaLancamentosSici() async {
    Operation operacao = Operation();
    try {
      String? token = await ComponentsJWTToken.JWTTokenPadrao();
      final response = await http.post(Uri.parse(Url + "/analise/recuperar_ws"),
              body: null,
              headers: {
                //"Content-type": "multipart/form-data",
                "token": token!,
              },
              encoding: Encoding.getByName("utf-8"))
          .timeout(const Duration(seconds: 10));
      _Operacao.erro = false;
      _Operacao.mensagem = "Operação realizada com sucesso";
      _Operacao.resultado = null;
      print(response.body);
      if (response.statusCode == 200) {
        if (!response.body.isNotEmpty) {
          throw (ApiRestInformation.problemOfComunication);
        }
        else
        {
          Map<String, dynamic> map = jsonDecode(Componentes.removeAllHtmlTags(response.body));
          OperationJson resp = OperationJson.fromJson(map);
          operacao.erro = !resp.status!;
          operacao.message = resp.mensagem;
          operacao.result = resp.resultado;
        }
        if (operacao.message == null) {
          throw ('Não foi identificado resposta');
        }
      } else {
        operacao = await ApiRestStatusAnswerHTTP.AnswersHTTP(response.statusCode, response.body);
      }
    } catch (e) {
      operacao.erro = true;
      operacao.message = e.toString();
    }
    return operacao;
  }

  Future<Operation> OnCadastraUsuario(ModelDadosUsuarioJson _Modelo) async {
    Operation operacao = Operation();
    try {
      String? token = await ComponentsJWTToken.JWTTokenPadrao();
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=utf-8',
        "token": token!,
      };
      http.MultipartRequest response;
      response = new http.MultipartRequest(
          'POST', Uri.parse(Url + "/usuario/inserir_usuario_ws"));
      response.headers.addAll(headers);
      response.fields['controllerNome'] = _Modelo.nome!;
      response.fields['controllerCPF'] = _Modelo.cpf!;
      response.fields['controllerEmail'] = _Modelo.email!;
      response.fields['controllerTelefone'] = _Modelo.telefone!;
      response.fields['controllerTelefoneWhatsapp'] = _Modelo.telefoneWhatsapp!;
      response.fields['controllerEmpresa'] = _Modelo.empresa!;
      response.fields['controllerUF'] = _Modelo.uf!;
      var streamedResponse = await response.send();
      final respStr = await streamedResponse.stream.bytesToString();
      var jsonResp = Componentes.removeAllHtmlTags(respStr);
      if (response.statusCode == 200) {
        if (!response.body.isNotEmpty) {
          throw (ApiRestInformation.problemOfComunication);
        }
        else
        {
          Map<String, dynamic> map = jsonDecode(Componentes.removeAllHtmlTags(response.body));
          OperationJson resp = OperationJson.fromJson(map);
          operacao.erro = !resp.status!;
          operacao.message = resp.mensagem;
          operacao.result = resp.resultado;
        }
        if (operacao.message == null) {
          throw ('Não foi identificado resposta');
        }
      } else {
        operacao = await ApiRestStatusAnswerHTTP.AnswersHTTP(response.statusCode, response.body);
      }
    } catch (e) {
      operacao.erro = true;
      operacao.message = e.toString();
    }
    return operacao;
  }

  static Future<Operation> onRecuperaNotificacaoPeloId(String IdNotificacao) async {
    Operation operacao = Operation();
    try {
      String? token = await ComponentsJWTToken.JWTTokenPadrao();
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=utf-8',
        "token": token!,
      };
      http.MultipartRequest response;
      response = new http.MultipartRequest('POST', Uri.parse(Url + "/notificacoes/Notificacoes_ws/recuperarNotificacao_ws"));
      response.headers.addAll(headers);
      response.fields['id'] = IdNotificacao;
      var streamedResponse = await response.send();
      final respStr = await streamedResponse.stream.bytesToString();
      var jsonResp = Componentes.removeAllHtmlTags(respStr);

      if (response.statusCode == 200) {
        if (!response.body.isNotEmpty) {
          throw (ApiRestInformation.problemOfComunication);
        }
        else
        {
          Map<String, dynamic> map = jsonDecode(Componentes.removeAllHtmlTags(response.body));
          OperationJson resp = OperationJson.fromJson(map);
          operacao.erro = !resp.status!;
          operacao.message = resp.mensagem;
          operacao.result = resp.resultado;
        }
        if (operacao.message == null) {
          throw ('Não foi identificado resposta');
        }
      } else {
        operacao = await ApiRestStatusAnswerHTTP.AnswersHTTP(response.statusCode, response.body);
      }
    } catch (e) {
      operacao.erro = true;
      operacao.message = e.toString();
    }
    return operacao;
  }

  Future<Operation> OnRecuperaNotificacoesPeloId(String IdNotificacao) async {
    Operation operacao = Operation();
    try {
      String? token = await ComponentsJWTToken.JWTTokenPadrao();
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=utf-8',
        "token": token!,
      };
      http.MultipartRequest response;
      response = new http.MultipartRequest('POST', Uri.parse(Url + "/notificacoes/Notificacoes_ws/recuperarNotificacao_ws"));
      response.headers.addAll(headers);
      response.fields['id'] = IdNotificacao;
      var streamedResponse = await response.send();
      final respStr = await streamedResponse.stream.bytesToString();
      var jsonResp = Componentes.removeAllHtmlTags(respStr);
      if (response.statusCode == 200) {
        if (!response.body.isNotEmpty) {
          throw (ApiRestInformation.problemOfComunication);
        }
        else
        {
          Map<String, dynamic> map = jsonDecode(Componentes.removeAllHtmlTags(response.body));
          OperationJson resp = OperationJson.fromJson(map);
          operacao.erro = !resp.status!;
          operacao.message = resp.mensagem;
          operacao.result = resp.resultado;
        }
        if (operacao.message == null) {
          throw ('Não foi identificado resposta');
        }
      } else {
        operacao = await ApiRestStatusAnswerHTTP.AnswersHTTP(response.statusCode, response.body);
      }
    } catch (e) {
      operacao.erro = true;
      operacao.message = e.toString();
    }
    return operacao;
  }

 static Future<Operation> onGetListNotificationByCpf(String cpf) async {
    Operation operacao = Operation();
    try {
      String? token = await ComponentsJWTToken.JWTTokenPadrao();
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=utf-8',
        "token": token!,
      };
      http.MultipartRequest response;
      response = http.MultipartRequest('POST', Uri.parse(Url + "/notificacoes/recuperarTodasNotificacaoByCpf_ws"));
      response.headers.addAll(headers);
      response.fields['cpf'] = cpf;
      var streamedResponse = await response.send();
      final respStr = await streamedResponse.stream.bytesToString();
      var jsonResp = Componentes.removeAllHtmlTags(respStr);
      operacao.statusCode = response.statusCode;
      if (response.statusCode == 200) {
        if (!response.body.isNotEmpty) {
          throw (ApiRestInformation.problemOfComunication);
        }
        else
        {
          Map<String, dynamic> map = jsonDecode(Componentes.removeAllHtmlTags(response.body));
          OperationJson resp = OperationJson.fromJson(map);
          operacao.erro = !resp.status!;
          operacao.message = resp.mensagem;
          operacao.result = resp.resultado;
        }
        if (operacao.message == null) {
          throw ('Não foi identificado resposta');
        }
      } else {
        operacao = await ApiRestStatusAnswerHTTP.AnswersHTTP(response.statusCode, response.body);
      }
    } catch (e) {
      operacao.erro = true;
      operacao.message = e.toString();
    }
    return operacao;
  }
}

class ApiRestInformation {
  static String problemOfComunication = 'Houve um problema de comunicação com os servidores da scmengenharia';
  static String internetSocketException = 'Verifique sua conexão com a internet e tente novamente';
  static String httpException = 'Não foi possível encontrar a postagem';
  static String formatException = 'Formato de resposta ruim 👎';

  static Map<String, String> onHeaders() {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Access-Control-Allow-Methods': '*',
      'Access-Control-Allow-Origin': 'http://localhost:59817',
      'Access-Control-Allow-Headers': '*'
    };
    return headers;
  }

  static Map<String, String> onHeadersToken(String token) {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Access-Control-Allow-Methods': '*',
      'Access-Control-Allow-Origin': 'http://localhost:59817',
      'Access-Control-Allow-Headers': '*',
      'Authorization': 'Bearer $token',
    };
    return headers;
  }
}

class ApiRestStatusAnswerHTTP {
  static Future<Operation> AnswersHTTP(int statusCode, String body) async {
    Operation operation =  Operation();
    switch (statusCode) {
    //Erro do cliente
      case 400:
        {
          operation.erro = true;
          operation.message =
          'O servidor não pode ou não processará a solicitação';
          operation.result = null;
          operation.statusCode = 400;
        }
        break;
      case 409:
        {
          operation.erro = true;
          operation.message = 'O servidor não pode ou não processará a solicitação';
          operation.result = null;
          operation.statusCode = 409;
          try {

          } catch (error) {
            print(error);
          }
        }
        break;
    //Respostas de erro do Servidor
      case 500:
        {
          operation.erro = true;
          operation.message =
          'O servidor encontrou uma condição inesperada que o impediu de atender à solicitação.  (ERRO DO SERVIDOR)';
          operation.result = null;
          operation.statusCode = 500;
          try {
           // Map<String, dynamic> map = jsonDecode(body);
           // Erro500 resp = Erro500.fromJson(map);
           // operacao.mensagem = resp.message;
          } catch (error) {
            operation.mensagem = error.toString();
          }
        }
        break;
      case 501:
        {
          operation.erro = true;
          operation.message =
          'O servidor não oferece suporte à funcionalidade necessária para atender à solicitação. (ERRO DO SERVIDOR)';
          operation.result = null;
          operation.statusCode = 501;
        }
        break;
      case 502:
        {
          operation.erro = true;
          operation.message =
          'O servidor, ao atuar como gateway ou proxy, recebeu uma resposta inválida. (ERRO DO SERVIDOR)'; //BAD GATEWAY
          operation.result = null;
          operation.statusCode = 502;
        }
        break;
      case 503:
        {
          operation.erro = true;
          operation.message =
          'No momento, o servidor não pode atender à solicitação devido a uma sobrecarga temporária ou manutenção programada. (ERRO DO SERVIDOR)'; //SERVIÇO INDISPONÍVEL
          operation.result = null;
          operation.statusCode = 503;
        }
        break;
      case 504:
        {
          operation.erro = true;
          operation.message =
          'O servidor, ao atuar como gateway ou proxy, não recebeu uma resposta oportuna. (ERRO DO SERVIDOR)'; //GATEWAY TIMEOUT
          operation.result = null;
          operation.statusCode = 504;
        }
        break;
      case 505:
        {
          operation.erro = true;
          operation.message =
          'O servidor não oferece suporte ou se recusa a oferecer suporte à versão principal de HTTP. (ERRO DO SERVIDOR)'; //VERSÃO HTTP NÃO SUPORTADA
          operation.result = null;
          operation.statusCode = 505;
        }
        break;
      case 506:
        {
          operation.erro = true;
          operation.message =
          'O servidor tem um erro de configuração interno. (ERRO DO SERVIDOR)';
          operation.result = null;
          operation.statusCode = 506;
        }
        break;
      case 507:
        {
          operation.erro = true;
          operation.message =
          'O método não pôde ser executado no recurso porque o servidor não pode armazenar a representação necessária para concluir a solicitação com êxito. (ERRO DO SERVIDOR)'; //ARMAZENAMENTO INSUFICIENTE
          operation.result = null;
          operation.statusCode = 507;
        }
        break;
      case 508:
        {
          operation.erro = true;
          operation.message =
          'O servidor encerrou uma operação porque encontrou um loop infinito ao processar uma solicitação. (ERRO DO SERVIDOR)'; //LOOP DETECTADO
          operation.result = null;
          operation.statusCode = 508;
        }
        break;
      case 510:
        {
          operation.erro = true;
          operation.message =
          'A política de acesso ao recurso não foi atendida na solicitação. (ERRO DO SERVIDOR)'; //NÃO ESTENDIDO
          operation.result = null;
          operation.statusCode = 510;
        }
        break;
      case 511:
        {
          operation.erro = true;
          operation.message =
          'É preciso se autenticar para obter acesso à rede. (ERRO DO SERVIDOR)'; // AUTENTICAÇÃO DE REDE NECESSÁRIA
          operation.result = null;
          operation.statusCode = 511;
        }
        break;
      case 599:
        {
          operation.erro = true;
          operation.message =
          'Erro de tempo limite de conexão de rede. (ERRO DO SERVIDOR)'; //ERRO DE TEMPO LIMITE DE CONEXÃO DA REDE
          operation.result = null;
          operation.statusCode = 599;
        }
        break;
      default:
        {
          operation.erro = true;
          operation.message = 'Não foi possível realizar a operação';
          operation.statusCode = statusCode;
        }
        break;
    }
    return operation;
  }
}
