import 'dart:convert';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/bottom_button.dart';
import '../components/step_text.dart';
import '../constants/cost_constants.dart';
import '../constants/text_constants.dart';
import '../constants/style_constants.dart';
import '../constants/number_constants.dart';
import '../services/common_math_routines.dart';
import '../services/file_services.dart';

import '../../components/round_icon_button.dart';
import '../components/rounded_icon_button.dart';
// import '../components/step_list.dart';

import 'start_page.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InputPage extends StatefulWidget {
  InputPage(
      {Key? key,
      this.title,
      required this.fileName,
      required this.isNewEstimate,
      arrivalDate,
      departureDate})
      : super(key: key);

  InputPage.fromJson(Map<String, dynamic> json, {Key? key})
      : this.title = 'Title PageX',
        this.isNewEstimate = false,
        this.fileName = json['file_name'],
        this.estimateName =
            json.containsKey('estimate_name') ? json['estimate_name'] : '',
        this.arrivalDate = transformJsonDateTime(json['arrival_date']),
        this.departureDate = transformJsonDateTime(json['departure_date']),
        this.nNumAdults =
            json.containsKey('num_adults') ? json['num_adults'] : 0,
        this.nNumChildClass1 =
            json.containsKey('num_child_class1') ? json['num_child_class1'] : 0,
        this.nNumChildClass2 =
            json.containsKey('num_child_class2') ? json['num_child_class2'] : 0,
        this.nNumChildClass3 =
            json.containsKey('num_child_class3') ? json['num_child_class3'] : 0,
        this.nNumChildClass4 =
            json.containsKey('num_child_class4') ? json['num_child_class4'] : 0,
        this.includeArrivalDayBreakfast =
            json.containsKey('arrival_day_breakfast')
                ? json['arrival_day_breakfast']
                : false,
        this.includeArrivalDayLunch = json.containsKey('arrival_day_lunch')
            ? json['arrival_day_lunch']
            : false,
        this.includeArrivalDayDinner = json.containsKey('arrival_day_dinner')
            ? json['arrival_day_dinner']
            : true,
        this.includeDepartureDayBreakfast =
            json.containsKey('departure_day_breakfast')
                ? json['departure_day_breakfast']
                : true,
        this.includeDepartureDayLunch = json.containsKey('departure_day_lunch')
            ? json['departure_day_lunch']
            : false,
        this.includeDepartureDayDinner =
            json.containsKey('departure_day_dinner')
                ? json['departure_day_dinner']
                : false,
        this.nNumGuestRegular = json.containsKey('num_guest_regular')
            ? json['num_guest_regular']
            : 0,
        this.nNumGuestJunior =
            json.containsKey('num_guest_junior') ? json['num_guest_junior'] : 0,
        this.memberCabinOpenClose = json.containsKey('member_cabin_open_close')
            ? json['member_cabin_open_close']
            : false,
        this.memberCabinOnClubElectricity =
            json.containsKey('member_cabin_on_club_electricity')
                ? json['member_cabin_on_club_electricity']
                : false,
        this.nNumOfToiletsToWinterize =
            json.containsKey('num_toilets_to_winterize')
                ? json['num_toilets_to_winterize']
                : 0,
        this.memberCabinCleaning = json.containsKey('member_cabin_cleaning')
            ? json['member_cabin_cleaning']
            : false,
        this.memberCabinCleaningHours =
            json.containsKey('member_cabin_cleaning_hours')
                ? json['member_cabin_cleaning_hours']
                : 0,
        this.rentalClubCabin1 = json.containsKey('club_cabin_1_rental')
            ? json['club_cabin_1_rental']
            : false,
        this.peopleInClubCabin1 = json.containsKey('club_cabin_1_occupants')
            ? json['club_cabin_1_occupants']
            : 0,
        this.petInClubCabin1 = json.containsKey('club_cabin_1_pet')
            ? json['club_cabin_1_pet']
            : false,
        this.rentalClubCabin2 = json.containsKey('club_cabin_2_rental')
            ? json['club_cabin_2_rental']
            : false,
        this.peopleInClubCabin2 = json.containsKey('club_cabin_2_occupants')
            ? json['club_cabin_2_occupants']
            : 0,
        this.petInClubCabin2 = json.containsKey('club_cabin_2_pet')
            ? json['club_cabin_2_pet']
            : false,
        this.rentalClubCabinCasino =
            json.containsKey('club_cabin_casino_rental')
                ? json['club_cabin_casino_rental']
                : false,
        this.peopleInClubCabinCasino =
            json.containsKey('club_cabin_casino_occupants')
                ? json['club_cabin_casino_occupants']
                : 0,
        this.petInClubCabinCasino = json.containsKey('club_cabin_casino_pet')
            ? json['club_cabin_casino_pet']
            : false,
        this.memberBoatClass1InOut =
            json.containsKey('member_boat_class1_in_out')
                ? json['member_boat_class1_in_out']
                : 0,
        this.memberBoatClass2InOut =
            json.containsKey('member_boat_class2_in_out')
                ? json['member_boat_class2_in_out']
                : 0,
        this.memberBoatClass3InOut =
            json.containsKey('member_boat_class3_in_out')
                ? json['member_boat_class3_in_out']
                : 0,
        // this.memberBoatGasLiters = json.containsKey('member_boat_gas_liters')
        //     ? json['member_boat_gas_liters']
        //     : 0,
        this.memberEngineClass1Winterize =
            json.containsKey('member_engine_class1_winterize')
                ? json['member_engine_class1_winterize']
                : 0,
        this.memberEngineClass2Winterize =
            json.containsKey('member_engine_class2_winterize')
                ? json['member_engine_class2_winterize']
                : 0,
        this.rentalBoatList =
            fromJsonRentalBoatList(json['rental_boat_rentals']),
        this.gasLiters =
            json.containsKey('gas_liters') ? json['gas_liters'] : 0,
        this.telephoneCalls =
            json.containsKey('telephone_calls') ? json['telephone_calls'] : 0,
        this.internetAccesses = json.containsKey('internet_accesses')
            ? json['internet_accesses']
            : 0,
        this.laundryLoads =
            json.containsKey('laundry_loads') ? json['laundry_loads'] : 0,
        this.firewood = json.containsKey('firewood') ? json['firewood'] : false,
        this.firewoodCords =
            json.containsKey('firewood_cords') ? json['firewood_cords'] : 0,
        this.firewoodDeliveryHours = json.containsKey('firewood_delivery_hours')
            ? json['firewood_delivery_hours']
            : 0,
        this.propane = json.containsKey('propane') ? json['propane'] : false,
        this.propaneTanks =
            json.containsKey('propane_tanks') ? json['propane_tanks'] : 0,
        this.propaneDeliveryCharge = json.containsKey('propane_delivery_charge')
            ? json['propane_delivery_charge']
            : 0,
        this.tipAmt = json.containsKey('tip') ? json['tip'] : 0,
        this.payingWithCardClub = json.containsKey('paying_with_card_club')
            ? json['paying_with_card_club']
            : false,
        this.payingWithCardMgr = json.containsKey('paying_with_card_mgr')
            ? json['paying_with_card_mgr']
            : false,
        this.miscChargesList = json.containsKey('misc_charges')
            ? fromJsonMiscChargeList(json['misc_charges'])
            : [],
        super(key: key);

  Map<String, dynamic> toJson() => {
        'file_name': fileName,
        'estimate_name': estimateName,
        'arrival_date': arrivalDate?.toIso8601String(),
        'departure_date': departureDate?.toIso8601String(),
        'num_adults': nNumAdults,
        'num_child_class1': nNumChildClass1,
        'num_child_class2': nNumChildClass2,
        'num_child_class3': nNumChildClass3,
        'num_child_class4': nNumChildClass4,
        'include_arrival_day_breakfast': includeArrivalDayBreakfast,
        'include_arrival_day_lunch': includeArrivalDayLunch,
        'include_arrival_day_dinner': includeArrivalDayDinner,
        'include_departure_day_breakfast': includeDepartureDayBreakfast,
        'include_departure_day_lunch': includeDepartureDayLunch,
        'include_departure_day_dinner': includeDepartureDayDinner,
        'num_guest_regular': nNumGuestRegular,
        'num_guest_junior': nNumGuestJunior,
        'member_cabin_open_close': memberCabinOpenClose,
        'member_cabin_on_club_electricity': memberCabinOnClubElectricity,
        'num_toilets_to_winterize': nNumOfToiletsToWinterize,
        'member_cabin_cleaning': memberCabinCleaning,
        'member_cabin_cleaning_hours': memberCabinCleaningHours,
        'club_cabin_1_rental': rentalClubCabin1,
        'club_cabin_1_occupants': peopleInClubCabin1,
        'club_cabin_1_pet': petInClubCabin1,
        'club_cabin_2_rental': rentalClubCabin2,
        'club_cabin_2_occupants': peopleInClubCabin2,
        'club_cabin_2_pet': petInClubCabin2,
        'club_cabin_casino_rental': rentalClubCabinCasino,
        'club_cabin_casino_occupants': peopleInClubCabinCasino,
        'club_cabin_casino_pet': petInClubCabinCasino,
        'member_boat_class1_in_out': memberBoatClass1InOut,
        'member_boat_class2_in_out': memberBoatClass2InOut,
        'member_boat_class3_in_out': memberBoatClass3InOut,
        // 'member_boat_gas_liters': memberBoatGasLiters,
        'member_engine_class1_winterize': memberEngineClass1Winterize,
        'member_engine_class2_winterize': memberEngineClass2Winterize,
        'rental_boat_rentals': toJsonRentalBoat(),
        'gas_liters': gasLiters,
        'telephone_calls': telephoneCalls,
        'internet_accesses': internetAccesses,
        'laundry_loads': laundryLoads,
        'firewood': firewood,
        'firewood_cords': firewoodCords,
        'firewood_delivery_hours': firewoodDeliveryHours,
        'propane': propane,
        'propane_tanks': propaneTanks,
        'propane_delivery_charge': propaneDeliveryCharge,
        'tip': tipAmt,
        'paying_with_card_club': payingWithCardClub,
        'paying_with_card_mgr': payingWithCardMgr,
        'misc_charges': toJsonMiscCharge(),
      };

  static List<Map<String, dynamic>> fromJsonRentalBoatList(json) {
    List<Map<String, dynamic>> returnRentalBoatList = [];
    for (int i = 0; i < json.length; i++) {
      returnRentalBoatList.add(json[i]);
    }
    return returnRentalBoatList;
  }

  List<Map<String, dynamic>> toJsonRentalBoat() {
    List<Map<String, dynamic>> rentalBoatJsonList = [];
    for (int i = 0; i < rentalBoatList.length; i++) {
      Map<String, dynamic> rentalBoatListItem = {};
      rentalBoatListItem['rental_boat_type'] =
          rentalBoatList[i]["rental_boat_type"];
      rentalBoatListItem['rental_boat_days'] =
          rentalBoatList[i]["rental_boat_days"];
      rentalBoatJsonList.add(rentalBoatListItem);
    }
    return rentalBoatJsonList;
  }

  static List<Map<String, dynamic>> fromJsonMiscChargeList(json) {
    List<Map<String, dynamic>> returnMiscChargeList = [];
    for (int i = 0; i < json.length; i++) {
      returnMiscChargeList.add(json[i]);
    }
    return returnMiscChargeList;
  }

  List<Map<String, dynamic>> toJsonMiscCharge() {
    List<Map<String, dynamic>> miscChargeJsonList = [];
    for (int i = 0; i < miscChargesList.length; i++) {
      Map<String, dynamic> miscChargeJsonListItem = {};
      miscChargeJsonListItem['misc_charge_descr'] =
          miscChargesList[i]["misc_charge_descr"];
      miscChargeJsonListItem['misc_charge_amt'] =
          miscChargesList[i]["misc_charge_amt"];
      miscChargeJsonList.add(miscChargeJsonListItem);
    }
    return miscChargeJsonList;
  }

  final String? title;
  final bool isNewEstimate;
  String fileName = 'xx';

  static DateTime transformJsonDateTime(jsonDateTime) {
    if (jsonDateTime == null) {
      return DateTime.now();
    } else {
      return DateTime.parse(jsonDateTime);
    }
  }

  /* ------------------- attributes------------------------*/
  // String? estimateName = '';
  DateTime? arrivalDate;
  DateTime? departureDate;

  String estimateName = '';

  int nNumAdults = 0;
  int nNumChildClass1 = 0;
  int nNumChildClass2 = 0;
  int nNumChildClass3 = 0;
  int nNumChildClass4 = 0;

  bool includeArrivalDayBreakfast = false;
  bool includeArrivalDayLunch = false;
  bool includeArrivalDayDinner = true;
  bool includeDepartureDayBreakfast = true;
  bool includeDepartureDayLunch = false;
  bool includeDepartureDayDinner = false;

  int nNumGuestRegular = 0;
  int nNumGuestJunior = 0;
  bool memberCabinOpenClose = false;
  int nNumOfToiletsToWinterize = 0;
  bool memberCabinCleaning = false;
  int memberCabinCleaningHours = 0;
  bool memberCabinOnClubElectricity = false;

  bool rentalClubCabin1 = false;
  int peopleInClubCabin1 = 0;
  bool petInClubCabin1 = false;

  bool rentalClubCabin2 = false;
  int peopleInClubCabin2 = 0;
  bool petInClubCabin2 = false;

  bool rentalClubCabinCasino = false;
  int peopleInClubCabinCasino = 0;
  bool petInClubCabinCasino = false;

  int memberBoatClass1InOut = 0;
  int memberBoatClass2InOut = 0;
  int memberBoatClass3InOut = 0;
  // int memberBoatGasLiters = 0;

  int memberEngineClass1Winterize = 0;
  int memberEngineClass2Winterize = 0;

  List<dynamic> rentalBoatList = [];
  List<String> rentalBoatTypeList = [
    kRentalBoatClass1Descr,
    kRentalBoatClass2Descr,
    kRentalBoatClass3Descr
  ];
  int gasLiters = 0;
  int telephoneCalls = 0;
  int internetAccesses = 0;
  int laundryLoads = 0;
  bool firewood = false;
  int firewoodCords = 0;
  int firewoodDeliveryHours = 0;
  bool propane = false;
  int propaneTanks = 0;
  double propaneDeliveryCharge = 0;
  double tipAmt = 0;
  bool payingWithCardClub = false;
  bool payingWithCardMgr = false;
  List<dynamic> miscChargesList = [];

  /*
  String filenameUserFacing() {
    if (arrivalDate != null) {
      return arrivalDate.toString();
    } else {
      return 'No Date';
    }
  }
  */

  @override
  State<InputPage> createState() => _InputPageState();
}

