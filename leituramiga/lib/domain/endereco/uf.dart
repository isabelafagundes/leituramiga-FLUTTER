enum UF {
  AC(id: 1, descricao: 'Acre'),
  AL(id: 2, descricao: 'Alagoas'),
  AM(id: 3, descricao: 'Amazonas'),
  AP(id: 4, descricao: 'Amapá'),
  BA(id: 5, descricao: 'Bahia'),
  CE(id: 6, descricao: 'Ceará'),
  DF(id: 7, descricao: 'Distrito Federal'),
  ES(id: 8, descricao: 'Espírito Santo'),
  GO(id: 9, descricao: 'Goiás'),
  MA(id: 10, descricao: 'Maranhão'),
  MG(id: 11, descricao: 'Minas Gerais'),
  MS(id: 12, descricao: 'Mato Grosso do Sul'),
  MT(id: 13, descricao: 'Mato Grosso'),
  PA(id: 14, descricao: 'Pará'),
  PB(id: 15, descricao: 'Paraíba'),
  PE(id: 16, descricao: 'Pernambuco'),
  PI(id: 17, descricao: 'Piauí'),
  PR(id: 18, descricao: 'Paraná'),
  RJ(id: 19, descricao: 'Rio de Janeiro'),
  RN(id: 20, descricao: 'Rio Grande do Norte'),
  RO(id: 21, descricao: 'Rondônia'),
  RR(id: 22, descricao: 'Roraima'),
  RS(id: 23, descricao: 'Rio Grande do Sul'),
  SC(id: 24, descricao: 'Santa Catarina'),
  SE(id: 25, descricao: 'Sergipe'),
  SP(id: 26, descricao: 'São Paulo'),
  TO(id: 27, descricao: 'Tocantins');

  final int id;
  final String descricao;

  factory UF.deNumero(int id) {
    return UF.values.where((e) => e.id == id).firstOrNull ?? SP;
  }

  const UF({required this.id, required this.descricao});
}
