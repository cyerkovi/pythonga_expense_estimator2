import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

import '../components/round_icon_button.dart';
import '../components/bottom_button.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/style_constants.dart';
import '../constants/text_constants.dart';

class TestEntryPage extends StatefulWidget {
  const TestEntryPage({Key? key}) : super(key: key);

  @override
  State<TestEntryPage> createState() => _TestEntryPageState();
}

class _TestEntryPageState extends State<TestEntryPage> {
  // List<String> rentalBoatList = [];
  // List<Map> rentalBoatList = [];
  List<List> rentalBoatList = [];
  List<String> rentalBoatType = [
    kRentalBoatClass1Descr,
    kRentalBoatClass2Descr,
    kRentalBoatClass3Descr
  ];

  List<List> miscExpenseList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Entry Page'),
        centerTitle: true,
        // automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: rentalBoatList.length,
                  itemBuilder: (context, index) {
                    //String rentalBoatItem = rentalBoatList[index];
                    // Map rentalBoatItem = rentalBoatList[index];
                    List rentalBoatListItem = rentalBoatList[index];

                    return Column(mainAxisSize: MainAxisSize.min, children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: DropdownButton<String>(
                              value: rentalBoatListItem[0],
                              hint: const Text('Pick a type of boat',
                                  style: kHintTextStyle),
                              onChanged: (String? newValue) {
                                setState(() {
                                  rentalBoatList[index][0] = newValue!;
                                });
                              },
                              items: rentalBoatType
                                  // items: ['One', 'Two', 'Three']
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                    value: value, child: Text(value));
                              }).toList(),
                            ),
                          ),
                          Expanded(
                            child: BottomButton(
                                buttonTitle: 'Delete',
                                onPressed: () => () {
                                      setState(() {
                                        rentalBoatList.removeAt(index);
                                      });
                                    }),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('Days to Rent', style: kBodyTextStyle),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  RoundIconButton(
                                      icon: FontAwesomeIcons.plus,
                                      onPressed: () {
                                        setState(() {
                                          rentalBoatList[index][1]++;
                                          // widget.nNumAdults = nNumAdults;
                                        });
                                      }),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      rentalBoatList[index][1].toString(),
                                      style: kNumberTextStyle,
                                    ),
                                  ),
                                  RoundIconButton(
                                      icon: FontAwesomeIcons.minus,
                                      onPressed: () {
                                        setState(() {
                                          if (rentalBoatList[index][1] > 0) {
                                            rentalBoatList[index][1]--;
                                          } else {
                                            rentalBoatList[index][1] = 0;
                                          }
                                          // widget.nNumAdults = nNumAdults;
                                        });
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]);
                  }),
            ),
            // the following commented code was used to verify results
            /*

            Expanded(
              child: ListView.builder(
                  itemCount: rentalBoatList.length,
                  itemBuilder: (context, index) {
                    String rentalBoatItem = rentalBoatList[index][0];
                    return Column(children: [
                      Row(
                        children: [
                          Text(rentalBoatList[index][0]),
                          Text(rentalBoatList[index][1].toString())
                        ],
                      ),
                    ]);
                  }),
            ),
            */
            Row(
              children: [
                const Text('Add a new Boat Rental'),
                RoundIconButton(
                    icon: FontAwesomeIcons.plus,
                    onPressed: () {
                      // setState(() {
                      setState(() {
                        //print("rentalBoatList is");
                        //print(rentalBoatList);
                        // rentalBoatList.add(kRentalBoatClass1Descr);
                        // Map<String, int> rentalBoatMap =
                        // {kRentalBoatClass1Descr : 0};
                        List rentalBoatListItem = [kRentalBoatClass1Descr, 0];
                        // rentalBoatList.add(rentalBoatMap);
                        rentalBoatList.add(rentalBoatListItem);

                        // widget.nNumAdults = nNumAdults;
                      });
                    }),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: miscExpenseList.length,
                  itemBuilder: (context, index) {
                    List miscExpenseListItem = miscExpenseList[index];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: TextField(
                            maxLength: 30,
                            onChanged: (String? newValue) {
                              setState(() {
                                miscExpenseList[index][0] = newValue!;
                              });
                            },
                            decoration: const InputDecoration(
                              hintText: "Enter a Description",
                              hintStyle: kHintTextStyle,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.greenAccent, width: 5.0),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            onChanged: (String? newValue) {
                              setState(() {
                                miscExpenseList[index][1] = newValue!;
                              });
                            },
                            decoration: const InputDecoration(
                                hintText: 'Enter Amount',
                                hintStyle: kHintTextStyle,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.greenAccent,
                                        width: 5.0))),
                          ),
                        ),
                        BottomButton(
                            buttonTitle: 'Delete',
                            onPressed: () => () {
                                  setState(() {
                                    miscExpenseList.removeAt(index);
                                  });
                                }),
                      ],
                    );
                  }),
            ),
            Expanded(
              child: Row(
                children: [
                  const Text('Add a new Expense'),
                  RoundIconButton(
                      icon: FontAwesomeIcons.plus,
                      onPressed: () {
                        setState(() {
                          List<String> miscExpenseListItem = ['', ''];
                          miscExpenseList.add(miscExpenseListItem);
                          //nNumAdults++;
                          // widget.nNumAdults = nNumAdults;
                        });
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
