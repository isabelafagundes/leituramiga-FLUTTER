import 'package:leituramiga/domain/usuario/comentario_perfil.dart';

mixin class ComentarioState {
  Map<int, ComentarioPerfil> comentariosPorNumero = {};
  ComentarioPerfil? comentarioEdicao;
}
