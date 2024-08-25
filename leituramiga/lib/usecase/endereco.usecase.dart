import 'package:leituramiga/domain/endereco/endereco.dart';
import 'package:leituramiga/domain/endereco/municipio.dart';
import 'package:leituramiga/repo/endereco.repo.dart';
import 'package:leituramiga/state/endereco.state.dart';

class EnderecoUseCase {
  final EnderecoState _state;
  final EnderecoRepo _repo;

  const EnderecoUseCase(this._state, this._repo);

  Future<void> obterEndereco(int numeroEndereco) async {
    Endereco endereco = await _repo.obterEndereco(numeroEndereco);
    _state.enderecoEdicao = endereco;
  }

  Future<void> atualizarEndereco(int numeroUsuario) async {
    if (_state.enderecoEdicao == null) return;
    await _repo.atualizarEndereco(_state.enderecoEdicao!, numeroUsuario);
  }

  void atualizarEnderecoEmMemoria(Endereco endereco) {
    _state.enderecoEdicao = endereco;
  }

  Future<void> obterMunicipios() async {
    List<Municipio> municipios = await _repo.obterMunicipios();
    _state.municipiosPorNumero.clear();
    for (Municipio municipio in municipios) {
      _state.municipiosPorNumero[municipio.numero] = municipio;
    }
  }
}
