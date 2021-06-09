import 'package:flutter/material.dart';
import 'package:prova_n2/models/Result.dart';
import 'package:prova_n2/views/Carinhas.dart';

class PaisDetails extends StatelessWidget {
  final Countries country;
  const PaisDetails(this.country);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.country.country),
      ),
      body: ListView(
        children: [
          ListTile(
            title:
                Text(this.country.country + ' - ' + this.country.countryCode),
            subtitle: Text(this.country.date),
          ),
          Carinhas(this.country.totalConfirmed, this.country.totalRecovered,
              this.country.totalDeaths),
        ],
      ),
    );
  }
}
