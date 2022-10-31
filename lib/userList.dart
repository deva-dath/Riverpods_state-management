import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:providers_riverpods/data_notifier.dart';
import 'package:riverpod/riverpod.dart';
import 'package:providers_riverpods/state/state_manager.dart';
import 'package:providers_riverpods/model/user_model.dart';
import 'package:providers_riverpods/data/get_users.dart';
import 'package:flutter/material.dart';

final users = StateProvider<List<Data>>((ref) => []);
final update = ChangeNotifierProvider<SwitchNotifier>((ref) {
  return SwitchNotifier();
});

class ListV extends ConsumerWidget {
  ListV({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Data>> usersList = ref.watch(userStateFuture);
    return usersList.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => const Center(
        child: Text('error'),
      ),
      data: (users) {
        return Card(
          elevation: 10,
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return ListTile(
                trailing: Checkbox(
                    // value: Provider.of<CheckNotifier>(context).checked,
                    value: users[index].isChecked,
                    onChanged: (bool? _value) {
                      users[index].isChecked = _value ?? false;
                      ref.watch(update).listUpdated();

                      // Provider.of<CheckNotifier>(context,listen: false).markCheckBox(value:_value);
                    }),
                leading: CircleAvatar(
                  backgroundImage: Image.network(users[index].avatar).image,
                  minRadius: 50,
                  maxRadius: 50,
                ),
                title: Text(users[index].firstName,
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                subtitle: Text(users[index].lastName,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              );
            },
          ),
        );
      },
    );
  }
}
