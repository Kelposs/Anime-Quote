import 'package:anime_quotes/common/providers.dart';
import 'package:anime_quotes/model/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final titleName = StateProvider<String>((ref) {
  return "";
});
final resultProvider = StateProvider<String>((ref) {
  return "";
});

final txtController = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});

class CharacterQuote extends ConsumerStatefulWidget {
  const CharacterQuote({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterQuoteState();
}

class _CharacterQuoteState extends ConsumerState<CharacterQuote> {
  bool _searchBoolean = true;
  bool wasSubmited = false;

  Widget _searchTextField() {
    return TextField(
      controller: ref.watch(txtController),
      onSubmitted: (value) {
        ref.read(titleName.state).state = value;
        ref.read(actionProvider.state).state = getRandomByCharacter(value);
        setState(() {
          wasSubmited = true;
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
                          wasSubmited = false;
                        });
                      })
                ]
              : [
                  IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _searchBoolean = true;
                          wasSubmited = false;
                        });
                      })
                ]),
      body: !wasSubmited
          ? Center(child: Text("キャラクター名を入力してください"))
          : itemValue.when(
              data: (item) {
                return ListView.builder(
                  itemCount: item.length,
                  itemBuilder: ((context, index) {
                    return ListTile(
                        leading: const Icon(Icons.list),
                        title: Text(item[index].quote),
                        subtitle: Text(item[index].anime));
                  }),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(
                child: Text(
                  e.toString() == "Exception: Failed to load random quote"
                      ? "このアニメキャラクター存在してない\n確認するためにアニメ一覧をチェックしてください"
                      : e.toString(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
    );
  }
}
