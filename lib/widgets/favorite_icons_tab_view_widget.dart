import 'package:flutter/material.dart';
import 'package:trabalho_ed2/arvore_binaria/arvore_binaria.dart';
import 'package:trabalho_ed2/tabela_hash/tabela_hash.dart'; 

class FavoriteIconsTabView extends StatefulWidget {
  final ArvoreBinaria arvoreBinaria;
  const FavoriteIconsTabView({Key? key, required this.arvoreBinaria})
      : super(key: key);

  @override
  State<FavoriteIconsTabView> createState() => _FavoriteIconsTabViewState();
}

class _FavoriteIconsTabViewState extends State<FavoriteIconsTabView> {
  List<IconData> iconesFavoritos = [];

  @override
  void initState() {
    iconesFavoritos =
        widget.arvoreBinaria.listarFolhas(widget.arvoreBinaria.raiz);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 64),
          Text(
            'Ícones favoritos:',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 64),
          Flexible(
            child: GridView.count(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              crossAxisCount: 4,
              children: iconesFavoritos
                  .map(
                    (iconData) => IconButton(
                      icon: Icon(iconData),
                      onPressed: () => setState(() {
                        iconesFavoritos.remove(iconData);
                        widget.arvoreBinaria
                            .removerNo(widget.arvoreBinaria.raiz, iconData);
                      }),
                    ),
                  )
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final TabelaHash tabelaHash = TabelaHash();
                      for (var icone in iconesFavoritos) {
                        tabelaHash.adicionarNaTabelaHash(icone);
                      }

                      final bool result = await tabelaHash.salvarDadosNaHash();

                      if (result) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Salvo!")),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Houve uma falha para salvar!")),
                        );
                      }
                    },
                    child: const Text("Salvar"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
