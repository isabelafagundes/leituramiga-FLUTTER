import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/page/area_logada/home.page.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/carrossel_categorias.widget.dart';
import 'package:projeto_leituramiga/interface/widget/chip/chip.widget.dart';
import 'package:projeto_leituramiga/interface/widget/layout_flexivel.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu.widget.dart';
import 'package:projeto_leituramiga/interface/widget/svg/svg.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class LayoutFiltroWidget extends StatelessWidget {
  final Tema tema;
  final bool usuario;
  final Function() aplicarFiltros;

  const LayoutFiltroWidget({
    super.key,
    required this.tema,
    required this.usuario,
    required this.aplicarFiltros,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutFlexivelWidget(
      tema: tema,
      overlayChild: obterConteudo(context),
      drawerChild: obterConteudo(context),
    );
  }

  Widget obterConteudo(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(vertical: tema.espacamento * 2),
        width: 550,
        height: Responsive.largura(context) <600 ? 500 : Responsive.altura(context),
        child: Column(
          children: [
            Row(
              children: [
                TextoWidget(
                  texto: "Filtros",
                  tema: tema,
                  tamanho: tema.tamanhoFonteG,
                  weight: FontWeight.w400,
                  cor: Color(tema.baseContent),
                ),
                SizedBox(width: tema.espacamento),
                SvgWidget(
                  nomeSvg: 'filtro',
                  cor: Color(tema.baseContent),
                )
              ],
            ),
            if (!usuario) ...[
              TextoWidget(
                texto: "Categorias",
                tema: tema,
                cor: Color(tema.baseContent),
              ),
              SizedBox(height: tema.espacamento),
              CarrosselCategoriaWidget(
                tema: tema,
                categoriasPorId: const {
                  1: "Drama",
                  2: "História",
                  3: "Terror",
                  4: "Comédia",
                  5: "Engenharia",
                  6: "TI",
                },
              ),
              SizedBox(height: tema.espacamento * 2),
              TextoWidget(
                texto: "Tipo de solicitação",
                tema: tema,
                cor: Color(tema.baseContent),
              ),
              SizedBox(height: tema.espacamento),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ChipWidget(
                    tema: tema,
                    cor: kCorPessego,
                    texto: "Troca",
                    corTexto: const Color(0xff464A52),
                  ),
                  SizedBox(width: tema.espacamento * 2),
                  ChipWidget(
                    tema: tema,
                    cor: kCorVerde,
                    texto: "Empréstimo",
                    corTexto: const Color(0xff464A52),
                  ),
                  SizedBox(width: tema.espacamento * 2),
                  ChipWidget(
                    tema: tema,
                    cor: kCorAzul,
                    texto: "Doação",
                    corTexto: const Color(0xff464A52),
                  ),
                ],
              ),
              SizedBox(height: tema.espacamento * 2),
            ],
            TextoWidget(
              texto: "Cidade",
              tema: tema,
              cor: Color(tema.baseContent),
            ),
            SizedBox(height: tema.espacamento),
            Container(
              constraints: const BoxConstraints(maxWidth: 300),
              child: MenuWidget(
                tema: tema,
                escolhas: const ["Cajamar", "Santana de Parnaíba", "São Paulo"],
                aoClicar: () {},
              ),
            ),
            SizedBox(height: tema.espacamento * 2),
            TextoWidget(
              texto: "Intituições de ensino",
              tema: tema,
              cor: Color(tema.baseContent),
            ),
            SizedBox(height: tema.espacamento),
            Container(
              constraints: const BoxConstraints(maxWidth: 300),
              child: MenuWidget(
                tema: tema,
                escolhas: const ["FATEC Santana de Parnaíba", "ETEC Bartolomeu", "ETEC Gino Rezaghi"],
                aoClicar: () {},
              ),
            ),
            const Spacer(),
            BotaoWidget(
              tema: tema,
              texto: 'Aplicar filtros',
              icone: Icon(
                Icons.done,
                color: Color(tema.base200),
              ),
              aoClicar: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              ),
            ),
            SizedBox(height: tema.espacamento * 4),

          ],
        ),
      );
}
