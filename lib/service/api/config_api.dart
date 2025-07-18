// class Config {
//   static const String testUrl = 'http://15.185.194.45:8000';
//   static const String createSendOtp = '/api/v1/auth/send-otp';
//   static const String createVerifyUser = '/api/v1/auth/verify-otp';

//   static const String login = '/api/v1/auth/login-otp';
//   static const String loginUser = '/api/v1/auth/login';

//   static const String verifyEmail = '/api/v1/auth/send-verification';

// /*  static const String forgotSendOtp = '$testUrl/api/v1/auth/send-reset-otp';
//   static const String forgotVerifyOtp = '$testUrl/api/v1/auth/verify-reset-otp';
//   static const String resetOtp = '$testUrl/api/v1/auth/reset-password';
//   static const String updatePassword = '$testUrl/api/v1/users/updatePassword';*/

//   static const String updateProfile = '$testUrl/api/v1/users/updateProfile/';

//   static const String getAllCategories = '/api/v1/categoryRoute/getAllCategory';
//   static const String getSubCategories = '/api/v1/categoryRoute/getSubcategory?category=';
//   static const String getBrand = '/api/v1/categoryRoute/getBrand?category=';
//   static const String getCategoriesKey = '/api/v1/categoryRoute/getCategoryData?category=';
//   static const String addData = '/api/v1/categoryRoute/addData';
//   static const String searchProductsAuctions = '/api/v1/home/search-products-auctions?';

//   static const String getProductByCategory = '/api/v1/product/allProduct?category=';
//   static const String addComment = '/api/v1/comment/';
//   static const String sendReply = '/api/v1/comment/reply/';

//   static const String addFavCategory = '/api/v1/users/addFavorite';
//   static const String getAllFavCategory = '/api/v1/users/getAllFavCategory';
//   static const String getAllFavProduct = '/api/v1/users/getAllFavProduct';

//   static const String bid = '/api/v1/product/bid';
//   static const String getUsersAds = '/api/v1/ads/getUsersAds';
//   static const String getAllProduct = '/api/v1/home/getAllProduct?page=';
//   static const String getProductDetails = '/api/v1/product/';

//   static const String getUserDetails = '/api/v1/users/';
//   static const String getAppDetails = '/api/v1/appdetails/';
// }

class Env {
  final String baseUrl;

  Env({required this.baseUrl});
}

class EnvValue {
  static final Env development = Env(baseUrl: "http://82.25.104.152");

  static final Env production = Env(baseUrl: "http://82.25.104.152");
}
