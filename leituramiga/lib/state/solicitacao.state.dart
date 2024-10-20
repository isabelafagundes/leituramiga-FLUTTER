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

  bool verificarSelecao(ResumoLivro livro) => livrosSelecionados.any((element) => element.numero == livro.numero);
}
