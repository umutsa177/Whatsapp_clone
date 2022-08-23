class CountryModel {
  String name;
  String code;
  String flag;
  CountryModel({required this.name, required this.code, required this.flag});
}

CountryModel turkeyCode = CountryModel(name: "Turkey", code: "+90", flag: "TR");
CountryModel indiaCode = CountryModel(name: "India", code: "+91", flag: "IN");
CountryModel italyCode = CountryModel(name: "Italy", code: "+39", flag: "IT");
CountryModel unitedStatesCode =
    CountryModel(name: "United States", code: "+1", flag: "US");
CountryModel unitedKingdomCode =
    CountryModel(name: "United Kingdom", code: "+44", flag: "GB");
