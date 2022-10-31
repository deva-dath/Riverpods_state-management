import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:providers_riverpods/state/state_manager.dart';
import 'package:providers_riverpods/model/user_model.dart';
import 'package:providers_riverpods/data/get_users.dart';
import 'package:flutter/material.dart';

import 'data_notifier.dart';

final users = StateProvider<List<Data>>((ref) => []);
final update = ChangeNotifierProvider<SwitchNotifier>((ref) {
  return SwitchNotifier();
});

class GridV extends ConsumerWidget {
  const GridV({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Data>> usersList = ref.watch(userStateFuture);
    return usersList.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => const Center(
        child: Text('error'),
      ),
      data: (users) {
        return GridView.builder(
            shrinkWrap: true,
            itemCount: users.length,
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.9,
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10),
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                      color: Color.fromARGB(255, 255, 255, 255),
                      elevation: 10,
                      child: Container(
                          alignment: Alignment.center,
                          child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Column(children: [
                                Image(
                                  image: NetworkImage(users[index].avatar),
                                  width: 100,
                                  height: 100,
                                ),
                                // SizedBox(height: 5),
                                Row(children: [
                                  Text(users[index].firstName,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.normal,
                                      )),
                                  Expanded(
                                    child: Checkbox(
                                        value: users[index].isChecked,
                                        onChanged: (bool? _value) {
                                          users[index].isChecked =
                                              _value ?? false;
                                          ref.watch(update).listUpdated();
                                        }),
                                  )
                                ])
                              ])))));
            });
      },
    );
  }
}
