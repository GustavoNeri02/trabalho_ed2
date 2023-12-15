import 'package:flutter/material.dart';

class NoArvore {
  NoArvore? esquerda;
  IconData valor;
  NoArvore? direita;

  NoArvore(
    this.valor, {
    this.esquerda,
    this.direita,
  });
}
