import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Country extends StatelessWidget {
  final Map country;
  Country(this.country);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(country['name']),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: GridView(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          children: <Widget>[
            FlipCard(
                direction: FlipDirection.VERTICAL,
                front: CountryCard("Capital"),
                back: CountryDetailCard(country['capital'])),
            FlipCard(
                direction: FlipDirection.VERTICAL,
                front: CountryCard("Population"),
                back: CountryDetailCard(country['population'].toString())),
            FlipCard(
                direction: FlipDirection.VERTICAL,
                front: CountryCard("Flag"),
                back: Card(
                  color: Colors.white,
                  elevation: 10.0,
                  child: Center(
                    child: SvgPicture.network(country['flag']),
                  ),
                )),
            FlipCard(
                direction: FlipDirection.VERTICAL,
                front: CountryCard("Currency"),
                back: CountryDetailCard(country['currencies'][0]['name'])),
          ],
        ),
      ),
    );
  }
}

class CountryCard extends StatelessWidget {
  final String title;
  CountryCard(this.title);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      child: Center(
        child: Text(title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class CountryDetailCard extends StatelessWidget {
  final String title;
  CountryDetailCard(this.title);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      elevation: 10.0,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
