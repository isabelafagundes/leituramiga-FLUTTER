enum TipoUsuario {
  USUARIO(1, "Usuário"),
  ADMINISTRADOR(2, "Administrador");

  final int id;
  final String nome;

  const TipoUsuario(this.id, this.nome);
}
