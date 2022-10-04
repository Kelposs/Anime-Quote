import 'package:anime_quotes/common/providers.dart';
import 'package:anime_quotes/model/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RandomQuote extends ConsumerStatefulWidget {
  const RandomQuote({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RandomQuoteState();
}

class _RandomQuoteState extends ConsumerState<RandomQuote> {
  var snackBar = SnackBar(
    content: const Text('Click on Text to change Quote'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {},
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final actionProv = ref.read(actionProvider);
    final itemValue = ref.watch(actionProv);
    print(actionProv);
    return Scaffold(
      drawer: const InkWellDrawer(),
      appBar: AppBar(
        title: Text(
          ref.watch(titleProvider),
        ),
        centerTitle: true,
      ),
      body: itemValue.when(
        data: (item) {
          return GestureDetector(
              onTap: () => ref.refresh(randomQuote.future),
              child: Center(
                child: ListTile(
                  title: Text(
                    item.quote,
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    "${item.character} （${item.anime}）",
                    textAlign: TextAlign.center,
                  ),
                ),
              ));
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text(e.toString())),
      ),
    );
  }
}
