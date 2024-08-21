import 'package:leituramiga/domain/endereco/municipio.dart';
import 'package:leituramiga/domain/instiuicao_ensino/instituicao_de_ensino.dart';
import 'package:leituramiga/domain/livro/categoria.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';

class FiltroState {
  static FiltroState? _intancia;

  FiltroState._();

  static FiltroState? get instancia {
    _intancia ??= FiltroState._();
    return _intancia!;
  }

  int? numeroMunicipio;
  int? numeroInstituicao;
  int? numeroCategoria;
  TipoSolicitacao? tipo;

  void selecionarMunicipio(Municipio municipio) {
    numeroMunicipio = municipio.numero;
  }

  void selecionarInstituicao(InstituicaoDeEnsino instituicao) {
    numeroInstituicao = instituicao.numero;
  }

  void selecionarCategoria(Categoria categoria) {
    numeroCategoria = categoria.numero;
  }

  void selecionarTipo(TipoSolicitacao tipo) {
    this.tipo = tipo;
  }

  void limparFiltros() {
    numeroCategoria = null;
    numeroInstituicao = null;
    numeroMunicipio = null;
    tipo = null;
  }
}