/* ----------------- beginning of state class ---------------------- */

class _InputPageState extends State<InputPage> {
  /* ------------------ attributes ----------------------------------*/

  int _activeCurrentStep = 0;

  DateTime? arrivalDate;
  DateTime? departureDate;

  String estimateName = '';

  int nNumAdults = 0;
  int nNumChildClass1 = 0;
  int nNumChildClass2 = 0;
  int nNumChildClass3 = 0;
  int nNumChildClass4 = 0;
  int nNumGuestRegular = 0;
  int nNumGuestJunior = 0;

  bool includeArrivalDayBreakfast = false;
  bool includeArrivalDayLunch = false;
  bool includeArrivalDayDinner = true;
  bool includeDepartureDayBreakfast = true;
  bool includeDepartureDayLunch = false;
  bool includeDepartureDayDinner = false;

  bool memberCabinOpenClose = false;
  int nNumOfToiletsToWinterize = 0;
  bool memberCabinCleaning = false;
  int memberCabinCleaningHours = 0;
  bool memberCabinOnClubElectricity = false;

  bool rentalClubCabin1 = false;
  int peopleInClubCabin1 = 0;
  bool petInClubCabin1 = false;

  bool rentalClubCabin2 = false;
  int peopleInClubCabin2 = 0;
  bool petInClubCabin2 = false;

  bool rentalClubCabinCasino = false;
  int peopleInClubCabinCasino = 0;
  bool petInClubCabinCasino = false;
  int tripYear = DateTime.now().year;
  int memberBoatClass1InOut = 0;
  int memberBoatClass2InOut = 0;
  int memberBoatClass3InOut = 0;
  // int memberBoatGasLiters = 0;

  int memberEngineClass1Winterize = 0;
  int memberEngineClass2Winterize = 0;

  bool rentalBoatClass1 = false;
  bool rentalBoatClass2 = false;
  bool rentalBoatClass3 = false;

  List<dynamic> rentalBoatList = [];
  List<String> rentalBoatType = [
    kRentalBoatClass1Descr,
    kRentalBoatClass2Descr,
    kRentalBoatClass3Descr
  ];
  int gasLiters = 0;
  int telephoneCalls = 0;
  int internetAccesses = 0;
  int laundryLoads = 0;
  bool firewood = false;
  int firewoodCords = 0;
  int firewoodDeliveryHours = 0;
  bool propane = false;
  int propaneTanks = 0;
  double propaneDeliveryCharge = 0;
  double tipAmt = 0;
  bool payingWithCardClub = false;
  bool payingWithCardMgr = false;
  List<dynamic> miscChargesList = [];

  String textToStoreInFile() {
    // print("in textToStoreInFile()");
    String json = jsonEncode(widget);
    // print('file contents is');
    // print(json);
    return json;
  }

  Future<String> fileName() async {
    var returnValue;
    // print('in fileName()');
    // print('widget.fileName is');
    // print(widget.fileName);
    if (widget.fileName != 'xx') {
      returnValue = widget.fileName;
    } else {
      // print("about to call FileHelper.getNewFileName()");
      var newFileName = await FileHelper.getNewFileName().then((String resp) {
        // print("resp is");
        // print(resp);

        // print('input_page.filename() response and datatype is');
        // print(resp);
        // print(resp.runtimeType);
        returnValue = resp.toString();
        returnValue = '$returnValue$kEstimateFileExtension';
      });
    }
    return returnValue;
  }

