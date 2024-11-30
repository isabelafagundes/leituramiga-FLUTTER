import 'package:leituramiga/domain/data_hora.dart';
import 'package:leituramiga/domain/endereco/municipio.dart';
import 'package:leituramiga/domain/instiuicao_ensino/instituicao_de_ensino.dart';
import 'package:leituramiga/domain/livro/resumo_livro.dart';
import 'package:leituramiga/domain/solicitacao/forma_entrega.dart';
import 'package:leituramiga/domain/solicitacao/livro_solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/resumo_solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/solicitacao.dart';

mixin class SolicitacaoState {
  Solicitacao? solicitacaoSelecionada;
  Solicitacao? solicitacaoEdicao;
  FormaEntrega? formaEntregaSelecionada;
  Municipio? municipioSelecionado;
  InstituicaoDeEnsino? instituicaoSelecionada;
  List<LivroSolicitacao> livrosSelecionados = [];
  List<ResumoSolicitacao> solicitacoes = [];
  bool utilizarEnderecoPerfil = false;
  String? dataInicio;
  String? dataFim;

  void selecionarDatas(String? inicio, String? fim) {
    dataInicio = inicio;
    dataFim = fim;
  }

  String get datasFormatadas {
    if(dataInicio == null && dataFim == null) return '';
    DataHora dataHoraInicio = DataHora.deString(dataInicio!, 'yyyy-MM-dd');
    DataHora dataHoraFim = DataHora.deString(dataFim!, 'yyyy-MM-dd');
    return '${dataHoraInicio.formatar('dd/MM/yyyy')} - ${dataHoraFim.formatar('dd/MM/yyyy')}';
  }

  void limparDatas() {
    dataInicio = null;
    dataFim = null;
  }

  void limparLivrosSelecionados() => livrosSelecionados.clear();

  bool verificarSelecao(ResumoLivro livro) => livrosSelecionados.any((element) => element.numero == livro.numero);
}
