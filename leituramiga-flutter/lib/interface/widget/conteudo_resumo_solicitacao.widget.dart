import 'package:flutter/material.dart';
import 'package:leituramiga/domain/solicitacao/forma_entrega.dart';
import 'package:leituramiga/domain/solicitacao/solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:leituramiga/domain/solicitacao/tipo_status_solicitacao.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class ConteudoResumoSolicitacaoWidget extends StatelessWidget {
  final Tema tema;
  final Solicitacao solicitacao;
  final bool edicao;
  final String usuarioSolicitante;
  final String nomeUsuario;
  final String nomeUsuarioReceptor;

  const ConteudoResumoSolicitacaoWidget({
    super.key,
    required this.tema,
    required this.solicitacao,
    required this.edicao,
    required this.usuarioSolicitante,
    required this.nomeUsuario,
    required this.nomeUsuarioReceptor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(tema.espacamento * 2),
      child: Column(
        children: [
          Flex(
            mainAxisSize: MainAxisSize.min,
            direction: Axis.vertical,
            children: [
              Flexible(
                flex: Responsive.larguraM(context) ? 3 : 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          TextoWidget(
                            texto: "Solicitação em andamento com ",
                            tema: tema,
                            tamanho: tema.tamanhoFonteG,
                          ),
                          SizedBox(height: tema.espacamento),
                          if (nomeUsuario != usuarioSolicitante)
                            TextoWidget(
                              tamanho: tema.tamanhoFonteG,
                              texto: "$usuarioSolicitante",
                              tema: tema,
                              weight: FontWeight.w500,
                            ),
                          if (nomeUsuario == usuarioSolicitante)
                            TextoWidget(
                              tamanho: tema.tamanhoFonteG,
                              texto: "$nomeUsuarioReceptor",
                              tema: tema,
                              weight: FontWeight.w500,
                            ),
                        ],
                      ),
                    ),
                    if (Responsive.larguraP(context)) SizedBox(height: tema.espacamento * 2),
                    if (solicitacao.dataEntrega != null)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: tema.espacamento / 2),
                          _obterTextoComIcone(
                            "Data entrega",
                            Icon(
                              Icons.calendar_today,
                              size: 18,
                              color: Color(tema.baseContent),
                            ),
                          ),
                          SizedBox(height: tema.espacamento),
                          TextoWidget(
                            texto: solicitacao.dataEntrega?.formatar("dd/MM/yyyy HH:mm") ?? '',
                            tema: tema,
                          ),
                        ],
                      ),
                    if (solicitacao.dataDevolucao != null)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: tema.espacamento * 2),
                          _obterTextoComIcone(
                            "Data devolução",
                            Icon(
                              Icons.calendar_today,
                              size: 18,
                              color: Color(tema.baseContent),
                            ),
                          ),
                          SizedBox(height: tema.espacamento),
                          TextoWidget(
                            texto: solicitacao.dataDevolucao?.formatar("dd/MM/yyyy HH:mm") ?? '',
                            tema: tema,
                          ),
                        ],
                      ),
                    SizedBox(height: tema.espacamento * 2),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _obterTextoComIcone(
                          "Endereço de $usuarioSolicitante",
                          Icon(
                            Icons.location_on,
                            size: 18,
                            color: Color(tema.baseContent),
                          ),
                        ),
                        SizedBox(height: tema.espacamento),
                        if (solicitacao.enderecoSolicitante != null)
                          TextoWidget(
                            texto: solicitacao.status == TipoStatusSolicitacao.EM_ANDAMENTO
                                ? solicitacao.enderecoSolicitante!.enderecoFormatado
                                : solicitacao.enderecoSolicitante!.enderecoFormatadoCensurado,
                            tema: tema,
                          ),
                        SizedBox(height: tema.espacamento * 2),
                        if (solicitacao.enderecoReceptor != null) ...[
                          _obterTextoComIcone(
                            "Endereço de $nomeUsuarioReceptor",
                            Icon(
                              Icons.location_on,
                              size: 18,
                              color: Color(tema.baseContent),
                            ),
                          ),
                          SizedBox(height: tema.espacamento),
                          TextoWidget(
                            texto: solicitacao.status == TipoStatusSolicitacao.EM_ANDAMENTO
                                ? solicitacao.enderecoReceptor!.enderecoFormatado
                                : solicitacao.enderecoReceptor!.enderecoFormatadoCensurado,
                            tema: tema,
                          ),
                          SizedBox(height: tema.espacamento * 2),
                        ],
                        _obterTextoComIcone(
                          "Informações adicionais",
                          Icon(
                            Icons.info,
                            size: 18,
                            color: Color(tema.baseContent),
                          ),
                        ),
                        SizedBox(height: tema.espacamento),
                        TextoWidget(
                          texto: solicitacao.informacoesAdicionais.isEmpty
                              ? "Sem informações adicionais"
                              : solicitacao.informacoesAdicionais,
                          tema: tema,
                        ),
                        SizedBox(height: tema.espacamento * 2),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _obterTextoComIcone(
                              "Forma de entrega",
                              Icon(
                                Icons.local_shipping,
                                size: 18,
                                color: Color(tema.baseContent),
                              ),
                            ),
                            SizedBox(height: tema.espacamento),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: tema.espacamento,
                                vertical: tema.espacamento / 2,
                              ),
                              decoration: BoxDecoration(
                                color: solicitacao.formaEntrega == FormaEntrega.CORREIOS ? kCorRosa : kCorRoxa,
                                borderRadius: BorderRadius.circular(tema.borderRadiusM),
                                border: Border.all(color: Color(tema.neutral).withOpacity(.2)),
                              ),
                              child: TextoWidget(
                                texto: solicitacao.formaEntrega.descricao,
                                tema: tema,
                                weight: FontWeight.w500,
                                cor: kCorFonte,
                              ),
                            ),
                          ],
                        ),
                        if (solicitacao.codigoRastreamento != null && solicitacao.codigoRastreamento!.isNotEmpty) ...[
                          SizedBox(height: tema.espacamento * 2),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _obterTextoComIcone(
                                "Código de rastreio",
                                Icon(
                                  Icons.qr_code,
                                  size: 18,
                                  color: Color(tema.baseContent),
                                ),
                              ),
                              SizedBox(height: tema.espacamento),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: tema.espacamento,
                                  vertical: tema.espacamento / 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(tema.accent).withOpacity(.7),
                                  borderRadius: BorderRadius.circular(tema.borderRadiusM),
                                  border: Border.all(color: Color(tema.neutral).withOpacity(.2)),
                                ),
                                child: TextoWidget(
                                  texto: solicitacao.codigoRastreamento!,
                                  tema: tema,
                                  weight: FontWeight.w500,
                                  cor: kCorFonte,
                                ),
                              ),
                            ],
                          ),
                        ],
                        SizedBox(height: tema.espacamento * 2),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _obterTextoComIcone(
                              "Tipo da solicitação",
                              SvgWidget(
                                nomeSvg: "compartilhar_fill",
                                altura: 18,
                                largura: 18,
                                cor: Color(tema.baseContent),
                              ),
                            ),
                            SizedBox(height: tema.espacamento),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: tema.espacamento,
                                vertical: tema.espacamento / 2,
                              ),
                              decoration: BoxDecoration(
                                color: _obterCor(),
                                borderRadius: BorderRadius.circular(tema.borderRadiusM),
                                border: Border.all(color: Color(tema.neutral).withOpacity(.2)),
                              ),
                              child: TextoWidget(
                                texto: solicitacao.tipoSolicitacao.descricao,
                                tema: tema,
                                weight: FontWeight.w500,
                                cor: kCorFonte,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _obterTextoComIcone(String texto, Widget icone) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icone,
        SizedBox(width: tema.espacamento),
        TextoWidget(
          texto: texto,
          tema: tema,
          weight: FontWeight.w500,
          tamanho: tema.tamanhoFonteG,
        ),
      ],
    );
  }

  Color _obterCor() {
    return switch (solicitacao.tipoSolicitacao) {
      TipoSolicitacao.EMPRESTIMO => kCorVerde,
      TipoSolicitacao.DOACAO => kCorAzul,
      TipoSolicitacao.TROCA => kCorPessego,
    };
  }
}
