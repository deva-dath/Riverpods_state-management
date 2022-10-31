import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:providers_riverpods/model/user_model.dart';
import 'package:providers_riverpods/state/state_manager.dart';
import 'package:providers_riverpods/userGrid.dart';
import 'package:providers_riverpods/userList.dart';

import 'data_notifier.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

final update = ChangeNotifierProvider<SwitchNotifier>((ref) {
  return SwitchNotifier();
});

final user = StateProvider<List<Data>>(
  (ref) => [],
);

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Data>> users = ref.watch(userStateFuture);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datas'),
      ),
      body: users.when(
          loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
          error: (error, stackTrace) => const Center(
                child: Text('error'),
              ),
          data: (users) {
            return SafeArea(
              child: Column(
                children: [
                  ListTile(
                    trailing: Switch(
                      inactiveTrackColor: Colors.blue,
                      onChanged: (bool isNoti) {
                        ref
                            .read(update)
                            .toggleNotification(isNotifiable: isNoti);
                        // Provider.of<SwitchNotifier>(context, listen: false)
                        //     .toggleNotification(isNotifiable: isNoti);
                      },
                      // value: Provider.of<SwitchNotifier>(context).isNotifiable,
                      value: ref.watch(update).isNotifiable,
                    ),
                    title: const Text(
                      'List/Grid',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(child: Consumer(builder: ((context, ref, child) {
                    return ref.watch(update).isNotifiable ? const GridV() : ListV();
                  })))
                ],
              ),
            );
          }),
    );
  }
}
