import 'package:flutter/material.dart';
import 'package:os_basecode/os_basecode.dart';

TextStyle bebasNeue = GoogleFonts.bebasNeue(height: 0.9);
Color primaryColor = "#B0C929".toColor();
Color onPrimaryColor = "#2D4500".toColor();
EdgeInsets baseHorizontalPadding = EdgeInsets.symmetric(horizontal: 16);
List<String> anthusiastMessage = [
  "You’re an inspiration! This achievement is proof of your hard work and dedication. Keep striving for excellence!",
  "The peak is within sight, but your journey doesn’t end here. Become a legend in this gym!",
  "You’ve reached an extraordinary level. Inspire others by continuing to push your limits!"
];

List<String> beginnerMessage = [
  "Every great journey begins with a single step. Stay consistent and watch how small efforts create big changes!",
  "Be a champion for yourself. Keep moving forward and break through your limits!",
  "The path to greatness starts here. Don’t stop now—your future awaits!"
];
List<String> intermediateMessage = [
  "You’ve proven that consistency is the key. Keep going—the next level is within your reach!",
  "Your progress is inspiring! Stay motivated and show that you can achieve even more.",
  "Nothing is impossible if you keep trying. Maintain this momentum and conquer the highest level!"
];

enum GenderEnum { pria, wanita }

enum GoalEnum {
  menurunkanBeratBadan,
  membentukOtot,
  meningkatkanStaminta,
  relaksasiDanFleksibilitas,
  latihanUntukPemulihanCedera
}

enum ActivityLevelEnum { jarangOlahRaga, kadangOlahRaga, rutinOlahRaga }

enum WorkoutPreferenceEnum { latihanGym, latihanBebanTubuh, cardioIntens, kombinasi }

enum AvailableTimeEnum { tigaPuluhMenit, enamPuluhMenit, lebihDariEnamPuluhMenit }

enum WorkoutTimeEnum { pagi, siang, malam }

enum SpecialConditionsEnum { tidakAda, masalahCedera, masalahKesehatan }

enum MotivationEnum { kesehatan, penampilan, kebiasaanHidupSehat, aktivitasSosial }

enum HighIntensityWorkoutEnum { tidakNyaman, nyaman, sangatNyaman }

const geminiKey = 'AIzaSyC9BrMYUFeBhYrdAfdP7Gj-5buQv1BRE-g';
const baseURL = "http://192.168.0.9:5555/";
// const baseURL = "https://103.150.191.156:44444/";
String appVersion = "1.0.5";
//SHAREDPREFERENCE KEY
const accessToken = "access_token";
const refreshToken = "refresh_token";
const userIdKey = "user_id";

//API SECTION
const apiVersion = "v1";

const loginAPI = "auth/member/login";
const logoutAPI = "auth/logout";
const bookingsAPI = "$apiVersion/bookings";
const pricingPlanAPI = "$apiVersion/packages";
const memberAPI = "$apiVersion/members";
const redeemableItemAPI = "$apiVersion/redeemable-items";
const redeemHistoryAPI = "$apiVersion/redeem-histories";
const gymEquipmentAPI = "$apiVersion/gym-equipments";
const redeemHistoryByMemberAPI = "$redeemHistoryAPI/mobile";
const redeemableItemPaginatedAPI = "$redeemableItemAPI/mobile";
const memberAttendanceAPI = "$memberAPI/mobile/attendance";
const updateProfileAPI = "$memberAPI/mobile/update-profile";
const activitiesAPI = "$apiVersion/activities";
const pointsAPI = "$apiVersion/points";
const checkMemberByEmailAPI = "$memberAPI/mobile/check-member";
const redeemItemMemberAPI = "$memberAPI/mobile/redeem-item";
const activitiesByEmailAPI = "$activitiesAPI/mobile/by-code/";
const pointsByCodeAPI = "$pointsAPI/mobile/by-code/";
const checkBookingSlotLeftAPI = "$bookingsAPI/check";
const bookingByCodeAPI = "$bookingsAPI/by-code/";
