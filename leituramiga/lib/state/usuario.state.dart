import 'package:leituramiga/domain/usuario/resumo_usuario.dart';
import 'package:leituramiga/domain/usuario/usuario.dart';

mixin class UsuarioState {
  Usuario? usuarioSelecionado;
  Usuario? usuarioEdicao;
  Usuario? usuarioSolicitacao;
}