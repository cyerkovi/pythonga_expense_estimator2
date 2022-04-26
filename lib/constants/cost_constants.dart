import '../constants/text_constants.dart';

const String kAdult = 'Adult12+';
const String kChildClass1 = 'child9-11';
const String kChildClass2 = 'child4-8';
const String kChildClass3 = 'child1-4';
const String kChildClass4 = 'child<1';

const Map kCostRates = {
  2022: {
    'board_daily_rate': {
      kAdult: 47.00,
      kChildClass1: 42.51,
      kChildClass2: 29.00,
      kChildClass3: 17.00,
      kChildClass4: 0.00
    },
    'guest_fees': {
      'daily_fee_guest_of_reqular_member': 25,
      'daily_fee_guest_of_junior_member': 10,
      'minimum_number_of_days_charged_per_guest': 2,
      'maximum_daily_fee_per_guest_family': 50
    },
    'club_cabins': {
      'cabin_person_capacity': {
        'club_cabin1': 4,
        'club_cabin2': 4,
        'club_casino': 6
      },
      'cabin_rental_daily_rate': {
        'club_cabin1': 35,
        'club_cabin2': 35,
        'club_casino': 45
      },
      'additional_person_daily_surcharge': 5.00,
      'pet_surcharge_per_stay': 40.00,
    },
    'member_cabins': {
      'cabin_open_close_charge': 200.00,
      'toilet_winterization_charge': 15.00,
      'cabin_cleaning_hourly_rate': 45.00,
      'cleaning_minimum_hours': 3,
      'cabin_electricity_daily_rate': 10.00,
    },
    'member_boats': {
      'boat_class1_in_out': 75,
      'boat_class2_in_out': 90,
      'boat_class3_in_out': 125,
      'engine_class1_winterize': 35,
      'engine_class2_winterize': 55
    },
    'rental_boats': {
      kRentalBoatClass1Descr: 50,
      kRentalBoatClass2Descr: 100,
      kRentalBoatClass3Descr: 125
      // 'rentalBoatClass1DailyRate': 50,
      //  'rentalBoatClass2DailyRate': 100,
      //  'rentalBoatClass3DailyRate': 125
    },
    'battery_rental_daily_rate': 10,
    'gasoline_price_per_liter': 2.00,
    'firewood_face_cord_price': 250.00,
    'firewood_delivery_hourly_rate': 55.00,
    'propane_tank_price': 100.00,
    'propane_delivery_charge': 55.00,
    'telephone_call_charge': 2.00,
    'internet_access_charge': 20.00,
    'laundry_load_charge': 18.00,
    'gst_percentage': 0.05,
    'pst_percentage': 0.09975,
    'credit_card_fee_percentage': 0.0275
  },
};
