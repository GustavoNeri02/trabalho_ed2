import 'dart:math';

import 'package:flutter/material.dart';
import 'package:trabalho_ed2/arvore_binaria/arvore_binaria.dart';

class HomeTabView extends StatefulWidget {
  final ArvoreBinaria arvoreBinaria;

  const HomeTabView({Key? key, required this.arvoreBinaria}) : super(key: key);

  @override
  State<HomeTabView> createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView> {
  IconData _iconData = Icons.flutter_dash;
  Color _iconColor = Colors.blue;

  void _randomizeIcon() {
    IconData getRandomIcon() {
      final Random random = Random();
      const String chars = '0123456789ABCDEF';
      int length = 3;
      String hex = '0xe';
      while (length-- > 0) {
        hex += chars[(random.nextInt(16)) | 0];
      }
      return IconData(int.parse(hex), fontFamily: 'MaterialIcons');
    }

    setState(() {
      _iconData = getRandomIcon();
    });
  }

  void _randomizeColor() {
    setState(() {
      _iconColor = Color(Random().nextInt(0xffffffff)).withAlpha(0xff);
    });
  }

  @override
  void initState() {
    _randomizeColor();
    _randomizeIcon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'Deseja salvar este ícone?',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 64),
          Icon(
            _iconData,
            size: 56,
            color: _iconColor,
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  _randomizeIcon();
                  _randomizeColor();
                },
                icon: const Icon(Icons.close),
                label: const Text("Não"),
                style: TextButton.styleFrom(backgroundColor: Colors.red),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  widget.arvoreBinaria.inserirNo(
                    widget.arvoreBinaria.raiz,
                    _iconData,
                  );

                  _randomizeIcon();
                  _randomizeColor();
                },
                icon: const Icon(Icons.check),
                label: const Text("Sim"),
                style: TextButton.styleFrom(backgroundColor: Colors.green),
              ),
            ],
          ),
          const SizedBox(height: 128),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: _randomizeColor,
                tooltip: 'Atualizar cor',
                child: const Icon(Icons.color_lens_rounded),
              ),
              const SizedBox(width: 64),
              FloatingActionButton(
                onPressed: _randomizeIcon,
                tooltip: 'Atualizar icone',
                child: const Icon(Icons.refresh_rounded),
              )
            ],
          )
        ],
      ),
    );
  }
}
