import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Расчёт квартплаты'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controllerTariffWater = TextEditingController();
  final TextEditingController _controllerTariffWaterDrainage =
      TextEditingController();
  final TextEditingController _controllerTariffGWS = TextEditingController();
  final TextEditingController _controllerTariffEnergy = TextEditingController();

  final TextEditingController _controllerMetricColdWater =
      TextEditingController();
  final TextEditingController _controllerMetricHotWater =
      TextEditingController();
  final TextEditingController _controllerMetricEnergy = TextEditingController();

  double? _result = null;

  @override
  Widget build(BuildContext context) {
    void _calc() {
      setState(() {
        if (_controllerTariffWater.text.isNotEmpty &&
            _controllerTariffWaterDrainage.text.isNotEmpty &&
            _controllerTariffGWS.text.isNotEmpty &&
            _controllerTariffEnergy.text.isNotEmpty &&
            _controllerMetricColdWater.text.isNotEmpty &&
            _controllerMetricHotWater.text.isNotEmpty &&
            _controllerMetricEnergy.text.isNotEmpty) {
          double valueTariffWater = double.parse(_controllerTariffWater.text);
          double valueTariffWaterDrainage =
              double.parse(_controllerTariffWaterDrainage.text);
          double valueTariffGWS = double.parse(_controllerTariffGWS.text);
          double valueTariffEnergy = double.parse(_controllerTariffEnergy.text);
          int valueMetricColdWater = int.parse(_controllerMetricColdWater.text);
          int valueMetricHotWater = int.parse(_controllerMetricHotWater.text);
          int valueMetricEnergy = int.parse(_controllerMetricEnergy.text);

          double amountForWater =
              (valueMetricColdWater + valueMetricHotWater) * valueTariffWater;

          double amountForDrainage =
              (valueMetricColdWater + valueMetricHotWater) *
                  valueTariffWaterDrainage;

          double amountForHot = valueMetricHotWater * valueTariffGWS * 0.0676;

          double amountForEnergy = valueMetricEnergy * valueTariffEnergy;

          // print("--------");
          // print("Вода: " + amountForWater.toString() + ", " + valueMetricColdWater.toString(), + ", " + )
          // print(amountForWater);
          // print(amountForDrainage);
          // print(amountForHot);
          // print(amountForEnergy);

          _result = amountForWater +
              amountForDrainage +
              amountForHot +
              amountForEnergy;
        }
      });
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: const Color.fromARGB(255, 255, 254, 254),
                  // Set the clip behavior of the card
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  // Define the child widgets of the card
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Display the card's title using a font size of 24 and a dark grey color
                            Text(
                              "Тарифы",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.grey[800],
                              ),
                            ),
                            // Add a space between the title and the text
                            Container(height: 10),
                            // Display the card's text using a font size of 15 and a light grey color
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _controllerTariffWater,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,2}'))
                                ],
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Вода, м3',
                                ),
                                onChanged: (String val) {
                                  _calc();
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _controllerTariffWaterDrainage,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,2}'))
                                ],
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Водоотведение, м3',
                                ),
                                onChanged: (String val) {
                                  _calc();
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _controllerTariffGWS,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,2}'))
                                ],
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'ГВС, гкал',
                                ),
                                onChanged: (String val) {
                                  _calc();
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _controllerTariffEnergy,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,2}'))
                                ],
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Э/энергия, кВтч',
                                ),
                                onChanged: (String val) {
                                  _calc();
                                },
                              ),
                            ),
                            // Add a row with two buttons spaced apart and aligned to the right side of the card
                            Row(
                              children: <Widget>[
                                // Add a spacer to push the buttons to the right side of the card
                                const Spacer(),
                                // Add a text button labeled "SHARE" with transparent foreground color and an accent color for the text
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.transparent,
                                  ),
                                  child: const Text(
                                    "SHARE",
                                    // style: TextStyle(color: MyColorsSample.accent),
                                  ),
                                  onPressed: () {},
                                ),
                                // Add a text button labeled "EXPLORE" with transparent foreground color and an accent color for the text
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.transparent,
                                  ),
                                  child: const Text(
                                    "EXPLORE",
                                    // style: TextStyle(color: MyColorsSample.accent),
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Add a small space between the card and the next widget
                      Container(height: 5),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: const Color.fromARGB(255, 255, 254, 254),
                  // Set the clip behavior of the card
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  // Define the child widgets of the card
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Display an image at the top of the card that fills the width of the card and has a height of 160 pixels
                      // Image.asset(
                      //   'assets/relaxing-man.png',
                      //   height: 260,
                      //   // width: double.infinity,
                      //   fit: BoxFit.fitWidth,
                      // ),
                      // Add a container with padding that contains the card's title, text, and buttons
                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Display the card's title using a font size of 24 and a dark grey color
                            Text(
                              "Показания счетчиков",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.grey[800],
                              ),
                            ),
                            Text(
                              "Разница с предыдущем месяцем",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[700],
                              ),
                            ),
                            // Add a space between the title and the text
                            Container(height: 10),
                            // Display the card's text using a font size of 15 and a light grey color
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _controllerMetricColdWater,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: false),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Холодная вода',
                                ),
                                onChanged: (String val) {
                                  _calc();
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _controllerMetricHotWater,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: false),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Горячая вода',
                                ),
                                onChanged: (String val) {
                                  _calc();
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _controllerMetricEnergy,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: false),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Э/энергия',
                                ),
                                onChanged: (String val) {
                                  _calc();
                                },
                              ),
                            ),

                            // Add a row with two buttons spaced apart and aligned to the right side of the card
                            Row(
                              children: <Widget>[
                                // Add a spacer to push the buttons to the right side of the card
                                const Spacer(),
                                // Add a text button labeled "SHARE" with transparent foreground color and an accent color for the text
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.transparent,
                                  ),
                                  child: const Text(
                                    "SHARE",
                                    // style: TextStyle(color: MyColorsSample.accent),
                                  ),
                                  onPressed: () {},
                                ),
                                // Add a text button labeled "EXPLORE" with transparent foreground color and an accent color for the text
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.transparent,
                                  ),
                                  child: const Text(
                                    "EXPLORE",
                                    // style: TextStyle(color: MyColorsSample.accent),
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Add a small space between the card and the next widget
                      Container(height: 5),
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _result != null ? "Сумма: $_result" : '',
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                  )),
            ],
          ),
        ));
  }
}
