enum UF {
  AC(id: 1, description: 'Acre'),
  AL(id: 2, description: 'Alagoas'),
  AM(id: 3, description: 'Amazonas'),
  AP(id: 4, description: 'Amapá'),
  BA(id: 5, description: 'Bahia'),
  CE(id: 6, description: 'Ceará'),
  DF(id: 7, description: 'Distrito Federal'),
  ES(id: 8, description: 'Espírito Santo'),
  GO(id: 9, description: 'Goiás'),
  MA(id: 10, description: 'Maranhão'),
  MG(id: 11, description: 'Minas Gerais'),
  MS(id: 12, description: 'Mato Grosso do Sul'),
  MT(id: 13, description: 'Mato Grosso'),
  PA(id: 14, description: 'Pará'),
  PB(id: 15, description: 'Paraíba'),
  PE(id: 16, description: 'Pernambuco'),
  PI(id: 17, description: 'Piauí'),
  PR(id: 18, description: 'Paraná'),
  RJ(id: 19, description: 'Rio de Janeiro'),
  RN(id: 20, description: 'Rio Grande do Norte'),
  RO(id: 21, description: 'Rondônia'),
  RR(id: 22, description: 'Roraima'),
  RS(id: 23, description: 'Rio Grande do Sul'),
  SC(id: 24, description: 'Santa Catarina'),
  SE(id: 25, description: 'Sergipe'),
  SP(id: 26, description: 'São Paulo'),
  TO(id: 27, description: 'Tocantins');

  final int id;
  final String description;

  factory UF.deNumero(int id) {
    return UF.values.where((e) => e.id == id).firstOrNull ?? SP;
  }

  const UF({required this.id, required this.description});
}
