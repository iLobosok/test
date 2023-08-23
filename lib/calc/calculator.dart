import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InvestmentCalculatorScreen extends StatefulWidget {
  const InvestmentCalculatorScreen({Key? key}) : super(key: key);

  @override
  _InvestmentCalculatorScreenState createState() =>
      _InvestmentCalculatorScreenState();
}

class _InvestmentCalculatorScreenState
    extends State<InvestmentCalculatorScreen> {
  TextEditingController _percentageController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _amountMonthController = TextEditingController();
  String _result = 'Empty data';

  void _calculateInvestment() {
    double percentage = double.tryParse(_percentageController.text) ?? 0;
    double amount = double.tryParse(_amountController.text) ?? 0;
    double month = double.tryParse(_amountMonthController.text) ?? 0;

    double earnings = (percentage / 100) * amount * month;

    setState(() {
      _result = '+ ${earnings.toStringAsFixed(2)}\$';
    });
  }

  @override
  void dispose() {
    _percentageController.dispose();
    _amountController.dispose();
    _amountMonthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 28, 28, 28),
        body: Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Calculator',
                  style: GoogleFonts.dmSans(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width * .98,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(163, 62, 62, 63),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: Icon(
                          Icons.percent_outlined,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width * .3,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(0, 34, 29, 29),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: TextField(
                                controller: _percentageController,
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.white,
                                onSubmitted: (_) {
                                  FocusScope.of(context).unfocus();
                                },
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'Percent',
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.5)),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            'Percent per month for your investments',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.dmSans(
                              color: Colors.grey,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width * .98,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(163, 62, 62, 63),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width * .6,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(0, 34, 29, 29),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: TextField(
                                controller: _amountMonthController,
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.white,
                                onSubmitted: (_) {
                                  FocusScope.of(context).unfocus();
                                },
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'Number of Months',
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.5)),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            'Number of months for your investments',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.dmSans(
                              color: Colors.grey,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width * .98,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(163, 62, 62, 63),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: Icon(
                          Icons.attach_money,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width * .6,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(0, 34, 29, 29),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: TextField(
                                controller: _amountController,
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.white,
                                onSubmitted: (_) {
                                  FocusScope.of(context).unfocus();
                                },
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'Initial amount',
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.5)),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            'Investment at the beginnig of period',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.dmSans(
                              color: Colors.grey,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width * .98,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(163, 62, 62, 63),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: Icon(
                          Icons.auto_graph,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20),
                            child: Container(
                              height: 30,
                              width: MediaQuery.of(context).size.width * .6,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(0, 34, 29, 29),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                _result,
                                style: GoogleFonts.dmSans(
                                  fontSize: 16,
                                  color: _result.toString() == 'Empty data'
                                      ? Colors.grey
                                      : const Color.fromARGB(255, 77, 179, 77),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            'Result',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.dmSans(
                              color: Colors.grey,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              InkWell(
                onTap: () {
                  setState(() {
                    _calculateInvestment();
                  });
                },
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * .6,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(246, 42, 44, 65),
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                      child: Text(
                    'Calculate',
                    style: GoogleFonts.dmSans(
                        color: const Color.fromARGB(245, 101, 105, 143),
                        fontSize: 25,
                        fontWeight: FontWeight.w800),
                  )),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
