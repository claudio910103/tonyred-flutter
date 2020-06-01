import 'package:rxdart/rxdart.dart';

import 'package:tonyredapp/src/models/cliente_model.dart';
import 'package:tonyredapp/src/provider/clientes_provider.dart';

class ClientesBloc {
  final _clientesController = new BehaviorSubject<List<ClienteModel>>();
  final _cargandoClientesController = new BehaviorSubject<bool>();

  final _clientesProvider = new ClientesProvider();

  Stream<List<ClienteModel>> get clienteStream => _clientesController.stream;

  void cargarClientes() async {
    final clientes = await _clientesProvider.cargarClientes();
    _clientesController.sink.add(clientes);
  }
  
  dispose() {
    _clientesController?.close();
    _cargandoClientesController?.close();
  }
}