import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scm_engenharia_app/data/JWTTokenDbLocal.dart';
import 'package:scm_engenharia_app/data/tb_ficha_sici.dart';
import 'package:scm_engenharia_app/help/components.dart';
import 'package:scm_engenharia_app/models/model_usuario.dart';
import 'package:scm_engenharia_app/models/operacao.dart';
import 'package:scm_engenharia_app/models/variaveis_de_ambiente.dart';

class ServicoMobileService {
  static final Url = "http://dici.scmengenharia.com.br";
  //static final Url = "http://10.0.2.2:8083";
  //static final Url = "http://192.168.0.122:8083";
  //static final Url = "http://wsscm.ddns.net";

  Future<Operacao> OnLogin(ModelLoginJson _Modelo) async {
    Operacao _Operacao = new Operacao();
    try {
      String? token = await Components.JWTToken(_Modelo.usuario.toString(), _Modelo.password!);
      final response = await http
          .post(Uri.parse(Url + "/login_ws"),
              headers: {
                //"Content-type": "multipart/form-data",
                "token": token!,
              },
              encoding: Encoding.getByName("utf-8"))
          .timeout(const Duration(seconds: 10));
      _Operacao.erro = false;
      _Operacao.mensagem = "Operação realizada com sucesso";
      _Operacao.resultado = null;
      switch (response.statusCode) {
        case 500:
          {
            _Operacao.erro = true;
            _Operacao.mensagem = "Erro 500 – Erro Interno do Servidor";
            _Operacao.resultado = null;
          }
          break;
        case 400:
          {
            _Operacao.mensagem = "Solicitação inválida";
            _Operacao.resultado = null;
          }
          break;
        case 401:
          {
            _Operacao.mensagem = "Token inválido";
            _Operacao.resultado = null;
          }
          break;
        case 403:
        case 200:
          {
            print(jsonDecode(Components.removeAllHtmlTags(response.body)));
            if (response.body.isEmpty)
              throw ("Houve um problema de comunicação com os servidores do SCM");
            Map<String, dynamic> map = jsonDecode(Components.removeAllHtmlTags(response.body));
            OperacaoJson _Resp = OperacaoJson.fromJson(map);
            _Operacao.erro = !_Resp.status!;
            _Operacao.mensagem = _Resp.mensagem;
            _Operacao.resultado = _Resp.resultado;
            return _Operacao;
          }
          break;
        default:
          {
            _Operacao.erro = true;
            _Operacao.mensagem = "Não foi possível realizar a operação";
          }
          break;
      }
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> OnAlterarSenha(String _Senha) async {
    Operacao _Operacao = new Operacao();
    try {
      String? token = await ComponentsJWTToken.JWTTokenPadrao();
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=utf-8',
        "token": token!,
      };
      http.MultipartRequest response;
      response = new http.MultipartRequest(
          'POST', Uri.parse(Url + "/usuario/alterar_senha_ws"));
      response.headers.addAll(headers);
      response.fields['nova_senha'] = _Senha;
      var streamedResponse = await response.send();
      final respStr = await streamedResponse.stream.bytesToString();
      var jsonResp = Components.removeAllHtmlTags(respStr);
      switch (streamedResponse.statusCode) {
        case 500:
          {
            _Operacao.erro = true;
            _Operacao.mensagem = "Erro 500 – Erro Interno do Servidor";
            _Operacao.resultado = null;
          }
          break;
        case 400:
          {
            _Operacao.mensagem = "Solicitação inválida";
            _Operacao.resultado = null;
          }
          break;
        case 401:
          {
            _Operacao.mensagem = "Token inválido";
            _Operacao.resultado = null;
          }
          break;
        case 200:
          {
            if (jsonResp.isEmpty)
              throw ("Houve um problema de comunicação com os servidores do SCM");
            print(jsonResp);
            Map<String, dynamic> map = jsonDecode(jsonResp);
            OperacaoJson _Resp = OperacaoJson.fromJson(map);
            _Operacao.erro = !_Resp.status!;
            _Operacao.mensagem = _Resp.mensagem;
            _Operacao.resultado = _Resp.resultado;
            return _Operacao;
          }
          break;
        default:
          {
            _Operacao.erro = true;
            _Operacao.mensagem = "Não foi possível realizar a operação";
          }
          break;
      }
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> OnVariaveisDeAmbiente() async {
    Operacao _Operacao = new Operacao();
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
      _Operacao.erro = false;
      _Operacao.mensagem = "Operação realizada com sucesso";
      _Operacao.resultado = null;
      switch (response.statusCode) {
        case 500:
          {
            _Operacao.erro = true;
            _Operacao.mensagem = "Erro 500 – Erro Interno do Servidor";
            _Operacao.resultado = null;
          }
          break;
        case 400:
          {
            _Operacao.mensagem = "Solicitação inválida";
            _Operacao.resultado = null;
          }
          break;
        case 401:
          {
            _Operacao.mensagem = "Token inválido";
            _Operacao.resultado = null;
          }
          break;
        case 403:
        case 200:
          if (!response.body.isNotEmpty)
            throw ("Houve um problema de comunicação com os servidores do SCM");
          Map<String, dynamic> map = jsonDecode(response.body);
          VariaveisDeAmbiente _Resp = VariaveisDeAmbiente.fromJson(map);
          _Operacao.erro = !_Resp.status!;
          _Operacao.mensagem = _Resp.mensagem;
          _Operacao.resultado = _Resp.resultado;
          break;
        default:
          {
            _Operacao.erro = true;
            _Operacao.mensagem = "Não foi possível realizar a operação";
          }
          break;
      }
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> OnRealizarLancamentosSici(TbFichaSici _Modelo) async {
    Operacao _Operacao = new Operacao();
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
      var jsonResp = Components.removeAllHtmlTags(respStr);
      switch (streamedResponse.statusCode) {
        case 500:
          {
            _Operacao.erro = true;
            _Operacao.mensagem = "Erro 500 – Erro Interno do Servidor";
            _Operacao.resultado = null;
          }
          break;
        case 400:
          {
            _Operacao.mensagem = "Solicitação inválida";
            _Operacao.resultado = null;
          }
          break;
        case 401:
          {
            _Operacao.mensagem = "Token inválido";
            _Operacao.resultado = null;
          }
          break;
        case 200:
          {
            if (jsonResp.isEmpty)
              throw ("Houve um problema de comunicação com os servidores do SCM");
            Map<String, dynamic> map = jsonDecode(jsonResp);
            OperacaoJson _Resp = OperacaoJson.fromJson(map);
            _Operacao.erro = !_Resp.status!;
            _Operacao.mensagem = _Resp.mensagem;
            _Operacao.resultado = _Resp.resultado;
            return _Operacao;
          }
          break;
        default:
          {
            _Operacao.erro = true;
            _Operacao.mensagem = "Não foi possível realizar a operação";
          }
          break;
      }
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> OnRecuperaLancamentosSici() async {
    Operacao _Operacao = new Operacao();
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
      switch (response.statusCode) {
        case 500:
          {
            _Operacao.erro = true;
            _Operacao.mensagem = "Erro 500 – Erro Interno do Servidor";
            _Operacao.resultado = null;
          }
          break;
        case 400:
          {
            _Operacao.mensagem = "Solicitação inválida";
            _Operacao.resultado = null;
          }
          break;
        case 401:
          {
            _Operacao.mensagem = "Token inválido";
            _Operacao.resultado = null;
          }
          break;
        case 403:
          {
            _Operacao.mensagem = "Token inválido";
            _Operacao.resultado = null;
          }
          break;
        case 200:
          if (!response.body.isNotEmpty)
            throw ("Houve um problema de comunicação com os servidores do SCM");
          Map<String, dynamic> map = jsonDecode(response.body);
          OperacaoJson _Resp = OperacaoJson.fromJson(map);
          _Operacao.erro = !_Resp.status!;
          _Operacao.mensagem = _Resp.mensagem;
          _Operacao.resultado = _Resp.resultado;
          break;
        default:
          {
            _Operacao.erro = true;
            _Operacao.mensagem = "Não foi possível realizar a operação";
          }
          break;
      }
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> OnCadastraUsuario(ModelDadosUsuarioJson _Modelo) async {
    Operacao _Operacao = new Operacao();
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
      var jsonResp = Components.removeAllHtmlTags(respStr);
      switch (streamedResponse.statusCode) {
        case 500:
          {
            _Operacao.erro = true;
            _Operacao.mensagem = "Erro 500 – Erro Interno do Servidor";
            _Operacao.resultado = null;
          }
          break;
        case 400:
          {
            _Operacao.mensagem = "Solicitação inválida";
            _Operacao.resultado = null;
          }
          break;
        case 401:
          {
            _Operacao.mensagem = "Token inválido";
            _Operacao.resultado = null;
          }
          break;
        case 200:
          {
            if (jsonResp.isEmpty)
              throw ("Houve um problema de comunicação com os servidores do SCM");
            Map<String, dynamic> map = jsonDecode(jsonResp);
            OperacaoJson _Resp = OperacaoJson.fromJson(map);
            _Operacao.erro = !_Resp.status!;
            _Operacao.mensagem = _Resp.mensagem;
            _Operacao.resultado = _Resp.resultado;
            return _Operacao;
          }
          break;
        default:
          {
            _Operacao.erro = true;
            _Operacao.mensagem = "Não foi possível realizar a operação";
          }
          break;
      }
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> OnRecuperaNotificacaoPeloId(String IdNotificacao) async {
    Operacao _Operacao = new Operacao();
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
      var jsonResp = Components.removeAllHtmlTags(respStr);
      switch (streamedResponse.statusCode) {
        case 500:
          {
            _Operacao.erro = true;
            _Operacao.mensagem = "Erro 500 – Erro Interno do Servidor";
            _Operacao.resultado = null;
          }
          break;
        case 400:
          {
            _Operacao.mensagem = "Solicitação inválida";
            _Operacao.resultado = null;
          }
          break;
        case 401:
          {
            _Operacao.mensagem = "Token inválido";
            _Operacao.resultado = null;
          }
          break;
        case 200:
          {
            if (jsonResp.isEmpty)
              throw ("Houve um problema de comunicação com os servidores do SCM");
            print(jsonResp);
            Map<String, dynamic> map = jsonDecode(jsonResp);
            OperacaoJson _Resp = OperacaoJson.fromJson(map);
            _Operacao.erro = !_Resp.status!;
            _Operacao.mensagem = _Resp.mensagem;
            _Operacao.resultado = _Resp.resultado;
            return _Operacao;
          }
          break;
        default:
          {
            _Operacao.erro = true;
            _Operacao.mensagem = "Não foi possível realizar a operação";
          }
          break;
      }
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> OnRecuperaNotificacoesPeloId(String IdNotificacao) async {
    Operacao _Operacao = new Operacao();
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
      var jsonResp = Components.removeAllHtmlTags(respStr);
      switch (streamedResponse.statusCode) {
        case 500:
          {
            _Operacao.erro = true;
            _Operacao.mensagem = "Erro 500 – Erro Interno do Servidor";
            _Operacao.resultado = null;
          }
          break;
        case 400:
          {
            _Operacao.mensagem = "Solicitação inválida";
            _Operacao.resultado = null;
          }
          break;
        case 401:
          {
            _Operacao.mensagem = "Token inválido";
            _Operacao.resultado = null;
          }
          break;
        case 200:
          {
            if (jsonResp.isEmpty)
              throw ("Houve um problema de comunicação com os servidores do SCM");
            print(jsonResp);
            Map<String, dynamic> map = jsonDecode(jsonResp);
            OperacaoJson _Resp = OperacaoJson.fromJson(map);
            _Operacao.erro = !_Resp.status!;
            _Operacao.mensagem = _Resp.mensagem;
            _Operacao.resultado = _Resp.resultado;
            return _Operacao;
          }
          break;
        default:
          {
            _Operacao.erro = true;
            _Operacao.mensagem = "Não foi possível realizar a operação";
          }
          break;
      }
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }

  Future<Operacao> OnNotificacoesPeloCPF(String cpf) async {
    Operacao _Operacao = new Operacao();
    try {
      String? token = await ComponentsJWTToken.JWTTokenPadrao();
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=utf-8',
        "token": token!,
      };
      http.MultipartRequest response;
      response = new http.MultipartRequest('POST', Uri.parse(Url + "/notificacoes/recuperarTodasNotificacaoByCpf_ws"
          ""));
      response.headers.addAll(headers);
      response.fields['cpf'] = cpf;
      var streamedResponse = await response.send();
      final respStr = await streamedResponse.stream.bytesToString();
      var jsonResp = Components.removeAllHtmlTags(respStr);
      switch (streamedResponse.statusCode) {
        case 500:
          {
            _Operacao.erro = true;
            _Operacao.mensagem = "Erro 500 – Erro Interno do Servidor";
            _Operacao.resultado = null;
          }
          break;
        case 400:
          {
            _Operacao.mensagem = "Solicitação inválida";
            _Operacao.resultado = null;
          }
          break;
        case 401:
          {
            _Operacao.mensagem = "Token inválido";
            _Operacao.resultado = null;
          }
          break;
        case 200:
          {
            if (jsonResp.isEmpty)
              throw ("Houve um problema de comunicação com os servidores do SCM");
            print(jsonResp);
            Map<String, dynamic> map = jsonDecode(jsonResp);
            OperacaoJson _Resp = OperacaoJson.fromJson(map);
            _Operacao.erro = !_Resp.status!;
            _Operacao.mensagem = _Resp.mensagem;
            _Operacao.resultado = _Resp.resultado;
            return _Operacao;
          }
          break;
        default:
          {
            _Operacao.erro = true;
            _Operacao.mensagem = "Não foi possível realizar a operação";
          }
          break;
      }
    } catch (e) {
      _Operacao.erro = true;
      _Operacao.mensagem = e.toString();
    }
    return _Operacao;
  }
}
