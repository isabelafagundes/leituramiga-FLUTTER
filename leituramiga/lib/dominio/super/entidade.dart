///Classes que estedem de Entidade, são aquelas que possuem um identificador único
abstract class Entidade {
  String get id;

  Map<String, dynamic> paraMapa();

}