import 'package:leituramiga/domain/endereco/municipio.dart';
import 'package:leituramiga/domain/instiuicao_ensino/instituicao_de_ensino.dart';
import 'package:leituramiga/domain/livro/categoria.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:leituramiga/state/filtros.state.dart';

class FiltroUseCase {
  final FiltroState _state;

  const FiltroUseCase(this._state);

  void selecionarMunicipio(Municipio municipio) {
    _state.selecionarMunicipio(municipio);
  }

  void selecionarInstituicao(InstituicaoDeEnsino instituicao) {
    _state.selecionarInstituicao(instituicao);
  }

  void selecionarCategoria(Categoria categoria) {
    _state.selecionarCategoria(categoria);
  }

  void selecionarTipo(TipoSolicitacao tipo) {
    _state.selecionarTipo(tipo);
  }
}
