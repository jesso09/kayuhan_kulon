class GlobalApi {

  static final String baseUrl = 'https://kayuhankulon.kkn41uajy.cloud/kayuhan_kulon/public/api/';

  static String getBaseUrl() {
    return baseUrl;
  }
}

//for login purposes
class GlobalVar {
  static int userID = 0;
  static int idKK = 0;
  static String userName = '';
  static String userRole = '';
}

class DetailGlobal {
  static int idKK = 0;
}

class GlobalMessage {
  static String message = "";
}