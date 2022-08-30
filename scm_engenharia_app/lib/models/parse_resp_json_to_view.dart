import 'input/input_sici_fust_form.dart';
import 'input/sici_fust_form_model.dart';
import 'output/sici_fust_model.dart';

class ParseRespJsonToView{
  static Future<List<SiciFileModel>> parseSiciFustFormModelToSiciFileList(List<SiciFustFormModel>  siciFustFormModel) async{
    try {
      List<SiciFileModel> respSiciFileModel = <SiciFileModel>[];
      for (var prop in siciFustFormModel) {
        SiciFileModel addprop = new SiciFileModel();
        addprop.idFichaSiciApp = 0;
        addprop.idEmpresa = prop.idEmpresa;
        addprop.isSincronizar = "N";
        addprop.id = prop.id;
        addprop.periodoReferencia = prop.periodoReferencia;
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
        List<DadosEmServicos> respDadosEmServicos = <DadosEmServicos>[];
        for (var propDadosEmServicos in prop.dadosEmServicosFormModel!.toList()) {
          DadosEmServicos addPropDadosEmServicos = DadosEmServicos();
          addPropDadosEmServicos.idLancamento = propDadosEmServicos.idLancamento;
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
      throw ('erro $error');
    }
  }
}

class ParseRespModel{

  static Future<InputSiciFustForm> parseRespSiciFileModelToInputSiciFustForm(SiciFileModel prop) async{
    try {
      InputSiciFustForm addprop = InputSiciFustForm();
      addprop.idFichaSiciApp = 0;
      addprop.idEmpresa = prop.idEmpresa;
      addprop.id = prop.id;
      addprop.periodoReferencia = prop.periodoReferencia;
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
      List<InputDadosEmServicos> respDadosEmServicos = <InputDadosEmServicos>[];
      for (var propDadosEmServicos in prop.dadosEmServicos!.toList()) {
        InputDadosEmServicos addPropDadosEmServicos = InputDadosEmServicos();
        addPropDadosEmServicos.idLancamento = propDadosEmServicos.idLancamento;
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
      return addprop;
    } catch (error) {
      throw ('erro $error');
    }
  }


}