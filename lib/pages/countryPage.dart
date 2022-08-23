import 'package:flutter/material.dart';
import 'package:whatsapp_clone/models/countryModel.dart';

class CountryLists extends StatefulWidget {
  const CountryLists({Key? key, required this.setCountryData})
      : super(key: key);
  final Function setCountryData;

  @override
  State<CountryLists> createState() => _CountryListsState();
}

class _CountryListsState extends State<CountryLists> {
  var countryModel = [
    turkeyCode,
    indiaCode,
    italyCode,
    unitedKingdomCode,
    unitedStatesCode,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.cyan,
          ),
        ),
        title: const Text(
          "Choose a country",
          style: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.w500,
            fontSize: 20,
            wordSpacing: 1.2,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.indigoAccent[700],
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => countryCard(countryModel[index]),
        itemCount: countryModel.length,
      ),
    );
  }
}

Widget countryCard(CountryModel country) {
  return GestureDetector(
    onTap: () {
      var widget;
      widget.setCountryData(country);
    },
    child: Card(
      margin: const EdgeInsets.all(0.3),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(
          horizontal: 21,
          vertical: 7,
        ),
        child: Row(
          children: [
            Text(country.flag),
            const SizedBox(
              width: 15,
            ),
            Text(country.name),
            Column(
              children: [
                Expanded(
                  child: SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(country.code),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
