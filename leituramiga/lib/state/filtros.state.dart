import 'package:leituramiga/domain/endereco/municipio.dart';
import 'package:leituramiga/domain/endereco/uf.dart';
import 'package:leituramiga/domain/instiuicao_ensino/instituicao_de_ensino.dart';
import 'package:leituramiga/domain/livro/categoria.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';

class FiltroState {
  static FiltroState? _intancia;

  FiltroState._();

  static FiltroState get instancia {
    _intancia ??= FiltroState._();
    return _intancia!;
  }

  int? numeroMunicipio;
  int? numeroInstituicao;
  int? numeroCategoria;
  UF? estado;
  TipoSolicitacao? tipo;

  void selecionarEstado(UF uf) {
    if (estado == uf) {
      estado = null;
      return;
    }
    estado = uf;
  }

  void selecionarMunicipio(Municipio municipio) {
    if (numeroMunicipio == municipio.numero) {
      numeroMunicipio = null;
      return;
    }
    numeroMunicipio = municipio.numero;
  }

  void selecionarInstituicao(InstituicaoDeEnsino instituicao) {
    if (numeroInstituicao == instituicao.numero) {
      numeroInstituicao = null;
      return;
    }
    numeroInstituicao = instituicao.numero;
  }

  void selecionarCategoria(Categoria categoria) {
    if (numeroCategoria == categoria.numero) {
      numeroCategoria = null;
      return;
    }
    numeroCategoria = categoria.numero;
  }

  void selecionarTipo(TipoSolicitacao tipo) {
    if (this.tipo == tipo) {
      this.tipo = null;
      return;
    }
    this.tipo = tipo;
  }

  void limparFiltros() {
    numeroCategoria = null;
    numeroInstituicao = null;
    numeroMunicipio = null;
    tipo = null;
  }
}
