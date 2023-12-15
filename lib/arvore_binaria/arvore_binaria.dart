// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'no_arvore.dart';

class ArvoreBinaria {
  NoArvore? raiz;

  ArvoreBinaria({this.raiz});

  void substituirRaiz(NoArvore raiz) {
    if (this.raiz == null) this.raiz = raiz;
    this.raiz!.valor = raiz.valor;
    this.raiz!.direita = null;
    this.raiz!.esquerda = null;
  }

  NoArvore inserirNo(NoArvore? noArvore, IconData valor) {
    if (noArvore == null) {
      noArvore = NoArvore(valor);
    } else if (valor.codePoint < noArvore.valor.codePoint) {
      noArvore.esquerda = inserirNo(noArvore.esquerda, valor);
    } else {
      noArvore.direita = inserirNo(noArvore.direita, valor);
    }
    raiz ??= noArvore;
    return noArvore;
  }

  NoArvore? removerNo(NoArvore? noArvore, IconData valor) {
    if (raiz?.valor == valor &&
        raiz?.esquerda == null &&
        raiz?.direita == null) {
      raiz = null;
      return null;
    }
    if (noArvore == null) {
      print("Elemento não encontrado..: $valor");
      return noArvore;
    }

    // filho à esquerda
    if (valor.codePoint < noArvore.valor.codePoint) {
      noArvore.esquerda = removerNo(noArvore.esquerda, valor);
    }
    // filho à direita
    else if (valor.codePoint > noArvore.valor.codePoint) {
      noArvore.direita = removerNo(noArvore.direita, valor);
    }

    //nó sem filhos
    else if ((noArvore.esquerda == null) && (noArvore.direita == null)) {
      if (noArvore.valor == valor) {
        return null;
      } else {
        print("Elemento não encontrado..: $valor");
        return noArvore;
      }
    }
    //nó só tem filho a direita
    else if (noArvore.esquerda == null) {
      return noArvore.direita;
    }
    //nó só tem filho a esquerda
    else if (noArvore.direita == null) {
      return noArvore.esquerda;
    }
    //nó tem 2 filhos
    else {
      NoArvore novo = noArvore.esquerda!;
      while (novo.direita != null) {
        novo = novo.direita!;
      }

      noArvore.valor = novo.valor; //troca de informações
      novo.valor = valor;

      noArvore.esquerda = removerNo(noArvore.esquerda, valor);
    }

    return (noArvore);
  }

  /// Em-ordem: Esquerda -> Raiz -> Direita
  void imprimirEmOrdem(NoArvore? noArvore) {
    if (noArvore != null) {
      imprimirEmOrdem(noArvore.esquerda);
      print(noArvore.valor);
      imprimirEmOrdem(noArvore.direita);
    }
  }

  /// Pré-ordem: Raiz -> Esquerda -> Direita
  void imprimirPreOrdem(NoArvore? noArvore) {
    if (noArvore != null) {
      print(noArvore.valor);
      imprimirPreOrdem(noArvore.esquerda);
      imprimirPreOrdem(noArvore.direita);
    }
  }

  /// Pós-ordem: Esquerda -> Direita -> Raiz
  void imprimirPosOrdem(NoArvore? noArvore) {
    if (noArvore != null) {
      imprimirPosOrdem(noArvore.esquerda);
      imprimirPosOrdem(noArvore.direita);
      print(noArvore.valor);
    }
  }

  // Em nível: Imprime os elementos de cada nível, começando pela raiz
  void imprimirEmNivel() {
    List<NoArvore> fila = [];
    List<IconData> valoresNivel = [];

    if (raiz != null) fila.add(raiz!);

    while (fila.isNotEmpty) {
      int elementosNoNivel = fila.length;

      for (int i = 0; i < elementosNoNivel; i++) {
        NoArvore tempNode = fila.removeAt(0);

        if (i == elementosNoNivel - 1) {
          // Último elemento do nível, não imprime espaço

          valoresNivel.add(tempNode.valor);
          print('$valoresNivel');
          valoresNivel.clear();
        } else {
          // Não é o último elemento do nível, não imprime espaço

          valoresNivel.add(tempNode.valor);
        }

        if (tempNode.esquerda != null) {
          fila.add(tempNode.esquerda!);
        }

        if (tempNode.direita != null) {
          fila.add(tempNode.direita!);
        }
      }
    }
  }

  // Calcula a altura da árvore
  int alturaArvore(NoArvore? noArvore) {
    if (noArvore == null) {
      return 0;
    }

    int alturaEsquerda = alturaArvore(noArvore.esquerda);
    int alturaDireita = alturaArvore(noArvore.direita);

    return 1 +
        (alturaEsquerda > alturaDireita ? alturaEsquerda : alturaDireita);
  }

  List<IconData> listarFolhas(NoArvore? noArvore) {
    List<IconData> folhas = [];
    if (noArvore == null) return folhas;
    folhas.add(noArvore.valor);

    folhas.addAll(listarFolhas(noArvore.esquerda));
    folhas.addAll(listarFolhas(noArvore.direita));
    return folhas;
  }
}
