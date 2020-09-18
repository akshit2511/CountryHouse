import 'package:CountryHouse/screens/Country.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AllCountries extends StatefulWidget {
  @override
  _AllCountriesState createState() => _AllCountriesState();
}

class _AllCountriesState extends State<AllCountries> {
  List countries;
  List filteredcountries;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    getCountries();
  }

  getCountries() async {
    String url = "https://restcountries.eu/rest/v2/all";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        countries = filteredcountries = jsonResponse;
      });
    }
  }

  void _filterCountries(value) {
    setState(() {
      filteredcountries = countries
          .where((country) =>
              country['name'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching
            ? Text("All Countries")
            : TextField(
                onChanged: (value) {
                  _filterCountries(value);
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: "Search country here",
                    hintStyle: TextStyle(color: Colors.white)),
              ),
        actions: <Widget>[
          isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: (() {
                    setState(() {
                      this.isSearching = false;
                      filteredcountries = countries;
                    });
                  }))
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: (() {
                    setState(() {
                      this.isSearching = true;
                    });
                  }))
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: filteredcountries != null
              ? ListView.builder(
                  itemCount:
                      filteredcountries == null ? 0 : filteredcountries.length,
                  itemBuilder: (BuildContext context, index) {
                    return GestureDetector(
                      onTap: (() {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                Country(filteredcountries[index]),
                          ),
                        );
                      }),
                      child: Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 8),
                          child: Text(filteredcountries[index]["name"]),
                        ),
                      ),
                    );
                  })
              : Center(child: CircularProgressIndicator())),
    );
  }
}
