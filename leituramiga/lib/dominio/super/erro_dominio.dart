abstract class ErroDominio {
  String mensagem;

  ErroDominio(this.mensagem);

  @override
  String toString() => mensagem;
}
