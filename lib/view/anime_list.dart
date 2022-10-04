import 'package:anime_quotes/common/providers.dart';
import 'package:anime_quotes/model/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final titleList = StateProvider<List>((ref) {
  return [];
});

class AnimeList extends ConsumerStatefulWidget {
  const AnimeList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AnimeListState();
}

class _AnimeListState extends ConsumerState<AnimeList> {
  bool _searchBoolean = true;
  List<int> _searchIndexList = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  var snackBar = SnackBar(
    content: const Text('コピーしました。'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {},
    ),
  );

  Widget _searchTextField() {
    return TextField(
      onChanged: (String s) {
        //add
        setState(() {
          _searchIndexList = [];
          for (int i = 0; i < ref.read(titleList).length; i++) {
            if (ref
                .read(titleList)[i]
                .toLowerCase()
                .contains(s.toLowerCase())) {
              _searchIndexList.add(i);
            }
          }
        });
      },
      autofocus: true, //Display the keyboard when TextField is displayed
      cursorColor: Colors.white,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      textInputAction:
          TextInputAction.search, //Specify the action button on the keyboard
      decoration: InputDecoration(
        //Style of TextField
        enabledBorder: UnderlineInputBorder(
            //Default TextField border
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: UnderlineInputBorder(
            //Borders when a TextField is in focus
            borderSide: BorderSide(color: Colors.white)),
        hintText: 'Search', //Text that is displayed when nothing is entered.
        hintStyle: TextStyle(
          //Style of hintText
          color: Colors.white60,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _searchListView() {
    //add
    return ListView.builder(
        itemCount: _searchIndexList.length,
        itemBuilder: (context, index) {
          index = _searchIndexList[index];
          return GestureDetector(
            onTap: () {
              Clipboard.setData(
                  ClipboardData(text: "${ref.read(titleList)[index]}"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: ListTile(
                leading: const Icon(Icons.list),
                title: Text(
                  "${ref.read(titleList)[index]}",
                  softWrap: true,
                  style: TextStyle(color: Colors.green, fontSize: 15),
                ),
                subtitle: Text((index + 1).toString())),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final whichProvider = ref.read(actionProvider);
    final itemValue = ref.watch(whichProvider);
    return Scaffold(
      drawer: const InkWellDrawer(),
      appBar: AppBar(
          title: _searchBoolean
              ? Text(
                  ref.watch(titleProvider),
                )
              : _searchTextField(),
          centerTitle: true,
          actions: _searchBoolean
              ? [
                  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          _searchBoolean = false;
                          _searchIndexList = [];
                        });
                      })
                ]
              : [
                  IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _searchBoolean = true;
                        });
                      })
                ]),
      body: itemValue.when(
        data: (item) {
          Future.delayed(
            Duration.zero,
            () {
              ref.read(titleList.state).state = item;
            },
          );

          return _searchBoolean
              ? ListView.builder(
                  itemCount: item.length,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: "${item[index]}"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: ListTile(
                          leading: const Icon(Icons.list),
                          title: Text(
                            "${item[index]}",
                            softWrap: true,
                            style: TextStyle(color: Colors.green, fontSize: 15),
                          ),
                          subtitle: Text((index + 1).toString())),
                    );
                  }))
              : _searchListView();
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text(e.toString())),
      ),
    );
  }
}
