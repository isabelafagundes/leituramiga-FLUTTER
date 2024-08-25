import 'package:flutter/material.dart';
import 'package:leituramiga/domain/livro/livro.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/app_router.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/background/background.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/chip/chip.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/conteudo_menu_lateral.widget.dart';
import 'package:projeto_leituramiga/interface/widget/notificacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto_com_icone.widget.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class LivrosPage extends StatefulWidget {
  final Livro livro;

  const LivrosPage({super.key, required this.livro});

  @override
  State<LivrosPage> createState() => _LivrosPageState();
}

class _LivrosPageState extends State<LivrosPage> {
  TipoSolicitacao? _tipoSolicitacaoSelecionado;

  TemaState get _temaState => TemaState.instancia;

  Tema get tema => _temaState.temaSelecionado!;

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      tema: tema,
      child: ConteudoMenuLateralWidget(
        tema: tema,
        alterarFonte: _alterarFonte,
        alterarTema: _alterarTema,
        child: SizedBox(
          width: Responsive.largura(context),
          height: Responsive.altura(context),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flex(
                  direction: Responsive.larguraM(context) ? Axis.vertical : Axis.horizontal,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment:
                      Responsive.larguraM(context) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          Container(
                            constraints: const BoxConstraints(maxWidth: 500),
                            height: Responsive.altura(context) * .4,
                            color: Colors.white,
                          ),
                          SizedBox(height: tema.espacamento * 2),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextoWidget(
                                texto: widget.livro.nome,
                                tema: tema,
                                tamanho: tema.tamanhoFonteG,
                                cor: Color(tema.accent),
                              ),
                              SizedBox(height: tema.espacamento),
                              TextoWidget(
                                texto: widget.livro.nomeAutor,
                                tema: tema,
                                cor: Color(tema.baseContent),
                              ),
                              SizedBox(height: tema.espacamento / 2),
                              if (Responsive.larguraM(context))
                                SizedBox(
                                  width: 200,
                                  child: Divider(
                                    color: Color(tema.accent),
                                  ),
                                ),
                              SizedBox(height: tema.espacamento),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: tema.espacamento * 5),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextoWidget(
                            texto: "Descrição: ",
                            tema: tema,
                            weight: FontWeight.w500,
                            cor: Color(tema.accent),
                          ),
                          TextoWidget(
                            texto: widget.livro.descricao,
                            tema: tema,
                            cor: Color(tema.baseContent),
                          ),
                          SizedBox(height: tema.espacamento),
                          TextoWidget(
                            texto: "Estado do livro: ",
                            tema: tema,
                            weight: FontWeight.w500,
                            cor: Color(tema.accent),
                          ),
                          TextoWidget(
                            texto: widget.livro.descricaoEstado,
                            tema: tema,
                            cor: Color(tema.baseContent),
                          ),
                          SizedBox(height: tema.espacamento),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              width: 300,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextoComIconeWidget(
                                    tema: tema,
                                    nomeSvg: 'usuario/user',
                                    texto: widget.livro.nomeUsuario,
                                    tamanhoFonte: tema.tamanhoFonteM,
                                  ),
                                  SizedBox(height: tema.espacamento / 2),
                                  TextoComIconeWidget(
                                    tema: tema,
                                    nomeSvg: 'academico/academic-cap',
                                    texto: widget.livro.nomeInstituicao,
                                    tamanhoFonte: tema.tamanhoFonteM,
                                  ),
                                  SizedBox(height: tema.espacamento / 2),
                                  TextoComIconeWidget(
                                    tema: tema,
                                    nomeSvg: 'menu/map-pin-fill',
                                    texto: widget.livro.nomeMunicipio,
                                    tamanhoFonte: tema.tamanhoFonteM,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: tema.espacamento * 2),
                Column(
                  children: [
                    TextoWidget(
                      texto: "Selecione o tipo de solicitação que deseja efetuar",
                      tema: tema,
                      cor: Color(tema.baseContent),
                    ),
                    SizedBox(height: tema.espacamento),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (widget.livro.tiposSolicitacao.contains(TipoSolicitacao.TROCA)) ...[
                          ChipWidget(
                            tema: tema,
                            cor: kCorPessego,
                            texto: "Troca",
                            corTexto: kCorFonte,
                            ativado: _tipoSolicitacaoSelecionado == TipoSolicitacao.TROCA,
                            aoClicar: () => setState(() => _tipoSolicitacaoSelecionado = TipoSolicitacao.TROCA),
                          ),
                          SizedBox(width: tema.espacamento * 2),
                        ],
                        if (widget.livro.tiposSolicitacao.contains(TipoSolicitacao.EMPRESTIMO)) ...[
                          ChipWidget(
                            tema: tema,
                            cor: kCorVerde,
                            texto: "Empréstimo",
                            ativado: _tipoSolicitacaoSelecionado == TipoSolicitacao.EMPRESTIMO,
                            corTexto: kCorFonte,
                            aoClicar: () => setState(() => _tipoSolicitacaoSelecionado = TipoSolicitacao.EMPRESTIMO),
                          ),
                          SizedBox(width: tema.espacamento * 2),
                        ],
                        if (widget.livro.tiposSolicitacao.contains(TipoSolicitacao.DOACAO))
                          ChipWidget(
                            tema: tema,
                            cor: kCorAzul,
                            texto: "Doação",
                            corTexto: kCorFonte,
                            ativado: _tipoSolicitacaoSelecionado == TipoSolicitacao.DOACAO,
                            aoClicar: () => setState(() => _tipoSolicitacaoSelecionado = TipoSolicitacao.DOACAO),
                          ),
                      ],
                    ),
                    SizedBox(height: tema.espacamento * 2),
                    BotaoWidget(
                      tema: tema,
                      texto: 'Criar solicitação',
                      icone: Icon(
                        Icons.chevron_right,
                        color: Color(tema.base200),
                      ),
                      aoClicar: () {
                        if (_tipoSolicitacaoSelecionado == null) {
                          Notificacoes.mostrar("Selecione um tipo de solicitação", Emoji.ALERTA);
                          return;
                        }
                        Rota.navegarComArgumentos(
                          context,
                          CriarSolicitacaoRoute(
                            livro: widget.livro,
                            tipoSolicitacao: _tipoSolicitacaoSelecionado!,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _alterarTema() {
    _temaState.alterarTema(tema.id == 1 ? 2 : 1, () => setState(() {}));
  }

  void _alterarFonte() {
    _temaState.alterarFonte(() => setState(() {}));
  }
}
