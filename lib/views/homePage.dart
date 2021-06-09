import 'package:flutter/material.dart';
import 'package:prova_n2/models/Result.dart';
import 'package:prova_n2/services/HttpService.dart';
import 'package:prova_n2/views/Carinhas.dart';
import 'package:prova_n2/views/detalhesPais.dart';

class MyHomePage extends StatefulWidget {
  @override
  HomePage createState() => HomePage();
}

class HomePage extends State<MyHomePage> {
  final HttpService http = HttpService();

  bool searching = false;
  TextEditingController searchForm = TextEditingController();

  Result result = null;
  List<Countries> allCountries = [];
  List<Countries> filteredCountries = [];

  ListView listPaises = ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: 0,
    itemBuilder: (context, index) {
      return Container();
    },
  );

  Future<Result> _futureSearch = HttpService().getDados();

  @override
  Widget build(BuildContext context) {
    buscar() {
      setState(() {
        _futureSearch = http.getDados();
      });
    }

    filtraPaises() {
      setState(() {
        this.filteredCountries = this
            .allCountries
            .where((element) => element.country
                .toLowerCase()
                .contains(this.searchForm.value.text.toLowerCase()))
            .toList();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Dados mundiais do covid'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              buscar();
            },
          )
        ],
      ),
      body: new FutureBuilder(
        future: _futureSearch,
        builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
          if (snapshot.hasData) {
            this.result = snapshot.data;
            if (snapshot.data != null && snapshot.data.countries != null) {
              this.allCountries = snapshot.data.countries
                  .map<Countries>((country) => country)
                  .toList();
            }
          }
          return ListView(
            children: <Widget>[
              ListTile(
                title: Text('Dados Globais'),
                subtitle: Text(result.global.date),
              ),
              Carinhas(result.global.totalConfirmed,
                  result.global.totalRecovered, result.global.totalDeaths),
              Container(
                margin: EdgeInsets.only(left: 8.0, right: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Procure aqui por um país',
                  ),
                  controller: searchForm,
                  onSubmitted: (value) {
                    filtraPaises();
                  },
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: filteredCountries.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      filteredCountries[index].country +
                          ' - ' +
                          filteredCountries[index].countryCode,
                    ),
                    subtitle: Text(filteredCountries[index].date),
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              PaisDetails(filteredCountries[index]),
                        ),
                      ),
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
