import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scm_engenharia_app/data/tb_usuario.dart';
import 'package:scm_engenharia_app/help/components.dart';
import 'package:scm_engenharia_app/models/model_formulario_sici_fust.dart';
import 'package:scm_engenharia_app/models/model_usuario.dart';
import 'package:scm_engenharia_app/models/operacao.dart';
import 'package:scm_engenharia_app/models/variaveis_de_ambiente.dart';

class ServicoMobileService {
  static final Url = "http://sici.scmengenharia.com.br";

  Future<Operacao> OnLogin(ModelLoginJson _Modelo) async {
    Operacao _Operacao = new Operacao();
    try {
      print(json.encode(_Modelo.toJson()));
      final response = await http.post(Url + "/login_ws",
          headers: {
            "Content-type": "multipart/form-data",
            "token": Components.JWTToken(_Modelo.usuario,_Modelo.password),
          },
          encoding: Encoding.getByName("utf-8")).timeout(const Duration(seconds: 10));
      _Operacao.erro = false;
      _Operacao.mensagem = "Operação realizada com sucesso";
      _Operacao.resultado = null;
      switch (response.statusCode) {
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
            if (response.body.isEmpty)
              throw ("Houve um problema de comunicação com os servidores do SCM");
            Map<String, dynamic> map = jsonDecode( Components.removeAllHtmlTags(response.body));
            OperacaoJson _Resp = OperacaoJson.fromJson(map);
            _Operacao.erro = !_Resp.status;
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
      final response = await http.post(Url + "/analise/Analise/recuperarVariaveisAmbiente_ws",
          body: null,
          headers: {
            "Content-type": "multipart/form-data",
            "token": Components.JWTTokenPadrao(),
          },
          encoding: Encoding.getByName("utf-8")).timeout(const Duration(seconds: 10));
      _Operacao.erro = false;
      _Operacao.mensagem = "Operação realizada com sucesso";
      _Operacao.resultado = null;
      switch (response.statusCode) {
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
          if (!response.body.isNotEmpty)
            throw ("Houve um problema de comunicação com os servidores do SCM");
          Map<String, dynamic> map = jsonDecode(response.body);
          VariaveisDeAmbiente _Resp = VariaveisDeAmbiente.fromJson(map);
          _Operacao.erro = !_Resp.status;
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

  Future<Operacao> OnRealizarLancamentosSici (ModelFormularioSiciFustJson _Modelo) async {
    Operacao _Operacao = new Operacao();
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=utf-8',
        "token": Components.JWTTokenPadrao(),
      };
      http.MultipartRequest response;
      response = new http.MultipartRequest(
          'POST', Uri.parse(Url + "/analise/lancamento_ws"));
      response.headers.addAll(headers);
      response.fields['controllerPeriodoReferencia'] =  _Modelo.periodo_referencia;
      response.fields['controllerRazaoSocial'] = _Modelo.razao_social;
      response.fields['controllerResponsavelPreenchimento'] = _Modelo.nome_responsavel_preenchimento;
      response.fields['controllerTelefoneFixo'] = _Modelo.telefone_fixo;
      response.fields['controllerCNPJ'] = _Modelo.cnpj;
      response.fields['controllerMesReferencia'] = _Modelo.mes_referencia;
      response.fields['controllerTelefoneCelular'] = _Modelo.telefone_celular;

      response.fields['controllerEmailCliente'] = _Modelo.email_cliente;
      response.fields['controllerEmailConsultor'] = _Modelo.email_consutor;
      response.fields['controllerReceitaBruta'] = _Modelo.receita_bruta;
      response.fields['controllerAliqSimples'] = _Modelo.simples;
      response.fields['controllerAliqSimplesPorc'] = _Modelo.simplesPorc;
      response.fields['controllerICMS'] = _Modelo.icms;
      response.fields['controllerICMSPorc'] = _Modelo.icmsPorc;
      response.fields['controllerPIS'] = _Modelo.pis;
      response.fields['controllerPISPorc'] = _Modelo.pisPorc;
      response.fields['controllerCOFINS'] = _Modelo.cofins;
      response.fields['controllerCOFINSPorc'] = _Modelo.cofinsPorc;
      response.fields['controllerReceitaLiquida'] = _Modelo.receita_liquida;
      response.fields['controllerObservacoes'] = _Modelo.observacoes;
      int index =  1;
      for (var item in _Modelo.distribuicaoFisicosServicoQuantitativo) {
        print('controllerUF_'+index.toString());
        response.fields['controllerCodIBGE_'+index.toString()] = item.codIbge.toString();
        response.fields['controllerUF_'+index.toString()] = item.idUf.toString();
        response.fields['controllerMunicipio_'+index.toString()] = item.idMunicipio.toString();
        response.fields['controllerTecnologia_'+index.toString()] = item.idTecnologia.toString();
        response.fields['controllerCodIBGE_'+index.toString()] = item.codIbge;
        response.fields['controllerPF0_'+index.toString()] = item.pf0;
        response.fields['controllerPF512_'+index.toString()] = item.pf512;
        response.fields['controllerPF2_'+index.toString()] = item.pf2;
        response.fields['controllerPF12_'+index.toString()] = item.pf12;
        response.fields['controllerPF34_'+index.toString()] = item.pf34;
        response.fields['controllerPJ0_'+index.toString()] = item.pj0;
        response.fields['controllerPJ512_'+index.toString()] = item.pj512;
        response.fields['controllerPJ2_'+index.toString()] = item.pj2;
        response.fields['controllerPJ12_'+index.toString()] = item.pj12;
        response.fields['controllerPJ34_'+index.toString()] = item.pj34;
        index++;
        print(_Modelo.distribuicaoFisicosServicoQuantitativo);
      }
      var streamedResponse = await response.send();
      final respStr = await streamedResponse.stream.bytesToString();
      var jsonResp = Components.removeAllHtmlTags(respStr);
      switch (streamedResponse.statusCode) {
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
            _Operacao.erro = !_Resp.status;
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

  Future<Operacao> OnRecuperaLancamentosSici(TbUsuario UsuarioLogado) async {
    Operacao _Operacao = new Operacao();
    try {
      final response = await http.post(Url + "/analise/recuperar_ws",
          body: null,
          headers: {
            "Content-type": "multipart/form-data",
            "token": Components.JWTTokenPadrao(),
          },
          encoding: Encoding.getByName("utf-8")).timeout(const Duration(seconds: 10));
      _Operacao.erro = false;
      _Operacao.mensagem = "Operação realizada com sucesso";
      _Operacao.resultado = null;
      print(response.body);
      switch (response.statusCode) {
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
          if (!response.body.isNotEmpty)
            throw ("Houve um problema de comunicação com os servidores do SCM");
          Map<String, dynamic> map = jsonDecode(response.body);
          VariaveisDeAmbiente _Resp = VariaveisDeAmbiente.fromJson(map);
          _Operacao.erro = !_Resp.status;
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
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=utf-8',
        "token": Components.JWTTokenPadrao(),
      };
      http.MultipartRequest response;
      response = new http.MultipartRequest(
          'POST', Uri.parse(Url + "/usuario/inserir_usuario_ws"));
      response.headers.addAll(headers);
      response.fields['controllerNome'] = _Modelo.nome;
      response.fields['controllerCPF'] = _Modelo.uf;
      response.fields['controllerEmail'] = _Modelo.email;
      response.fields['controllerTelefone'] = _Modelo.telefone;
      response.fields['controllerTelefoneWhatsapp'] = _Modelo.telefoneWhatsapp;
      response.fields['controllerEmpresa'] = _Modelo.empresa;
      response.fields['controllerUF'] = _Modelo.uf;
      var streamedResponse = await response.send();
      final respStr = await streamedResponse.stream.bytesToString();
      var jsonResp = Components.removeAllHtmlTags(respStr);
      switch (streamedResponse.statusCode) {
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
             _Operacao.erro = !_Resp.status;
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
