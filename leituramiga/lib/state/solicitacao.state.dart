import 'package:leituramiga/domain/endereco/municipio.dart';
import 'package:leituramiga/domain/instiuicao_ensino/instituicao_de_ensino.dart';
import 'package:leituramiga/domain/solicitacao/forma_entrega.dart';
import 'package:leituramiga/domain/solicitacao/resumo_solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/solicitacao.dart';

mixin class SolicitacaoState {
  Solicitacao? solicitacaoSelecionada;
  Solicitacao? solicitacaoEdicao;
  FormaEntrega? formaEntregaSelecionada;
  Municipio? municipioSelecionado;
  InstituicaoDeEnsino? instituicaoSelecionada;
  List<int> livrosSelecionados = [];
  List<ResumoSolicitacao> solicitacoes = [];
}
