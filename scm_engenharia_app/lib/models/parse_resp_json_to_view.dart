import 'dart:convert';

import 'package:intl/intl.dart';

import '../data/tb_form_sici_fust.dart';
import 'input/input_sici_fust_form_model.dart';
import 'output/output_sici_fust_model.dart';

class ParseRespJsonToView{

  static Future<List<InputSiciFileModel>> parseSiciFustFormModelToSiciFileList(List<OutputSiciFustFormModel>  siciFustFormModel) async{
    try {
      List<InputSiciFileModel> respSiciFileModel = <InputSiciFileModel>[];
      for (var prop in siciFustFormModel) {
        InputSiciFileModel addprop = InputSiciFileModel();
        addprop.idFichaSiciApp = '';
        addprop.idEmpresa = prop.idEmpresa;
        addprop.id = prop.id;
        addprop.idUsuarioConsultor = prop.idUsuarioConsultor;
        addprop.idUsuarioCliente = prop.idUsuarioCliente;
        if (prop.periodoReferencia!.isNotEmpty) {
          DateTime  selectedDate = DateTime.parse(prop.periodoReferencia!);
          addprop.periodoReferencia = DateFormat("dd/MM/yyyy").format(selectedDate);
        }
        addprop.razaoSocial = prop.razaoSocial;
        addprop.telefoneFixo = prop.telefoneFixo;
        addprop.cnpj = prop.cnpj;
        addprop.telefoneMovel = prop.telefoneMovel;
        addprop.receitaBruta = prop.receitaBruta;
        //ModelFichaSici.idFinanceiro  = prop.idFinanceiro; Não tem
        addprop.simples = prop.simples;
        addprop.simplesPorc = prop.simplesPorc;
        addprop.icms = prop.icms;
        addprop.icmsPorc = prop.icmsPorc;
        addprop.pis = prop.pis;
        addprop.pisPorc = prop.pisPorc;
        addprop.cofins = prop.cofins;
        addprop.cofinsPorc = prop.cofinsPorc;
        addprop.receitaLiquida = prop.receitaLiquida;
        addprop.observacoes = prop.observacoes;
        List<InputDadosEmServicosModel> respDadosEmServicos = <InputDadosEmServicosModel>[];
        for (var propDadosEmServicos in prop.dadosEmServicosFormModel!.toList()) {
          InputDadosEmServicosModel addPropDadosEmServicos = InputDadosEmServicosModel();
          addPropDadosEmServicos.idLancamento = propDadosEmServicos.idLancamento;
          addPropDadosEmServicos.idSiciFile =  addprop.id;
          addPropDadosEmServicos.codIbge = propDadosEmServicos.codIbge;
          addPropDadosEmServicos.uf  = propDadosEmServicos.uf;
          addPropDadosEmServicos.tipoCliente = propDadosEmServicos.tipoCliente;
          addPropDadosEmServicos.tipoAtendimento  = propDadosEmServicos.tipoAtendimento;
          addPropDadosEmServicos.tipoAcesso  = propDadosEmServicos.tipoAcesso;
          addPropDadosEmServicos.tecnologia  = propDadosEmServicos.tecnologia;
          addPropDadosEmServicos.tipoProduto  = propDadosEmServicos.tipoProduto;
          addPropDadosEmServicos.velocidade  = propDadosEmServicos.velocidade;
          addPropDadosEmServicos.quantidadeAcesso  = propDadosEmServicos.quantidadeAcesso;
          respDadosEmServicos.add(addPropDadosEmServicos);
        }
        addprop.dadosEmServicos = [];
        addprop.dadosEmServicos!.addAll(respDadosEmServicos);
        respSiciFileModel.add(addprop);
      }
      return respSiciFileModel;
    } catch (error) {
      throw ('Erro $error');
    }
  }

  static Future<List<InputSiciFileModel>> parseDbLOcalSiciFustFormModelToSiciFileList(List<TbFormSiciFust> siciFustFormModel) async{
    try {
      List<InputSiciFileModel> respSiciFileModel = <InputSiciFileModel>[];
      for (var prop in siciFustFormModel) {
        InputSiciFileModel resul = InputSiciFileModel.fromJson(jsonDecode(prop.result) as Map<String, dynamic>);
        resul.idFichaSiciApp = prop.idFichaSiciApp.toString();
        resul.idRegistro = prop.idRegistro;
        respSiciFileModel.add(resul);
      }
      return respSiciFileModel;
    } catch (error) {
      throw ('Erro $error');
    }
  }
}