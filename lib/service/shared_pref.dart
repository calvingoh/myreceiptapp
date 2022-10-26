import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static String userIdKey = "USERKEY";
  static String userNameKey = "USERNAMEKEY";
  static String displayNameKey = "USERDISPLAYNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userProfilePicKey = "USERPROFILEPICKEY";
  static String userAddressKey = "USERADDRESSKEY";
  static String userPhoneKey = "USERPHONEKEY";
  static String userFoodKey = "USERFOODKEY";
  static String userTransportKey = "USERTRANSPORTKEY";
  static String userShoppingKey = "USERSHOPPINGKEY";
  static String userEntertainmentKey = "USERENTERTAINMENTKEY";
  static String userSpendKey = "USERSPENDKEY";
  static String userSaleKey = "USERSALEKEY";
  static String userRoleKey = "USERROLEKEY";

  //save data
  Future<bool> saveUserName(String getUserName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, getUserName);
  }

  Future<bool> saveUserEmail(String getUseremail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userEmailKey, getUseremail);
  }

  Future<bool> saveUserId(String getUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIdKey, getUserId);
  }

  Future<bool> saveDisplayName(String getDisplayName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(displayNameKey, getDisplayName);
  }

  Future<bool> saveUserRole(String getUserrole) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userRoleKey, getUserrole);
  }

  Future<bool> saveUserProfileUrl(String getUserProfile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userProfilePicKey, getUserProfile);
  }

  Future<bool> saveUserSpendUrl(String getUserSpend) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userSpendKey, getUserSpend);
  }

  Future<bool> saveUserSaleUrl(String getUserSale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userSaleKey, getUserSale);
  }

  Future<bool> saveUserFood(String getUserFood) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userFoodKey, getUserFood);
  }

  Future<bool> saveUserTransport(String getUserTransport) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userTransportKey, getUserTransport);
  }

  Future<bool> saveUserShopping(String getUserShopping) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userShoppingKey, getUserShopping);
  }

  Future<bool> saveUserEntertainment(String getUserEntertainment) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userEntertainmentKey, getUserEntertainment);
  }

  Future<bool> saveUserAddress(String getUserAddress) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userAddressKey, getUserAddress);
  }

  Future<bool> saveUserPhone(String getUserPhone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userPhoneKey, getUserPhone);
  }

  // get data
  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

  Future<String?> getUserSpend() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userSpendKey);
  }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  Future<String?> getUserSale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userSaleKey);
  }

  Future<String?> getDisplayName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(displayNameKey);
  }

  Future<String?> getUserProfileUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userProfilePicKey);
  }

  Future<String?> getUserFood() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userFoodKey);
  }

  Future<String?> getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userRoleKey);
  }

  Future<String?> getUserTransport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userTransportKey);
  }

  Future<String?> getUserShopping() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userShoppingKey);
  }

  Future<String?> getUserEntertainment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEntertainmentKey);
  }

  Future<String?> getUserAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userAddressKey);
  }

  Future<String?> getUserPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userPhoneKey);
  }
}
