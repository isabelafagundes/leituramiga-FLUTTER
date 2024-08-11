class Cor {
  final String _valor;

  Cor.criar(this._valor);

  int get valor => int.parse(toString());

  @override
  String toString() {
    return "0xff$_valor";
  }
}