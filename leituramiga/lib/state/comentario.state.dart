import 'package:leituramiga/domain/usuario/comentario_perfil.dart';

mixin class ComentarioState {
  List<ComentarioPerfil> comentarios = [];
  ComentarioPerfil? comentarioEdicao;
}
