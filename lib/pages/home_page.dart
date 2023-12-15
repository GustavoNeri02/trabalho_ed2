import 'package:flutter/material.dart';
import 'package:trabalho_ed2/arvore_binaria/arvore_binaria.dart';
import 'package:trabalho_ed2/tabela_hash/tabela_hash.dart';
import 'package:trabalho_ed2/widgets/favorite_icons_tab_view_widget.dart';
import 'package:trabalho_ed2/widgets/home_tab_view_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  final ArvoreBinaria arvoreBinaria = ArvoreBinaria();

  Future<List<IconData>> carregarDados() async {
    final TabelaHash tabelaHash = TabelaHash();
    List<IconData> iconesSalvos = await tabelaHash.carregarIconesDaHash();
    return iconesSalvos;
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void didChangeDependencies() async {
    final iconesSalvos = await carregarDados();
    for (var icone in iconesSalvos) {
      arvoreBinaria.inserirNo(arvoreBinaria.raiz, icone);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(child: Text("Escolha uma página!")),
            ListTile(
                title: const Text("Página inicial"),
                onTap: () {
                  _tabController.animateTo(0);
                  Navigator.of(context).pop();
                }),
            ListTile(
              title: const Text("Ícones Favoritos"),
              onTap: () {
                _tabController.animateTo(1);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Gerador de ícones"),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          HomeTabView(arvoreBinaria: arvoreBinaria),
          FavoriteIconsTabView(arvoreBinaria: arvoreBinaria),
        ],
      ),
    );
  }
}
