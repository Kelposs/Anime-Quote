import 'package:anime_quotes/common/const.dart';
import 'package:anime_quotes/common/providers.dart';
import 'package:anime_quotes/main.dart';
import 'package:anime_quotes/view/anime_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InkWellDrawer extends ConsumerStatefulWidget {
  const InkWellDrawer({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InkWellDrawerState();
}

class _InkWellDrawerState extends ConsumerState<InkWellDrawer> {
  @override
  Widget build(BuildContext ctxt) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: <Color>[Colors.lightBlue, Colors.blue])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Image.asset(
                    "assets/images/cute.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          CustomListTile(
            Icons.format_list_bulleted,
            allAnime,
            () => {
              ref.read(titleProvider.state).state = allAnime,
              ref.read(actionProvider.state).state = allAnimation,
              Navigator.pushNamedAndRemoveUntil(
                  //in other case in will build random and it will be a problem because different types
                  context,
                  "/list",
                  (route) => false)
            },
          ),
          CustomListTile(
              Icons.casino,
              randomQts,
              () => {
                    ref.read(titleProvider.state).state = randomQts,
                    ref.read(actionProvider.state).state = randomQuote,
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/", (route) => false)
                  }),
          CustomListTile(
              Icons.attribution,
              randomCharacterQts,
              () => {
                    ref.read(titleProvider.state).state = randomCharacterQts,
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/character", (route) => false)
                  }),
          CustomListTile(
              Icons.book,
              randomTitleQts,
              () => {
                    ref.read(titleProvider.state).state = randomTitleQts,
                    // ref.read(actionProvider.state).state = getRandomByTitle,
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/title", (route) => false)
                  }),
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function() onTap;

  CustomListTile(this.icon, this.text, this.onTap);
  @override
  Widget build(BuildContext context) {
    //ToDO
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
        child: InkWell(
            splashColor: Colors.lightBlue,
            onTap: onTap,
            child: Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(icon),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                        ),
                        Text(
                          text,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_right)
                  ],
                ))),
      ),
    );
  }
}