  Future<void> saveAction() async {
    //print('in saveAction');
    //print("estimateName is");
    // print(estimateName.runtimeType);
    // print(estimateName);
    //print(widget.departureDate?.toIso8601String());
    // print(fileName());
    // print(textToStoreInFile());
    String localFileName = await fileName();
    // print("filename returned by filename() is");
    // print(localFileName);
    widget.fileName = localFileName;
    String textToStore = textToStoreInFile();
    print('textToStore is');
    print('textToStore.length is');
    print(textToStore.length);
    print(textToStore);
    // print('textToStoreInFile is');
    // print(textToStore);

    FileHelper fileHelper = FileHelper(localFileName, textToStore);
    //print(fileHelper.fileName);
    // print(fileHelper.fileContents);
    fileHelper.writeStringToFile();
    //Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return StartPage(title: kYourTripsDescr);
    }));
  }

  void discardAction() {
    Navigator.pop(context);
  }

  /* -------------------- grand total methods --------------------------*/
  double grandTotal() {
    /*
    double total =
        taxableTotal() + taxTotal() + tipTotal() + cardConvenienceFeeTotal();
    return monetaryAmountRounded(total);
     */
    return grandTotalClub() + grandTotalMgr() + tipTotal();
  }

  double grandTotalClub() {
    return monetaryAmountRounded(
        taxableTotalClub() + taxTotalClub() + cardConvenienceFeeClub());
  }

  double grandTotalMgr() {
    return monetaryAmountRounded(
        taxableTotalMgr() + taxTotalMgr() + cardConvenienceFeeMgr());
  }

  double cardTotal() {
    // used to determine card convenience fee
    // return taxableTotal() + taxTotal();
    return cardTotalClub() + cardTotalMgr();
  }

  double cardTotalClub() {
    return taxableTotalClub() + taxTotalClub();
  }

  double cardTotalMgr() {
    return taxableTotalMgr() + taxTotalMgr();
  }

  /* --------------------beginning of tax methods----------------------------*/

  double taxableTotal() {
    /*
    return totalBoardCharges() +
        totalGuestFees() +
        totalMemberCabinCharge() +
        totalClubCabinRentalCharge() +
        totalMemberBoatCharge() +
        totalRentalBoatCharges() +
        totalExtraCharges();
        */
    return taxableTotalClub() + taxableTotalMgr();
  }

  double taxableTotalClub() {
    // just propane and firewood and electric

    return totalMemberCabinChargeClub();
  }

  double taxableTotalMgr() {
    // include wood and propane  delivery

    return totalBoardCharges() +
        totalGuestFees() +
        totalGasCharge() +
        totalMemberCabinChargeMgr() +
        totalClubCabinRentalCharge() +
        totalMemberBoatCharge() +
        totalRentalBoatCharges() +
        totalExtraCharges();
  }

  double taxCalc(rate, basis) {
    if (basis != 0) {
      return monetaryAmountRounded(basis * rate);
    } else {
      return 0;
    }
  }

  double taxTotal() {
    return monetaryAmountRounded(pstTotal() + gstTotal());
  }

  double taxTotalClub() {
    return monetaryAmountRounded(pstTotalClub() + gstTotalClub());
  }

  double taxTotalMgr() {
    return monetaryAmountRounded(pstTotalMgr() + gstTotalMgr());
  }

  double pstRate() {
    return kCostRates[tripYear]['pst_percentage'];
  }

  double pstTotal() {
    // double rate = kCostRates[tripYear]['pst_percentage'];

    return taxCalc(pstRate(), taxableTotal());
  }

  double pstTotalClub() {
    return taxCalc(pstRate(), taxableTotalClub());
  }

  double pstTotalMgr() {
    return taxCalc(pstRate(), taxableTotalMgr());
  }

  double gstRate() {
    return kCostRates[tripYear]['gst_percentage'];
  }

  double gstTotal() {
    //double rate = kCostRates[tripYear]['gst_percentage'];
    return taxCalc(gstRate(), taxableTotal());
  }

  double gstTotalClub() {
    return taxCalc(gstRate(), taxableTotalClub());
  }

  double gstTotalMgr() {
    return taxCalc(gstRate(), taxableTotalMgr());
  }

  /* --------------------beginning of date methods----------------------*/

  double numberOfFullBoardDays() {
    double numberOfDays = 0;
    if (departureDate != null) {
      numberOfDays = ((departureDate?.difference(arrivalDate!).inDays)! - 1);
    }
    return numberOfDays;
  }

  String numberOfFullBoardDaysString() {
    String result = numberOfFullBoardDays().toStringAsFixed(0);
    if (numberOfFullBoardDays() == 1) {
      return 'Board is calculated for ' + result + ' full day, including';
    } else if (numberOfFullBoardDays() > 1) {
      return ' Board is calculated for ' + result + ' full days, including';
    } else {
      return '';
    }
  }

  /*
    if (result == '1') {
      return '$result day'; }
    else {
      return '$result days';
    }
  }
  */

  int numberOfOvernights() {
    int numberOfDays = 0;
    if (departureDate != null) {
      numberOfDays = (departureDate?.difference(arrivalDate!).inDays)!;
    }
    //print("numberOfOvernights is");
    //print(numberOfDays);
    return numberOfDays;
  }

  /* ------------------- beginning of people methods ------------------*/

  int totalPeople() {
    return nNumAdults +
        nNumChildClass1 +
        nNumChildClass2 +
        nNumChildClass3 +
        nNumChildClass4;
  }

  /* --------------------beginning of board methods-----------------------*/

  double boardPartialDays() {
    double partialDays = ((includeArrivalDayBreakfast ? 1 : 0) +
        (includeArrivalDayLunch ? 1 : 0) +
        (includeArrivalDayDinner ? 1 : 0) +
        (includeDepartureDayBreakfast ? 1 : 0) +
        (includeDepartureDayLunch ? 1 : 0) +
        (includeDepartureDayDinner ? 1 : 0));
    partialDays = partialDays / 3;
    return partialDays;
  }

  double totalBoardCharges() {
    return monetaryAmountRounded(boardTotalAdults() +
        boardTotalChildClass1() +
        boardTotalChildClass2() +
        boardTotalChildClass3() +
        boardTotalChildClass4());
  }

  double boardTotalCommonRoutine(rate, nDays, nPeople) {
    return monetaryAmountRounded(rate * nDays * nPeople);
  }

  double boardDailyRateLookup(String ageCategory) {
    // print(kCostRates[tripYear]['board_daily_rate'][ageCategory].toString());
    return (kCostRates[tripYear]['board_daily_rate'][ageCategory]);
  }

  String boardDailyRateAsString(String ageCategory) {
    return boardDailyRateLookup(ageCategory)
        .toStringAsFixed(kCurrencyPrecision);
  }

  double boardTotalAdults() {
    return boardTotalCommonRoutine(boardDailyRateLookup(kAdult),
        (boardPartialDays() + numberOfFullBoardDays()), nNumAdults);
  }

  double boardTotalChildClass1() {
    return boardTotalCommonRoutine(boardDailyRateLookup(kChildClass1),
        (boardPartialDays() + numberOfFullBoardDays()), nNumChildClass1);
  }

  double boardTotalChildClass2() {
    return boardTotalCommonRoutine(boardDailyRateLookup(kChildClass2),
        (boardPartialDays() + numberOfFullBoardDays()), nNumChildClass2);
  }

  double boardTotalChildClass3() {
    return boardTotalCommonRoutine(boardDailyRateLookup(kChildClass3),
        (boardPartialDays() + numberOfFullBoardDays()), nNumChildClass3);
  }

  double boardTotalChildClass4() {
    return boardTotalCommonRoutine(boardDailyRateLookup(kChildClass4),
        (boardPartialDays() + numberOfFullBoardDays()), nNumChildClass4);
  }

  /*--------------------beginning of guest fee methods-----------------------*/

  double guestFeeCalc(int numberOfGuests, double dailyRate) {
    double netFee = 0;
    if (numberOfGuests != 0) {
      double grossFee =
          numberOfGuests.toDouble() * dailyRate * numberOfFullBoardDays();

      double minFee = guestFeeMinDays().toDouble() * dailyRate;

      netFee = max(grossFee, minFee);
    }
    return netFee;
  }

  double guestFeeRegular() {
    double rate = guestFeeDailyRateRegular();

    return guestFeeCalc(nNumGuestRegular, rate);
  }

  double guestFeeJunior() {
    double rate = guestFeeDailyRateJunior();
    return guestFeeCalc(nNumGuestRegular, rate);
  }

  double totalGuestFees() {
    return guestFeeRegular() + guestFeeJunior();
  }

  double guestFeeDailyRateRegular() {
    /*
    print('regular guest daily rate runtype is');
    print((kCostRates[tripYear]['guest_fees']
                ['daily_fee_guest_of_reqular_member']
            .toDouble())
        .runtimeType);
*/
    return (kCostRates[tripYear]['guest_fees']
            ['daily_fee_guest_of_reqular_member'])
        .toDouble();
  }

  String guestFeeDailyRateRegularAsString() {
    return guestFeeDailyRateRegular().toStringAsFixed(kCurrencyPrecision);
  }

  double guestFeeDailyRateJunior() {
    return (kCostRates[tripYear]['guest_fees']
            ['daily_fee_guest_of_junior_member'])
        .toDouble();
  }

  String guestFeeDailyRateJuniorAsString() {
    return guestFeeDailyRateJunior().toStringAsFixed(kCurrencyPrecision);
  }

  int guestFeeMinDays() {
    return (kCostRates[tripYear]['guest_fees']
        ['minimum_number_of_days_charged_per_guest']);
  }

  bool guestFeesWaived() {
    if (guestFeeRegular() == 0 && guestFeeJunior() == 0) {
      return true;
    } else {
      return false;
    }
  }

  /* ----------------- beginning of member cabin methods -------------------*/

  double totalMemberCabinCharge() {
    /*
    return memberCabinOpenCloseCharge() +
        memberCabinElectricityCharge() +
        memberCabinCleaningCharge() +
        memberCabinFirewoodCharge() +
        memberCabinPropaneCharge();
     */
    return totalMemberCabinChargeClub() + totalMemberCabinChargeMgr();
  }

  double totalMemberCabinChargeMgr() {
    return memberCabinOpenCloseCharge() +
        memberCabinCleaningCharge() +
        memberCabinPropaneDeliveryCharge();
  }

  double totalMemberCabinChargeClub() {
    return memberCabinFirewoodWoodCharge() +
        memberCabinPropanePropaneCharge() +
        memberCabinElectricityCharge();
  }

  double memberCabinOpenCloseCharge() {
    double charge = 0;
    if (memberCabinOpenClose) {
      charge = (kCostRates[tripYear]['member_cabins']
              ['cabin_open_close_charge']) +
          memberCabinToiletWinterizeCharge();
    }
    return monetaryAmountRounded(charge);
  }

  double memberCabinToiletWinterizeCharge() {
    double perToiletCharge =
        (kCostRates[tripYear]['member_cabins']['toilet_winterization_charge']);
    return monetaryAmountRounded(perToiletCharge * nNumOfToiletsToWinterize);
  }

  double memberCabinCleaningCharge() {
    double cabinCleaningHourlyRate =
        (kCostRates[tripYear]['member_cabins']['cabin_cleaning_hourly_rate']);
    return monetaryAmountRounded(
        memberCabinCleaningHours * cabinCleaningHourlyRate);
  }

  double memberCabinElectricityCharge() {
    double electricityCharge = 0;
    if (memberCabinOnClubElectricity) {
      double rate = (kCostRates[tripYear]['member_cabins']
          ['cabin_electricity_daily_rate']);
      // count arrival and departure days in calculation
      //print("departureDate");
      //print(departureDate);
      //print('arrivalDate');
      //print(arrivalDate);
      //print('difference in dates');
      //print(departureDate?.difference(arrivalDate!).inDays);
      // electricity charged for arrival through departure dates inclusive
      if (arrivalDate != null && departureDate != null) {
        double days = ((departureDate?.difference(arrivalDate!).inDays)! + 1);
        electricityCharge = monetaryAmountRounded(rate * days);
      }
    }
    return electricityCharge;
  }

  double memberCabinFirewoodCharge() {
    return memberCabinFirewoodWoodCharge() +
        memberCabinFirewoodDeliveryCharge();
  }

  double memberCabinFirewoodWoodCharge() {
    double rate = (kCostRates[tripYear]['firewood_face_cord_price']);
    return monetaryAmountRounded(rate * firewoodCords);
  }

  double memberCabinFirewoodDeliveryCharge() {
    double rate = (kCostRates[tripYear]['firewood_delivery_hourly_rate']);
    return monetaryAmountRounded(rate * firewoodDeliveryHours);
  }

  double memberCabinPropaneCharge() {
    return memberCabinPropanePropaneCharge() +
        memberCabinPropaneDeliveryCharge();
  }

  double memberCabinPropanePropaneCharge() {
    double rate = (kCostRates[tripYear]['propane_tank_price']);
    return monetaryAmountRounded(rate * propaneTanks);
  }

  double memberCabinPropaneDeliveryCharge() {
    double rate = (kCostRates[tripYear]['propane_delivery_charge']);
    return monetaryAmountRounded(rate * propaneDeliveryCharge);
  }

  /* ------------------ beginning of cabin rental methods -------------------*/

  double totalClubCabinRentalCharge() {
    return clubCabin1RentalCharge() +
        clubCabin2RentalCharge() +
        clubCabinCasinoRentalCharge();
  }

  double clubCabinRentalCharge(
      double stdCharge, double occupancySurcharge, double petSurcharge) {
    return stdCharge + occupancySurcharge + petSurcharge;
  }

  double clubCabin1RentalCharge() {
    return clubCabinRentalCharge(clubCabin1StdOccupancyCharge(),
        clubCabin1OccupancySurcharge(), clubCabin1PetSurcharge());
  }

  double clubCabin2RentalCharge() {
    return clubCabinRentalCharge(clubCabin2StdOccupancyCharge(),
        clubCabin2OccupancySurcharge(), clubCabin2PetSurcharge());
  }

  double clubCabinCasinoRentalCharge() {
    return clubCabinRentalCharge(clubCabinCasinoStdOccupancyCharge(),
        clubCabinCasinoOccupancySurcharge(), clubCabinCasinoPetSurcharge());
  }

  double clubCabinStdOccupancyCharge(String cabinName, int numDaysRented) {
    double rentalCharge = 0;

    if (numDaysRented > 0) {
      double stdDailyRate = clubCabinDailyRate(cabinName);
      rentalCharge = (stdDailyRate * numDaysRented).toDouble();
    }
    return monetaryAmountRounded(rentalCharge);
  }

  double clubCabin1StdOccupancyCharge() {
    double charge = 0;
    if (rentalClubCabin1) {
      charge = clubCabinStdOccupancyCharge('club_cabin1', numberOfOvernights());
    }
    return charge;
  }

  double clubCabin2StdOccupancyCharge() {
    double charge = 0;
    if (rentalClubCabin2) {
      charge = clubCabinStdOccupancyCharge('club_cabin2', numberOfOvernights());
    }
    return charge;
  }

  double clubCabinCasinoStdOccupancyCharge() {
    double charge = 0;
    if (rentalClubCabinCasino) {
      charge = clubCabinStdOccupancyCharge('club_casino', numberOfOvernights());
    }
    return charge;
  }

  double clubCabinOccupancySurcharge(
      String cabinName, int peopleInCabin, int numDays) {
    double occupancySurcharge = 0;
    int numStdOccupancy = stdOccupancyClubCabin(cabinName);
    int extraPeople = peopleInCabin - numStdOccupancy;
    if (extraPeople > 0) {
      occupancySurcharge =
          monetaryAmountRounded(additionalPersonSurchargeRate() * extraPeople) *
              numDays;
    }
    return occupancySurcharge;
  }

  double clubCabin1OccupancySurcharge() {
    return clubCabinOccupancySurcharge(
        'club_cabin1', peopleInClubCabin1, numberOfOvernights());
  }

  double clubCabin2OccupancySurcharge() {
    return clubCabinOccupancySurcharge(
        'club_cabin2', peopleInClubCabin2, numberOfOvernights());
  }

  double clubCabinCasinoOccupancySurcharge() {
    return clubCabinOccupancySurcharge(
        'club_casino', peopleInClubCabinCasino, numberOfOvernights());
  }

  double clubCabinPetSurcharge(bool petInClubCabin) {
    double clubCabinPetSurcharge = 0;
    if (petInClubCabin) {
      clubCabinPetSurcharge = petSurchargeRate();
    }
    return monetaryAmountRounded(clubCabinPetSurcharge);
  }

  double clubCabin1PetSurcharge() {
    return clubCabinPetSurcharge(petInClubCabin1);
  }

  double clubCabin2PetSurcharge() {
    return clubCabinPetSurcharge(petInClubCabin2);
  }

  double clubCabinCasinoPetSurcharge() {
    return clubCabinPetSurcharge(petInClubCabinCasino);
  }

  double clubCabinDailyRate(String cabinName) {
    return (kCostRates[tripYear]['club_cabins']['cabin_rental_daily_rate']
            [cabinName])
        .toDouble();
  }

  double clubCabin1DailyRate() {
    return clubCabinDailyRate('club_cabin1');
  }

  String clubCabin1DailyRateAsString() {
    return clubCabinDailyRate('club_cabin1').toString();
  }

  double clubCabin2DailyRate() {
    return clubCabinDailyRate('club_cabin2');
  }

  String clubCabin2DailyRateAsString() {
    return clubCabinDailyRate('club_cabin2').toString();
  }

  double clubCabinCasinoDailyRate() {
    return clubCabinDailyRate('club_casino');
  }

  String clubCabinCasinoDailyRateAsString() {
    return clubCabinDailyRate('club_casino').toString();
  }

  int stdOccupancyClubCabin(String cabinName) {
    return (kCostRates[tripYear]['club_cabins']['cabin_person_capacity']
        [cabinName]);
  }

  int stdOccupancyClubCabin1() {
    return stdOccupancyClubCabin('club_cabin1');
  }

  String stdOccupancyClubCabin1AsString() {
    return stdOccupancyClubCabin1().toString();
  }

  int stdOccupancyClubCabin2() {
    return stdOccupancyClubCabin('club_cabin2');
  }

  String stdOccupancyClubCabin2AsString() {
    return stdOccupancyClubCabin1().toString();
  }

  int stdOccupancyClubCabinCasino() {
    return stdOccupancyClubCabin('club_casino');
  }

  String stdOccupancyClubCabinCasinoAsString() {
    return stdOccupancyClubCabinCasino().toString();
  }

  double additionalPersonSurchargeRate() {
    return (kCostRates[tripYear]['club_cabins']
            ['additional_person_daily_surcharge'])
        .toDouble();
  }

  String additionalPersonSurchargeRateAsString() {
    return additionalPersonSurchargeRate().toStringAsFixed(kCurrencyPrecision);
  }

  double petSurchargeRate() {
    return (kCostRates[tripYear]['club_cabins']['pet_surcharge_per_stay'])
        .toDouble();
  }

  String petSurchargeRateAsString() {
    return petSurchargeRate().toStringAsFixed(kCurrencyPrecision);
  }

  /* ------------------ beginning of gasoline methods ---------------------*/

  double totalGasCharge() {
    // return totalMemberBoatGasCharge() + totalRentalBoatGasCharges();
    return monetaryAmountRounded(gasPrice() * gasLiters);
  }

  double gasPrice() {
    return (kCostRates[tripYear]['gasoline_price_per_liter']).toDouble();
  }

  /*
  double totalRentalBoatGasCharges() {
    return monetaryAmountRounded(gasPrice() * rentalBoatGasLiters);
  }

  double totalMemberBoatGasCharge() {
    return monetaryAmountRounded(gasPrice() * memberBoatGasLiters);
  }

   */

  /* ----------------- beginning of member boat methods --------------------*/
  double totalMemberBoatCharge() {
    return totalMemberBoatInOutCharge() + totalMemberEngineWinterizeCharge();
  }

  double totalMemberBoatInOutCharge() {
    return memberBoatClass1InOutCharge() +
        memberBoatClass2InOutCharge() +
        memberBoatClass3InOutCharge();
  }

  double memberBoatInOutCharge(double rate, int boats) {
    return monetaryAmountRounded(rate * boats);
  }

  double memberBoatClass1InOutCharge() {
    double rate =
        (kCostRates[tripYear]['member_boats']['boat_class1_in_out']).toDouble();
    return memberBoatInOutCharge(rate, memberBoatClass1InOut);
  }

  double memberBoatClass2InOutCharge() {
    double rate =
        (kCostRates[tripYear]['member_boats']['boat_class2_in_out']).toDouble();
    return memberBoatInOutCharge(rate, memberBoatClass2InOut);
  }

  double memberBoatClass3InOutCharge() {
    double rate =
        (kCostRates[tripYear]['member_boats']['boat_class3_in_out']).toDouble();
    return memberBoatInOutCharge(rate, memberBoatClass3InOut);
  }

  double totalMemberEngineWinterizeCharge() {
    return memberEngineClass1WinterizeCharge() +
        memberEngineClass2WinterizeCharge();
  }

  double memberEngineWinterizeCharge(double rate, int engines) {
    return monetaryAmountRounded(rate * engines);
  }

  double memberEngineClass1WinterizeCharge() {
    double rate = (kCostRates[tripYear]['member_boats']
            ['engine_class1_winterize'])
        .toDouble();
    return memberEngineWinterizeCharge(rate, memberEngineClass1Winterize);
  }

  double memberEngineClass2WinterizeCharge() {
    double rate = (kCostRates[tripYear]['member_boats']
            ['engine_class2_winterize'])
        .toDouble();
    return memberEngineWinterizeCharge(rate, memberEngineClass2Winterize);
  }

  /* ------------------ beginning of boat rental methods ------------*/
  double totalRentalBoatCharges() {
    return totalRentalBoatRentCharges();
  }

  double totalRentalBoatRentCharges() {
    double boatChargeAccumulator = 0;
    if (rentalBoatList.isNotEmpty) {
      for (int i = 0; i < rentalBoatList.length; i++) {
        double dailyRate = (kCostRates[tripYear]["rental_boats"]
                [rentalBoatList[i]["rental_boat_type"]])
            .toDouble();
        int daysRental = rentalBoatList[i]["rental_boat_days"];
        double boatRentalCharge = monetaryAmountRounded(dailyRate * daysRental);
        boatChargeAccumulator = boatChargeAccumulator + boatRentalCharge;
      }
    }
    return boatChargeAccumulator;
  }

  /* ------------------- beginning of extras methods ----------------------*/

  double totalExtraCharges() {
    return totalTelephoneCharges() +
        totalInternetAccessCharges() +
        totalLaundryCharges() +
        totalMiscCharges();
  }

  double totalTelephoneCharges() {
    double pricePerCall =
        (kCostRates[tripYear]['telephone_call_charge']).toDouble();
    return monetaryAmountRounded(pricePerCall * telephoneCalls);
  }

  double totalInternetAccessCharges() {
    double price = (kCostRates[tripYear]['internet_access_charge']).toDouble();
    return monetaryAmountRounded(price * internetAccesses);
  }

  double totalLaundryCharges() {
    double price = (kCostRates[tripYear]['laundry_load_charge']).toDouble();
    return monetaryAmountRounded(price * laundryLoads);
  }

  double totalMiscCharges() {
    double totalCharges = 0;
    for (int i = 0; i < miscChargesList.length; i++) {
      String chargeAmtString = miscChargesList[i]['misc_charge_amt'];
      if (chargeAmtString.isNotEmpty) {
        double chargeAmt = NumberFormat().parse(chargeAmtString).toDouble();
        totalCharges = totalCharges + chargeAmt;
      }
    }
    return totalCharges;
  }

  /* ------------------- beginning of tip methods ------------------*/

  double tipTotal() {
    return tipAmt;
  }

  /* -------------beginning of card convenience fee methods --------*/

  double cardConvenienceFeeTotal() {
    return cardConvenienceFeeClub() + cardConvenienceFeeMgr();
  }

  double cardConvenienceRate() {
    return (kCostRates[tripYear]['card_convenience_fee_percentage']).toDouble();
  }

  double cardConvenienceFeeClub() {
    double fee = 0;
    if (payingWithCardClub) {
      fee = cardConvenienceRate() * cardTotalClub();
    }
    return monetaryAmountRounded(fee);
  }

  double cardConvenienceFeeMgr() {
    double fee = 0;
    if (payingWithCardClub) {
      fee = cardConvenienceRate() * cardTotalMgr();
    }
    return monetaryAmountRounded(fee);
  }

  /* -------------------beginning of step list -----------------------------*/

  List<Step> stepList() => [
        /* ------------------beginning of dates step -------------------------- */
        Step(
          title: const StepText(
            text: kTripCalendarStep,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                kCalendarInstruction,
                style: kInstructionTextStyle,
              ),
              SfDateRangePicker(
                selectionMode: DateRangePickerSelectionMode.range,
                initialSelectedRange:
                    PickerDateRange(arrivalDate, departureDate),
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                  setState(() {
                    tripYear = args.value.startDate.year;
                    arrivalDate = args.value.startDate;
                    departureDate = args.value.endDate;
                    widget.arrivalDate = arrivalDate;
                    widget.departureDate = departureDate;
                  });
                },
              )
            ],
          ),
        ),
        /* ------------------beginning of people step -------------------------- */
        Step(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const StepText(
                text: kNumberInPartyStep,
              ),
              Visibility(
                visible: totalPeople() > 0,
                child: Text(
                  totalPeople().toString(),
                  style: kStepTitleTextStyle,
                ),
              ),
            ],
          ),
          content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 4, 8),
                  child: Row(
                    children: const [
                      Text(
                        kNumberInPartyInstruction,
                        style: kInstructionTextStyle,
                      ),
                    ],
                  ),
                ),
                const Text(kMembers, style: kInstructionTextStyle),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(kAdultDescrLabel, style: kBodyTextStyle),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 4, 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    nNumAdults++;
                                    widget.nNumAdults = nNumAdults;
                                  });
                                }),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                nNumAdults.toString(),
                                style: kNumberTextStyle,
                              ),
                            ),
                            RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    if (nNumAdults > 0) {
                                      nNumAdults--;
                                    } else {
                                      nNumAdults = 0;
                                    }
                                    widget.nNumAdults = nNumAdults;
                                  });
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(kChildClass1DescrLabel, style: kBodyTextStyle),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 4, 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    nNumChildClass1++;
                                    widget.nNumChildClass1 = nNumChildClass1;
                                  });
                                }),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                nNumChildClass1.toString(),
                                style: kNumberTextStyle,
                              ),
                            ),
                            RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    if (nNumChildClass1 > 0) {
                                      nNumChildClass1--;
                                    } else {
                                      nNumChildClass1 = 0;
                                    }
                                    widget.nNumChildClass1 = nNumChildClass1;
                                  });
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(kChildClass2DescrLabel, style: kBodyTextStyle),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 4, 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    nNumChildClass2++;
                                    widget.nNumChildClass2 = nNumChildClass2;
                                  });
                                }),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                nNumChildClass2.toString(),
                                style: kNumberTextStyle,
                              ),
                            ),
                            RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    if (nNumChildClass2 > 0) {
                                      nNumChildClass2--;
                                    } else {
                                      nNumChildClass2 = 0;
                                    }
                                    widget.nNumChildClass2 = nNumChildClass2;
                                  });
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(kChildClass3DescrLabel, style: kBodyTextStyle),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 4, 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    nNumChildClass3++;
                                    widget.nNumChildClass3 = nNumChildClass3;
                                  });
                                }),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                nNumChildClass3.toString(),
                                style: kNumberTextStyle,
                              ),
                            ),
                            RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    if (nNumChildClass3 > 0) {
                                      nNumChildClass3--;
                                    } else {
                                      nNumChildClass3 = 0;
                                    }
                                    widget.nNumChildClass3 = nNumChildClass3;
                                  });
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(kChildClass4DescrLabel, style: kBodyTextStyle),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 4, 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    nNumChildClass4++;
                                    widget.nNumChildClass4 = nNumChildClass4;
                                  });
                                }),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                nNumChildClass4.toString(),
                                style: kNumberTextStyle,
                              ),
                            ),
                            RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    if (nNumChildClass4 > 0) {
                                      nNumChildClass4--;
                                    } else {
                                      nNumChildClass4 = 0;
                                    }
                                    widget.nNumChildClass4 = nNumChildClass4;
                                  });
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: !guestFeesWaived(),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 4, 4),
                    child: Text(
                      kGuests,
                      style: kInstructionTextStyle,
                    ),
                  ),
                ),
                Visibility(
                  visible: !guestFeesWaived(),
                  child: Row(
                    children: [
                      const Text(kGuestRegularDescr, style: kBodyTextStyle),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 4, 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              RoundIconButton(
                                  icon: FontAwesomeIcons.plus,
                                  onPressed: () {
                                    setState(() {
                                      nNumGuestRegular++;
                                      widget.nNumGuestRegular =
                                          nNumGuestRegular;
                                    });
                                  }),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  nNumGuestRegular.toString(),
                                  style: kNumberTextStyle,
                                ),
                              ),
                              RoundIconButton(
                                  icon: FontAwesomeIcons.minus,
                                  onPressed: () {
                                    setState(() {
                                      if (nNumGuestRegular > 0) {
                                        nNumGuestRegular--;
                                      } else {
                                        nNumGuestRegular = 0;
                                      }
                                      widget.nNumGuestRegular =
                                          nNumGuestRegular;
                                    });
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: !guestFeesWaived(),
                  child: Row(
                    children: [
                      const Text(kGuestJuniorDescr, style: kBodyTextStyle),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 4, 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              RoundIconButton(
                                  icon: FontAwesomeIcons.plus,
                                  onPressed: () {
                                    setState(() {
                                      nNumGuestJunior++;
                                      widget.nNumGuestJunior = nNumGuestJunior;
                                    });
                                  }),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  nNumGuestJunior.toString(),
                                  style: kNumberTextStyle,
                                ),
                              ),
                              RoundIconButton(
                                  icon: FontAwesomeIcons.minus,
                                  onPressed: () {
                                    setState(() {
                                      if (nNumGuestJunior > 0) {
                                        nNumGuestJunior--;
                                      } else {
                                        nNumGuestJunior = 0;
                                      }
                                      widget.nNumGuestJunior = nNumGuestJunior;
                                    });
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
        /* ------------------beginning of board step ---------------------- */
        Step(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const StepText(
                text: kBoardStepDescr,
              ),
              Visibility(
                visible: totalBoardCharges() != 0,
                child: Text(
                  totalBoardCharges().toStringAsFixed(kCurrencyPrecision),
                  style: kStepTitleTextStyle,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: Text(numberOfFullBoardDaysString()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(kArrivalDay),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                              value: includeArrivalDayBreakfast,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  includeArrivalDayBreakfast = newValue!;
                                  widget.includeArrivalDayBreakfast =
                                      includeArrivalDayBreakfast;
                                });
                              }),
                          Text(kBreakfastDescr),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                              value: includeArrivalDayLunch,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  includeArrivalDayLunch = newValue!;
                                  widget.includeArrivalDayLunch =
                                      includeArrivalDayLunch;
                                });
                              }),
                          Text(kLunchDescr)
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: includeArrivalDayDinner,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  includeArrivalDayDinner = newValue!;
                                  widget.includeArrivalDayDinner =
                                      includeArrivalDayDinner;
                                });
                              }),
                          Text(kDinnerDescr)
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(kDepartureDay),
                      Row(
                        children: [
                          Checkbox(
                              value: includeDepartureDayBreakfast,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  includeDepartureDayBreakfast = newValue!;
                                  widget.includeDepartureDayBreakfast =
                                      includeDepartureDayBreakfast;
                                });
                              }),
                          Text(kBreakfastDescr),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: includeDepartureDayLunch,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  includeDepartureDayLunch = newValue!;
                                  widget.includeDepartureDayLunch =
                                      includeDepartureDayLunch;
                                });
                              }),
                          Text(kLunchDescr)
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: includeDepartureDayDinner,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  includeDepartureDayDinner = newValue!;
                                  widget.includeDepartureDayDinner =
                                      includeDepartureDayDinner;
                                });
                              }),
                          Text(kDinnerDescr)
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        /* ------------------beginning of gas step ------------- */

        Step(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const StepText(
                text: kGasDescr,
              ),
              Visibility(
                visible: totalGasCharge() != 0,
                child: Text(
                  totalGasCharge().toStringAsFixed(kCurrencyPrecision),
                  style: kStepTitleTextStyle,
                ),
              ),
            ],
          ),
          content: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(kLitersDescr),
                Row(
                  children: [
                    RoundIconButton(
                        icon: FontAwesomeIcons.plus,
                        onPressed: () {
                          setState(() {
                            gasLiters = gasLiters + literIncrement;
                            widget.gasLiters = gasLiters;
                          });
                        }),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        gasLiters.toString(),
                        style: kNumberTextStyle,
                      ),
                    ),
                    RoundIconButton(
                        icon: FontAwesomeIcons.minus,
                        onPressed: () {
                          setState(() {
                            if (gasLiters > literIncrement) {
                              gasLiters = gasLiters - literIncrement;
                            } else {
                              gasLiters = 0;
                            }
                            widget.gasLiters = gasLiters;
                          });
                        }),
                  ],
                ),
              ],
            ),
          ]),
        ),
        /* ------------------beginning of member cabins step ------------- */
        Step(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const StepText(
                text: kMemberCabinDescr,
              ),
              Visibility(
                visible: totalMemberCabinCharge() != 0,
                child: Text(
                  totalMemberCabinCharge().toStringAsFixed(kCurrencyPrecision),
                  style: kStepTitleTextStyle,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: Row(
                  children: [
                    Checkbox(
                        value: memberCabinOnClubElectricity,
                        onChanged: (bool? newValue) {
                          setState(() {
                            memberCabinOnClubElectricity = newValue!;
                            widget.memberCabinOnClubElectricity =
                                memberCabinOnClubElectricity;
                          });
                        }),
                    const Text(kMemberCabinOnClubElectricity),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: Row(
                  children: [
                    Checkbox(
                        value: memberCabinOpenClose,
                        onChanged: (bool? newValue) {
                          setState(() {
                            memberCabinOpenClose = newValue!;
                            widget.memberCabinOpenClose = memberCabinOpenClose;
                          });
                        }),
                    Text(kMemberCabinOpenCloseDescr),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: Visibility(
                  visible: memberCabinOpenClose,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(kToiletsToWinterize),
                        Row(
                          children: [
                            RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    nNumOfToiletsToWinterize++;
                                    widget.nNumOfToiletsToWinterize =
                                        nNumOfToiletsToWinterize;
                                  });
                                }),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                nNumOfToiletsToWinterize.toString(),
                                style: kNumberTextStyle,
                              ),
                            ),
                            RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    if (nNumOfToiletsToWinterize > 0) {
                                      nNumOfToiletsToWinterize--;
                                    } else {
                                      nNumOfToiletsToWinterize = 0;
                                    }
                                    widget.nNumOfToiletsToWinterize =
                                        nNumOfToiletsToWinterize;
                                  });
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: Row(
                  children: [
                    Checkbox(
                        value: memberCabinCleaning,
                        onChanged: (bool? newValue) {
                          setState(() {
                            memberCabinCleaning = newValue!;
                            if (newValue) {
                              int minHours = (kCostRates[tripYear]
                                  ['member_cabins']['cleaning_minimum_hours']);
                              memberCabinCleaningHours = minHours;
                            } else {
                              memberCabinCleaningHours = 0;
                            }
                            widget.memberCabinCleaning = memberCabinCleaning;
                            widget.memberCabinCleaningHours =
                                memberCabinCleaningHours;
                          });
                        }),
                    Text(kMemberCabinCleaningDescr),
                  ],
                ),
              ),
              Visibility(
                visible: memberCabinCleaning,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(kCleaningHoursDescr),
                        Row(
                          children: [
                            RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    memberCabinCleaningHours++;
                                    widget.memberCabinCleaningHours =
                                        memberCabinCleaningHours;
                                  });
                                }),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                memberCabinCleaningHours.toString(),
                                style: kNumberTextStyle,
                              ),
                            ),
                            RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    int minHours = (kCostRates[tripYear]
                                            ['member_cabins']
                                        ['cleaning_minimum_hours']);
                                    if (memberCabinCleaningHours > minHours) {
                                      memberCabinCleaningHours--;
                                    } else {
                                      memberCabinCleaningHours = minHours;
                                    }
                                    widget.memberCabinCleaningHours =
                                        memberCabinCleaningHours;
                                  });
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                child: Row(
                  children: [
                    Checkbox(
                        value: firewood,
                        onChanged: (bool? newValue) {
                          setState(() {
                            firewood = newValue!;
                            if (firewood) {
                              firewoodCords = 1;
                              firewoodDeliveryHours = 1;
                            } else {
                              firewoodCords = 0;
                              firewoodDeliveryHours = 0;
                            }
                            widget.firewood = firewood;
                            widget.firewoodCords = firewoodCords;
                            widget.firewoodDeliveryHours =
                                firewoodDeliveryHours;
                          });
                        }),
                    Text(kFirewoodDescr),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                child: Visibility(
                  visible: firewood,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(12, 0, 0, 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(kFirewoodCordsDescr),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    firewoodCords++;
                                    widget.firewoodCords = firewoodCords;
                                  });
                                }),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                firewoodCords.toString(),
                                style: kNumberTextStyle,
                              ),
                            ),
                            RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    if (firewoodCords > 0) {
                                      firewoodCords--;
                                    } else {
                                      firewoodCords = 0;
                                    }
                                    widget.firewoodCords = firewoodCords;
                                  });
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                child: Visibility(
                  visible: firewood,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(kHoursToDeliverDescr),
                        Row(
                          children: [
                            RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    firewoodDeliveryHours++;
                                    widget.firewoodDeliveryHours =
                                        firewoodDeliveryHours;
                                  });
                                }),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                firewoodDeliveryHours.toString(),
                                style: kNumberTextStyle,
                              ),
                            ),
                            RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    if (firewoodDeliveryHours > 0) {
                                      firewoodDeliveryHours--;
                                    } else {
                                      firewoodDeliveryHours = 0;
                                    }
                                    widget.firewoodDeliveryHours =
                                        firewoodDeliveryHours;
                                  });
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                child: Row(
                  children: [
                    Checkbox(
                        value: propane,
                        onChanged: (bool? newValue) {
                          setState(() {
                            propane = newValue!;
                            if (propane) {
                              propaneTanks = 1;
                              propaneDeliveryCharge = 1;
                            } else {
                              propaneTanks = 0;
                              propaneDeliveryCharge = 0;
                            }
                            widget.propane = propane;
                            widget.propaneTanks = propaneTanks;
                            // widget.propaneDeliveryCharge = propaneDeliveryCharge;
                          });
                        }),
                    Text(kPropaneDescr),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                child: Visibility(
                  visible: propane,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(12, 0, 0, 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(kPropaneTanksDescr),
                        Row(
                          children: [
                            RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    propaneTanks++;
                                    widget.propaneTanks = propaneTanks;
                                  });
                                }),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                propaneTanks.toString(),
                                style: kNumberTextStyle,
                              ),
                            ),
                            RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    if (propaneTanks > 0) {
                                      propaneTanks--;
                                      propaneDeliveryCharge = 0;
                                    } else {
                                      propaneTanks = 0;
                                      propaneDeliveryCharge = 0;
                                    }
                                    widget.propaneTanks = propaneTanks;
                                    widget.propaneDeliveryCharge =
                                        propaneDeliveryCharge;
                                  });
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              /* commented this out; delivery charge is not changeable by user
              Visibility(
                visible: propane,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                  child: Row(
                    children: [
                      Text(kProppaneDeliveryDescr),
                      RoundIconButton(
                          icon: FontAwesomeIcons.plus,
                          onPressed: () {
                            setState(() {
                              propaneDeliveryCharge++;
                              widget.propaneDeliveryCharge =
                                  propaneDeliveryCharge;
                            });
                          }),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          propaneDeliveryCharge.toString(),
                          style: kNumberTextStyle,
                        ),
                      ),
                      RoundIconButton(
                          icon: FontAwesomeIcons.minus,
                          onPressed: () {
                            setState(() {
                              if (propaneDeliveryCharge > 0) {
                                propaneDeliveryCharge--;
                              } else {
                                propaneDeliveryCharge = 0;
                              }
                              widget.propaneDeliveryCharge =
                                  propaneDeliveryCharge;
                            });
                          }),
                    ],
                  ),
                ),
              ),
              */
            ],
          ),
        ),
        /* ------------------beginning of cabin rental step ---------------*/
        Step(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const StepText(
                text: kClubCabinRentalDescr,
              ),
              Visibility(
                visible: totalClubCabinRentalCharge() != 0,
                child: Text(
                    totalClubCabinRentalCharge()
                        .toStringAsFixed(kCurrencyPrecision),
                    style: kStepTitleTextStyle),
              )
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(kClubCabinRentalDescr),
              const Padding(
                padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: Text(kClubCabinStandardOccupanciesDescr),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                child: Text('$kClubCabin1Descr$kLabelEnderSymbol' +
                    ' ' +
                    stdOccupancyClubCabin1AsString()),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                child: Text('$kClubCabin2Descr$kLabelEnderSymbol' +
                    ' ' +
                    stdOccupancyClubCabin2AsString()),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                child: Text('$kClubCabinCasinoDescr$kLabelEnderSymbol' +
                    ' ' +
                    stdOccupancyClubCabinCasinoAsString()),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: Text(
                    '$kAdditionalPersonSurchargeStartDescr$kCurrencySymbol' +
                        additionalPersonSurchargeRateAsString() +
                        kAdditionalPersonSurchargeEndDescr),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: Text('$kPetSurchargeStartDescr$kCurrencySymbol' +
                    petSurchargeRateAsString() +
                    kPetSurchargeEndDescr),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: Row(
                  children: [
                    Checkbox(
                        value: rentalClubCabin1,
                        onChanged: (bool? newValue) {
                          setState(() {
                            rentalClubCabin1 = newValue!;
                            if (rentalClubCabin1 == false) {
                              peopleInClubCabin1 = 0;
                              petInClubCabin1 = false;
                            }
                            widget.peopleInClubCabin1 = peopleInClubCabin1;
                            widget.petInClubCabin1 = petInClubCabin1;
                            widget.rentalClubCabin1 = rentalClubCabin1;
                          });
                        }),
                    Text(kClubCabin1Descr),
                  ],
                ),
              ),
              Visibility(
                visible: rentalClubCabin1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: Row(
                    children: [
                      Row(children: [
                        Text(kNumberOfPeopleDescr),
                        RoundIconButton(
                            icon: FontAwesomeIcons.plus,
                            onPressed: () {
                              setState(() {
                                peopleInClubCabin1++;
                                widget.peopleInClubCabin1 = peopleInClubCabin1;
                              });
                            }),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            peopleInClubCabin1.toString(),
                            style: kNumberTextStyle,
                          ),
                        ),
                        RoundIconButton(
                            icon: FontAwesomeIcons.minus,
                            onPressed: () {
                              setState(() {
                                if (peopleInClubCabin1 > 0) {
                                  peopleInClubCabin1--;
                                } else {
                                  peopleInClubCabin1 = 0;
                                }
                                widget.peopleInClubCabin1 = peopleInClubCabin1;
                              });
                            }),
                      ])
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: rentalClubCabin1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: Row(children: [
                    Checkbox(
                        value: petInClubCabin1,
                        onChanged: (bool? newValue) {
                          setState(() {
                            petInClubCabin1 = newValue!;
                            widget.petInClubCabin1 = petInClubCabin1;
                          });
                        }),
                    Text(kPetsDescr),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: Row(
                  children: [
                    Checkbox(
                        value: rentalClubCabin2,
                        onChanged: (bool? newValue) {
                          setState(() {
                            rentalClubCabin2 = newValue!;
                            if (rentalClubCabin2 == false) {
                              peopleInClubCabin2 = 0;
                              petInClubCabin2 = false;
                            }
                            widget.peopleInClubCabin2 = peopleInClubCabin2;
                            widget.petInClubCabin2 = petInClubCabin2;
                            widget.rentalClubCabin2 = rentalClubCabin2;
                          });
                        }),
                    Text(kClubCabin2Descr)
                  ],
                ),
              ),
              Visibility(
                visible: rentalClubCabin2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: Row(
                    children: [
                      Row(children: [
                        Text(kNumberOfPeopleDescr),
                        RoundIconButton(
                            icon: FontAwesomeIcons.plus,
                            onPressed: () {
                              setState(() {
                                peopleInClubCabin2++;
                                widget.peopleInClubCabin2 = peopleInClubCabin2;
                              });
                            }),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            peopleInClubCabin2.toString(),
                            style: kNumberTextStyle,
                          ),
                        ),
                        RoundIconButton(
                            icon: FontAwesomeIcons.minus,
                            onPressed: () {
                              setState(() {
                                if (peopleInClubCabin2 > 0) {
                                  peopleInClubCabin2--;
                                } else {
                                  peopleInClubCabin2 = 0;
                                }
                                widget.peopleInClubCabin2 = peopleInClubCabin2;
                              });
                            }),
                      ])
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: rentalClubCabin2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: Row(children: [
                    Checkbox(
                        value: petInClubCabin2,
                        onChanged: (bool? newValue) {
                          setState(() {
                            petInClubCabin2 = newValue!;
                            widget.petInClubCabin2 = petInClubCabin2;
                          });
                        }),
                    Text(kPetsDescr),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: Row(
                  children: [
                    Checkbox(
                        value: rentalClubCabinCasino,
                        onChanged: (bool? newValue) {
                          setState(() {
                            rentalClubCabinCasino = newValue!;
                            if (rentalClubCabinCasino == false) {
                              peopleInClubCabinCasino = 0;
                              petInClubCabinCasino = false;
                            }
                            widget.peopleInClubCabinCasino =
                                peopleInClubCabinCasino;
                            widget.petInClubCabinCasino = petInClubCabinCasino;
                            widget.rentalClubCabinCasino =
                                rentalClubCabinCasino;
                          });
                        }),
                    Text(kClubCabinCasinoDescr)
                  ],
                ),
              ),
              Visibility(
                visible: rentalClubCabinCasino,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: Row(
                    children: [
                      Row(children: [
                        Text(kNumberOfPeopleDescr),
                        RoundIconButton(
                            icon: FontAwesomeIcons.plus,
                            onPressed: () {
                              setState(() {
                                peopleInClubCabinCasino++;
                                widget.peopleInClubCabinCasino =
                                    peopleInClubCabinCasino;
                              });
                            }),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            peopleInClubCabinCasino.toString(),
                            style: kNumberTextStyle,
                          ),
                        ),
                        RoundIconButton(
                            icon: FontAwesomeIcons.minus,
                            onPressed: () {
                              setState(() {
                                if (peopleInClubCabinCasino > 0) {
                                  peopleInClubCabinCasino--;
                                } else {
                                  peopleInClubCabinCasino = 0;
                                }
                                widget.peopleInClubCabinCasino =
                                    peopleInClubCabinCasino;
                              });
                            }),
                      ])
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: rentalClubCabinCasino,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: Row(children: [
                    Checkbox(
                        value: petInClubCabinCasino,
                        onChanged: (bool? newValue) {
                          setState(() {
                            petInClubCabinCasino = newValue!;
                            widget.petInClubCabinCasino = petInClubCabinCasino;
                          });
                        }),
                    Text(kPetsDescr),
                  ]),
                ),
              ),
            ],
          ),
        ),
        /* --------------beginning of member boats step ------------------- */
        Step(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const StepText(
                text: kMemberBoatDescr,
              ),
              Visibility(
                visible: totalMemberBoatCharge() != 0,
                child: Text(
                    totalMemberBoatCharge().toStringAsFixed(kCurrencyPrecision),
                    style: kStepTitleTextStyle),
              ),
            ],
          ),
          content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(kMemberBoatInOut),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 4),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(kMemberBoatClass1Descr),
                        Row(
                          children: [
                            RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    memberBoatClass1InOut++;
                                    widget.memberBoatClass1InOut =
                                        memberBoatClass1InOut;
                                  });
                                }),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                memberBoatClass1InOut.toString(),
                                style: kNumberTextStyle,
                              ),
                            ),
                            RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    if (memberBoatClass1InOut > 0) {
                                      memberBoatClass1InOut--;
                                    } else {
                                      memberBoatClass1InOut = 0;
                                    }
                                    widget.memberBoatClass1InOut =
                                        memberBoatClass1InOut;
                                  });
                                }),
                          ],
                        ),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 4),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(kMemberBoatClass2Descr),
                        Row(
                          children: [
                            RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    memberBoatClass2InOut++;
                                    widget.memberBoatClass2InOut =
                                        memberBoatClass2InOut;
                                  });
                                }),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                memberBoatClass2InOut.toString(),
                                style: kNumberTextStyle,
                              ),
                            ),
                            RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    if (memberBoatClass2InOut > 0) {
                                      memberBoatClass2InOut--;
                                    } else {
                                      memberBoatClass2InOut = 0;
                                    }
                                    widget.memberBoatClass2InOut =
                                        memberBoatClass2InOut;
                                  });
                                }),
                          ],
                        ),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 4),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(kMemberBoatClass3Descr),
                        Row(
                          children: [
                            RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    memberBoatClass3InOut++;
                                    widget.memberBoatClass3InOut =
                                        memberBoatClass3InOut;
                                  });
                                }),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                memberBoatClass3InOut.toString(),
                                style: kNumberTextStyle,
                              ),
                            ),
                            RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    if (memberBoatClass3InOut > 0) {
                                      memberBoatClass3InOut--;
                                    } else {
                                      memberBoatClass3InOut = 0;
                                    }
                                    widget.memberBoatClass3InOut =
                                        memberBoatClass3InOut;
                                  });
                                }),
                          ],
                        ),
                      ]),
                ),
                Text(kMemberEngineWinterizeDescr),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 4),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(kMemberEngineClass1Descr),
                        Row(
                          children: [
                            RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    memberEngineClass1Winterize++;
                                    widget.memberEngineClass1Winterize =
                                        memberEngineClass1Winterize;
                                  });
                                }),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                memberEngineClass1Winterize.toString(),
                                style: kNumberTextStyle,
                              ),
                            ),
                            RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    if (memberEngineClass1Winterize > 0) {
                                      memberEngineClass1Winterize--;
                                    } else {
                                      memberEngineClass1Winterize = 0;
                                    }
                                    widget.memberEngineClass1Winterize =
                                        memberEngineClass1Winterize;
                                  });
                                }),
                          ],
                        ),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(kMemberEngineClass2Descr),
                        Row(
                          children: [
                            RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    memberEngineClass2Winterize++;
                                    widget.memberEngineClass2Winterize =
                                        memberEngineClass2Winterize;
                                  });
                                }),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                memberEngineClass2Winterize.toString(),
                                style: kNumberTextStyle,
                              ),
                            ),
                            RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    if (memberEngineClass2Winterize > 0) {
                                      memberEngineClass2Winterize--;
                                    } else {
                                      memberEngineClass2Winterize = 0;
                                    }
                                    widget.memberEngineClass2Winterize =
                                        memberEngineClass2Winterize;
                                  });
                                }),
                          ],
                        ),
                      ]),
                ),
              ]),
        ),

        /* ------------------beginning of boat rental step ---------------------- */
        Step(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const StepText(
                text: kBoatRentalDescr,
              ),
              Visibility(
                visible: totalRentalBoatCharges() != 0,
                child: Text(
                    totalRentalBoatCharges()
                        .toStringAsFixed(kCurrencyPrecision),
                    style: kStepTitleTextStyle),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(kNewBoatRentalDescr),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  RoundIconButton(
                      icon: FontAwesomeIcons.plus,
                      onPressed: () {
                        setState(() {
                          Map<String, dynamic> rentalBoatListItem = {};
                          rentalBoatListItem["rental_boat_type"] =
                              kRentalBoatClass1Descr;
                          rentalBoatListItem["rental_boat_days"] = 0;
                          rentalBoatList.add(rentalBoatListItem);
                          widget.rentalBoatList = List.from(rentalBoatList);
                        });
                      }),
                ]),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: rentalBoatList.length,
                    itemBuilder: (context, index) {
                      Map rentalBoatListItem = rentalBoatList[index];
                      return Column(mainAxisSize: MainAxisSize.min, children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DropdownButton<String>(
                              value: rentalBoatListItem["rental_boat_type"],
                              hint: const Text('Pick a type of boat',
                                  style: kHintTextStyle),
                              onChanged: (String? newValue) {
                                setState(() {
                                  rentalBoatListItem["rental_boat_type"] =
                                      newValue!;
                                  widget.rentalBoatList =
                                      List.from(rentalBoatList);
                                });
                              },
                              items: rentalBoatType
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                    value: value, child: Text(value));
                              }).toList(),
                            ),
                            RoundedIconButton(
                                icon: Icons.delete,
                                onPressed: () => () {
                                      setState(() {
                                        rentalBoatList.removeAt(index);
                                      });
                                    }),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Days to Rent', style: kBodyTextStyle),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  RoundIconButton(
                                      icon: FontAwesomeIcons.plus,
                                      onPressed: () {
                                        setState(() {
                                          rentalBoatListItem[
                                                  "rental_boat_days"] =
                                              rentalBoatListItem[
                                                      "rental_boat_days"] +
                                                  1;
                                          widget.rentalBoatList =
                                              List.from(rentalBoatList);
                                        });
                                      }),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      rentalBoatList[index]["rental_boat_days"]
                                          .toString(),
                                      style: kNumberTextStyle,
                                    ),
                                  ),
                                  RoundIconButton(
                                      icon: FontAwesomeIcons.minus,
                                      onPressed: () {
                                        setState(() {
                                          if (rentalBoatList[index]
                                                  ["rental_boat_days"] >
                                              0) {
                                            rentalBoatList[index]
                                                    ["rental_boat_days"] =
                                                rentalBoatList[index]
                                                        ["rental_boat_days"] -
                                                    1;
                                          } else {
                                            rentalBoatList[index]
                                                ["rental_boat_days"] = 0;
                                          }
                                          widget.rentalBoatList =
                                              List.from(rentalBoatList);
                                        });
                                      }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ]);
                    }),
              ),
            ],
          ),

          // end of Column
        ),
        /* ------------------beginning of Extras step ------------------- */
        Step(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const StepText(
                text: kExtrasDescr,
              ),
              Visibility(
                visible: totalExtraCharges() != 0,
                child: Text(
                    totalExtraCharges().toStringAsFixed(kCurrencyPrecision),
                    style: kStepTitleTextStyle),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(kTelephoneDescr),
                    Row(
                      children: [
                        RoundIconButton(
                            icon: FontAwesomeIcons.plus,
                            onPressed: () {
                              setState(() {
                                telephoneCalls++;
                                widget.telephoneCalls = telephoneCalls;
                              });
                            }),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            telephoneCalls.toString(),
                            style: kNumberTextStyle,
                          ),
                        ),
                        RoundIconButton(
                            icon: FontAwesomeIcons.minus,
                            onPressed: () {
                              setState(() {
                                if (telephoneCalls > 0) {
                                  telephoneCalls--;
                                } else {
                                  telephoneCalls = 0;
                                }
                                widget.telephoneCalls = telephoneCalls;
                              });
                            }),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(kInternetDescr),
                    Row(
                      children: [
                        RoundIconButton(
                            icon: FontAwesomeIcons.plus,
                            onPressed: () {
                              setState(() {
                                internetAccesses++;
                                widget.internetAccesses = internetAccesses;
                              });
                            }),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            internetAccesses.toString(),
                            style: kNumberTextStyle,
                          ),
                        ),
                        RoundIconButton(
                            icon: FontAwesomeIcons.minus,
                            onPressed: () {
                              setState(() {
                                if (internetAccesses > 0) {
                                  internetAccesses--;
                                } else {
                                  internetAccesses = 0;
                                }
                                widget.internetAccesses = internetAccesses;
                              });
                            }),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(kLaundryDescr),
                    Row(
                      children: [
                        RoundIconButton(
                            icon: FontAwesomeIcons.plus,
                            onPressed: () {
                              setState(() {
                                laundryLoads++;
                                widget.laundryLoads = laundryLoads;
                              });
                            }),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            laundryLoads.toString(),
                            style: kNumberTextStyle,
                          ),
                        ),
                        RoundIconButton(
                            icon: FontAwesomeIcons.minus,
                            onPressed: () {
                              setState(() {
                                if (laundryLoads > 0) {
                                  laundryLoads--;
                                } else {
                                  laundryLoads = 0;
                                }
                                widget.laundryLoads = laundryLoads;
                              });
                            }),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Expanded(
                      child: Divider(
                        height: 20,
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      kAdditionalExpensesDescr,
                      style: kSubHeaderTextStyle,
                    ),
                    Expanded(
                      child: Divider(
                        height: 20,
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                RoundIconButton(
                    icon: FontAwesomeIcons.plus,
                    onPressed: () {
                      setState(() {
                        Map<String, dynamic> miscChargeListItem = {};
                        miscChargeListItem["misc_charge_descr"] = '';
                        miscChargeListItem["misc_charge_amt"] = '';

                        miscChargesList.add(miscChargeListItem);
                        //print("misc Charge in Add Misc Charge");
                        //print(miscChargesList);
                        widget.miscChargesList = List.from(miscChargesList);
                      });
                    }),
              ]),
              Flexible(
                fit: FlexFit.loose,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: miscChargesList.length,
                    itemBuilder: (context, index) {
                      Map miscChargesListItem = miscChargesList[index];
                      // print("in ListView.builder");
                      // print("miscChargesList length is");
                      // print(miscChargesList.length);
                      // print("index is");
                      // print(index);
                      // print("current miscChargesList[index] is");
                      // print(miscChargesList[index]);
                      return Column(mainAxisSize: MainAxisSize.min, children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                  initialValue:
                                      miscChargesListItem['misc_charge_descr'],
                                  maxLength: 30,
                                  decoration: const InputDecoration(
                                    hintText: kDescriptionDescr,
                                    hintStyle: kHintTextStyle,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      miscChargesListItem['misc_charge_descr'] =
                                          newValue!;
                                      widget.miscChargesList =
                                          List.from(miscChargesList);
                                    });
                                  }),
                            ),
                            Expanded(
                              child: TextFormField(
                                  initialValue:
                                      miscChargesListItem['misc_charge_amt']
                                          .toString(),
                                  maxLength: 9,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    hintText: kAmountDescr,
                                    hintStyle: kHintTextStyle,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      miscChargesListItem['misc_charge_amt'] =
                                          newValue!;
                                      widget.miscChargesList =
                                          List.from(miscChargesList);
                                    });
                                  }),
                            ),
                            RoundedIconButton(
                                icon: Icons.delete,
                                onPressed: () => () {
                                      setState(() {
                                        // int indexToDelete =
                                        //  miscChargesList.indexOf(index);
                                        // miscChargesList.removeAt(indexToDelete);
                                        miscChargesList.removeAt(index);
                                        // miscChargesList.removeWhere((item) =>
                                        //     item == miscChargesListItem);
                                      });
                                    }),

                            /*
                            BottomButton(
                                buttonTitle: 'Delete',
                                onPressed: () => () {
                                      // print("expense to delete is");
                                       print(miscChargesList[index]);
                                      setState(() {
                                        miscChargesList.removeAt(index);
                                      });
                                    }),
                            */
                          ],
                        ),
                      ]);
                    }),
              ),
            ],
          ),
        ),
        /* ------------------beginning of tip step -------------------- */
        Step(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const StepText(
                text: kTipDescr,
              ),
              Visibility(
                visible: tipTotal() != 0,
                child: Text(
                  tipTotal().toStringAsFixed(kCurrencyPrecision),
                  style: kStepTitleTextStyle,
                ),
              ),
            ],
          ),
          content: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(kTipDescr),
                  Spacer(),
                  Expanded(
                    child: TextFormField(
                        initialValue: tipAmt.toString(),
                        maxLength: 7,
                        keyboardType: TextInputType.number,
                        onChanged: (String? newValue) {
                          setState(() {
                            if (newValue!.isNotEmpty) {
                              tipAmt = double.parse(newValue);
                            } else {
                              tipAmt = 0;
                            }
                            widget.tipAmt = tipAmt;
                          });
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),

        /* ----------------- beginning of card convenience fee step ------*/
        Step(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const StepText(
                text: kCardConvenienceFeeDescr,
              ),
              Visibility(
                visible: cardConvenienceFeeTotal() != 0,
                child: Text(
                  cardConvenienceFeeTotal().toStringAsFixed(kCurrencyPrecision),
                  style: kStepTitleTextStyle,
                ),
              ),
            ],
          ),
          content: Column(
            children: [
              Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                      value: payingWithCardClub,
                      onChanged: (bool? newValue) {
                        setState(() {
                          payingWithCardClub = newValue!;
                          widget.payingWithCardClub = payingWithCardClub;
                        });
                      }),
                  Text(kPayingClubBillWithCardDescr),
                ],
              ),
              Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                      value: payingWithCardMgr,
                      onChanged: (bool? newValue) {
                        setState(() {
                          payingWithCardMgr = newValue!;
                          widget.payingWithCardMgr = payingWithCardMgr;
                        });
                      }),
                  Text(kPayingMgrBillWithCardDescr),
                ],
              ),
            ],
          ),
        ),

        /* ------------------beginning of Results step -------------------- */
        Step(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StepText(text: kResultsStep),
              Visibility(
                visible: grandTotal() != 0,
                child: Text(
                  grandTotal().toStringAsFixed(kCurrencyPrecision),
                  style: kStepTitleTextStyle,
                ),
              ),
            ],
          ),
          content: Column(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Visibility(
                  visible: grandTotalClub() != 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(kClubDescr, style: kSummarySubheaderTextStyle),
                          Text(
                            grandTotalClub()
                                .toStringAsFixed(kCurrencyPrecision),
                            style: kSummarySubheaderTextStyle,
                          ),
                        ],
                      ),
                      Visibility(
                        visible: memberCabinElectricityCharge() != 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(kElectricity),
                            Text(memberCabinElectricityCharge()
                                .toStringAsFixed(kCurrencyPrecision)),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: memberCabinFirewoodWoodCharge() != 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(kFirewoodDescr),
                            Text(memberCabinFirewoodWoodCharge()
                                .toStringAsFixed(kCurrencyPrecision)),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: memberCabinPropanePropaneCharge() != 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(kPropaneDescr),
                            Text(memberCabinPropanePropaneCharge()
                                .toStringAsFixed(kCurrencyPrecision)),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: taxTotalClub() != 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(kTaxesDescr),
                            Text(taxTotalClub()
                                .toStringAsFixed(kCurrencyPrecision)),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: cardConvenienceFeeClub() != 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(kCardConvenienceFeeDescrShort),
                            Text(cardConvenienceFeeClub()
                                .toStringAsFixed(kCurrencyPrecision)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Visibility(
                  visible: grandTotalMgr() != 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            kMgrDescr,
                            style: kSummarySubheaderTextStyle,
                          ),
                          Text(
                            grandTotalMgr().toStringAsFixed(kCurrencyPrecision),
                            style: kSummarySubheaderTextStyle,
                          ),
                        ],
                      ),
                      Visibility(
                        visible: totalBoardCharges() != 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(kBoardDescr),
                            Text(totalBoardCharges()
                                .toStringAsFixed(kCurrencyPrecision)),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: totalGuestFees() != 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(kGuestFeeDescr),
                            Text(totalGuestFees()
                                .toStringAsFixed(kCurrencyPrecision)),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: totalMemberCabinChargeMgr() != 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(kMemberCabinChargesDescr),
                            Text(totalMemberCabinChargeMgr()
                                .toStringAsFixed(kCurrencyPrecision)),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: totalClubCabinRentalCharge() != 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(kClubCabinRentalDescr),
                            Text(totalClubCabinRentalCharge()
                                .toStringAsFixed(kCurrencyPrecision)),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: totalGasCharge() != 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(kGasDescr),
                            Text(totalGasCharge()
                                .toStringAsFixed(kCurrencyPrecision)),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: totalMemberBoatCharge() != 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(kMemberBoatDescr),
                            Text(totalMemberBoatCharge()
                                .toStringAsFixed(kCurrencyPrecision)),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: totalRentalBoatCharges() != 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(kBoatRentalDescr),
                            Text(totalRentalBoatCharges()
                                .toStringAsFixed(kCurrencyPrecision)),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: totalExtraCharges() != 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(kExtrasDescr),
                            Text(totalExtraCharges()
                                .toStringAsFixed(kCurrencyPrecision)),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: taxTotalMgr() != 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(kTaxesDescr),
                            Text(taxTotalMgr()
                                .toStringAsFixed(kCurrencyPrecision)),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: cardConvenienceFeeMgr() != 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(kCardConvenienceFeeDescrShort),
                            Text(cardConvenienceFeeMgr()
                                .toStringAsFixed(kCurrencyPrecision)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(kTipDescr, style: kSummarySubheaderTextStyle),
                    Text(
                      tipTotal().toStringAsFixed(kCurrencyPrecision),
                      style: kSummarySubheaderTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ];

  /* --------------- end of step list ---------------------------------------*/

  @override
  void initState() {
    arrivalDate = widget.arrivalDate;
    departureDate = widget.departureDate;
    estimateName = widget.estimateName;
    nNumAdults = widget.nNumAdults;
    nNumChildClass1 = widget.nNumChildClass1;
    nNumChildClass2 = widget.nNumChildClass2;
    nNumChildClass3 = widget.nNumChildClass3;
    nNumChildClass4 = widget.nNumChildClass4;
    includeArrivalDayBreakfast = widget.includeArrivalDayBreakfast;
    includeArrivalDayLunch = widget.includeArrivalDayLunch;
    includeArrivalDayDinner = widget.includeArrivalDayDinner;
    includeDepartureDayBreakfast = widget.includeDepartureDayBreakfast;
    includeDepartureDayLunch = widget.includeDepartureDayLunch;
    includeDepartureDayDinner = widget.includeDepartureDayDinner;
    nNumGuestRegular = widget.nNumGuestRegular;
    nNumGuestJunior = widget.nNumGuestJunior;
    memberCabinOpenClose = widget.memberCabinOpenClose;
    memberCabinOnClubElectricity = widget.memberCabinOnClubElectricity;
    nNumOfToiletsToWinterize = widget.nNumOfToiletsToWinterize;
    memberCabinCleaning = widget.memberCabinCleaning;
    memberCabinCleaningHours = widget.memberCabinCleaningHours;
    rentalClubCabin1 = widget.rentalClubCabin1;
    peopleInClubCabin1 = widget.peopleInClubCabin1;
    petInClubCabin1 = widget.petInClubCabin1;
    rentalClubCabin2 = widget.rentalClubCabin2;
    peopleInClubCabin2 = widget.peopleInClubCabin2;
    petInClubCabin2 = widget.petInClubCabin2;
    rentalClubCabinCasino = widget.rentalClubCabinCasino;
    peopleInClubCabinCasino = widget.peopleInClubCabinCasino;
    petInClubCabinCasino = widget.petInClubCabinCasino;
    memberBoatClass1InOut = widget.memberBoatClass1InOut;
    memberBoatClass2InOut = widget.memberBoatClass2InOut;
    memberBoatClass3InOut = widget.memberBoatClass3InOut;
    memberEngineClass1Winterize = widget.memberEngineClass1Winterize;
    memberEngineClass2Winterize = widget.memberEngineClass2Winterize;
    rentalBoatList = widget.rentalBoatList;
    gasLiters = widget.gasLiters;
    telephoneCalls = widget.telephoneCalls;
    internetAccesses = widget.internetAccesses;
    laundryLoads = widget.laundryLoads;
    firewood = widget.firewood;
    firewoodCords = widget.firewoodCords;
    firewoodDeliveryHours = widget.firewoodDeliveryHours;
    propane = widget.propane;
    propaneTanks = widget.propaneTanks;
    propaneDeliveryCharge = widget.propaneDeliveryCharge;
    tipAmt = widget.tipAmt;
    payingWithCardClub = widget.payingWithCardClub;
    payingWithCardMgr = widget.payingWithCardMgr;
    miscChargesList = widget.miscChargesList;
  }

  /* -------------beginning of widget build------------------------ */

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kAppTitle2),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: estimateName,
                    style: kStepTitleTextStyle,
                    decoration: const InputDecoration(
                      hintText: kEstimateNameHint,
                      hintStyle: kHintTextStyle,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        if (newValue!.isNotEmpty) {
                          estimateName = newValue;
                        } else {
                          estimateName = '';
                        }
                        widget.estimateName = estimateName;
                        // estimateName = newValue!;
                        // widget.estimateName = estimateName;
                      });
                    },
                  ),
                ),
              ],
            ),
            Flexible(
              flex: 12,
              child: Stepper(
                controlsBuilder: (context, _) {
                  return Row(children: <Widget>[
                    Visibility(
                      visible: _activeCurrentStep < (stepList().length - 1),
                      child: TextButton(
                        onPressed: () {
                          if (_activeCurrentStep < (stepList().length - 1)) {
                            setState(() {
                              _activeCurrentStep += 1;
                            });
                          }
                        },
                        child: const Text('Next'),
                      ),
                    ),
                    Visibility(
                      visible: _activeCurrentStep > 0,
                      child: TextButton(
                        onPressed: () {
                          if (_activeCurrentStep == 0) {
                            return;
                          }
                          setState(() {
                            _activeCurrentStep -= 1;
                          });
                        },
                        child: const Text('Previous'),
                      ),
                    ),
                  ]);
                },
                type: StepperType.vertical,
                steps: stepList(),
                currentStep: _activeCurrentStep,
                onStepContinue: () {
                  if (_activeCurrentStep < (stepList().length - 1)) {
                    setState(() {
                      _activeCurrentStep += 1;
                    });
                  }
                },
                onStepCancel: () {
                  if (_activeCurrentStep == 0) {
                    return;
                  }
                  setState(() {
                    _activeCurrentStep -= 1;
                  });
                },
                onStepTapped: (int index) {
                  setState(() {
                    _activeCurrentStep = index;
                  });
                },
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                height: 100,
                // color: Colors.amber,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BottomButton(
                        buttonTitle: kSaveDescr, onPressed: () => saveAction),
                    BottomButton(
                        buttonTitle: kCancelDescr,
                        onPressed: () => discardAction)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
