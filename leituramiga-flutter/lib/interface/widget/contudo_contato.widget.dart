import 'package:flutter/material.dart';
import 'package:leituramiga/domain/usuario/usuario.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class ConteudoContatoWidget extends StatelessWidget {
  final Tema tema;
  final Usuario usuarioCriador;
  final Usuario? usuarioDoador;

  const ConteudoContatoWidget({
    super.key,
    required this.tema,
    required this.usuarioCriador,
    this.usuarioDoador,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _obterTextoComIcone(
          "Contato do usuário: @${usuarioCriador.nomeUsuario}",
          null,
        ),
        SizedBox(height: tema.espacamento),
        _obterTextoComIcone(
          "Nome",
          Icon(
            Icons.person,
            color: Color(tema.baseContent),
            size: 18,
          ),
        ),
        SizedBox(height: tema.espacamento),
        TextoWidget(texto: usuarioCriador.nome, tema: tema),
        SizedBox(height: tema.espacamento * 2),
        _obterTextoComIcone(
          "E-mail",
          Icon(
            Icons.email,
            color: Color(tema.baseContent),
            size: 18,
          ),
        ),
        SizedBox(height: tema.espacamento),
        TextoWidget(texto: usuarioCriador.email.endereco, tema: tema),
        SizedBox(height: tema.espacamento * 2),
        if (usuarioCriador.telefone != null) ...[
          _obterTextoComIcone(
            "Telefone",
            Icon(
              Icons.phone,
              color: Color(tema.baseContent),
              size: 18,
            ),
          ),
          TextoWidget(texto: usuarioCriador.telefone?.telefoneFormatado ?? '', tema: tema),
          SizedBox(height: tema.espacamento * 2),
        ],
        Divider(color: Color(tema.accent), thickness: 1),
        if (usuarioDoador != null) ...[
          SizedBox(height: tema.espacamento * 2),
          _obterTextoComIcone(
            "Contato do usuário: @${usuarioDoador?.nomeUsuario}",
            null,
          ),
          SizedBox(height: tema.espacamento),
          _obterTextoComIcone(
            "Nome",
            Icon(
              Icons.person,
              color: Color(tema.baseContent),
              size: 18,
            ),
          ),
          SizedBox(height: tema.espacamento),
          TextoWidget(texto: usuarioDoador?.nome ?? '', tema: tema),
          SizedBox(height: tema.espacamento * 2),
          _obterTextoComIcone(
            "E-mail",
            Icon(
              Icons.email,
              color: Color(tema.baseContent),
              size: 18,
            ),
          ),
          SizedBox(height: tema.espacamento),
          TextoWidget(texto: usuarioDoador?.email.endereco ?? '', tema: tema),
          SizedBox(height: tema.espacamento * 2),
          if (usuarioDoador?.telefone != null) ...[
            _obterTextoComIcone(
              "Telefone",
              Icon(
                Icons.phone,
                color: Color(tema.baseContent),
                size: 18,
              ),
            ),
            TextoWidget(texto: usuarioDoador?.telefone?.telefoneFormatado ?? '', tema: tema),
          ],
        ],
      ],
    );
  }

  Widget _obterTextoComIcone(String texto, Widget? icone) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icone != null) ...[
          icone,
          SizedBox(width: tema.espacamento),
        ],
        TextoWidget(
          texto: texto,
          tema: tema,
          weight: FontWeight.w500,
          tamanho: tema.tamanhoFonteG,
        ),
      ],
    );
  }
}
