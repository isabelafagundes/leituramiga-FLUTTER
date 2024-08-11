import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/domain/tema.dart';

mixin TemaWidget on Material {
  Tema? tema = TemaState.instancia.temaSelecionado;
}