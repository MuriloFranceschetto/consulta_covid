import 'package:flutter/material.dart';

class Carinhas extends StatelessWidget {
  final int confirmados;
  final int recuperados;
  final int mortes;

  const Carinhas(this.confirmados, this.recuperados, this.mortes);

  @override
  Widget build(BuildContext context) {
    var angry = CircleAvatar(
      backgroundImage: NetworkImage(
          'https://i.pinimg.com/originals/85/6c/72/856c72c52a0be9efbc5315927e1fff85.png'),
    );
    var happy = CircleAvatar(
      backgroundImage: NetworkImage(
          'https://i.pinimg.com/originals/bb/df/cc/bbdfcc990d7a4893e4656a2b4df03065.png'),
    );
    var sad = CircleAvatar(
      backgroundImage: NetworkImage(
          'https://i.pinimg.com/originals/a8/15/d6/a815d6f2edebb1eae33c8f6a7411c188.png'),
    );

    return Column(children: [
      ListTile(
        title: Text('Total Confirmados'),
        subtitle: Text(confirmados.toString()),
        leading: angry,
      ),
      ListTile(
        title: Text('Total recuperados'),
        subtitle: Text(recuperados.toString()),
        leading: happy,
      ),
      ListTile(
        title: Text('Total mortes'),
        subtitle: Text(mortes.toString()),
        leading: sad,
      ),
    ]);
  }
}
