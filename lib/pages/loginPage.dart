import 'package:flutter/material.dart';
import 'package:whatsapp_clone/models/countryModel.dart';
import 'package:whatsapp_clone/pages/countryPage.dart';
import 'package:whatsapp_clone/screens/UserScreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String countryName = "Turkey";
  String countryCode = "+90";
  final TextEditingController _phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Enter Phone Number",
            style: TextStyle(
              color: Colors.tealAccent[400],
              fontWeight: FontWeight.bold,
              fontSize: 20,
              wordSpacing: 1.2,
            ),
          ),
          centerTitle: true,
          actions: [
            Icon(
              Icons.move_to_inbox,
              color: Colors.greenAccent[400],
            )
          ],
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const Text(
                "Whatsapp Clone will send an sms to verifiy your phone number",
                style: TextStyle(
                  fontSize: 22,
                  fontStyle: FontStyle.italic,
                  color: Color.fromARGB(255, 17, 46, 208),
                ),
              ),
              const SizedBox(
                height: 7.5,
              ),
              const Text(
                "Phone Number",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 149, 115, 243),
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              countryCard(),
              const SizedBox(
                height: 15,
              ),
              phoneNumber(),
              const SizedBox(),
              InkWell(
                onTap: () {
                  _phoneNumber.text.length < 11
                      ? showMyDialog()
                      : showErrorDialog();
                },
                child: Container(
                  color: Colors.purpleAccent[300],
                  height: 45,
                  width: 45,
                  child: const Center(
                    child: Text(
                      "Proceed",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 45,
              )
            ],
          ),
        ));
  }

  Widget countryCard() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CountryLists(setCountryData: setCountryData)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
            color: Colors.orange,
            width: 2,
          )),
        ),
        child: Row(
          children: [
            SizedBox(
              child: Center(
                child: Text(
                  countryName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: Colors.greenAccent,
              size: 27,
            ),
          ],
        ),
      ),
    );
  }

  void setCountryData(CountryModel countryModel) {
    setState(() {
      countryName = countryModel.name;
      countryCode = countryModel.code;
    });
    Navigator.pop(context);
  }

  Widget phoneNumber() {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: 40,
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.orange,
                  width: 2,
                ),
              ),
            ),
            child: Row(
              children: [
                const Text(
                  "+",
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  countryCode.substring(1),
                  style: const TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.orange,
                  width: 2,
                ),
              ),
            ),
            width: MediaQuery.of(context).size.width / 2 - 120,
            child: TextFormField(
              controller: _phoneNumber,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(8),
                hintText: "Phone Number",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showMyDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Lets verify your phone number",
                      style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 15),
                  Text("$countryCode + " " + ${_phoneNumber.text}",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 15),
                  const Text(
                    "Would you like to correct your number, if not just proceed",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Edit")),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserScreen()));
                },
                child: const Text("OK"),
              ),
            ],
          );
        });
  }

  Future<void> showErrorDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Oops! Looks like you didn't enter your phone number",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          );
        });
  }
}
