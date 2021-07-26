abstract class ApiConstants {
  // Authentication
  static const SERVER_URL = 'http://voidash.pythonanywhere.com';
  static const LOGIN = '/login/';
  static const LOGOUT = '/logout/';
  static const TEST = '/test/';
  static const NEW_REFRESH_KEYS = '/login/refresh/';

  // Category
  static const ADDCATEGORY = '/product/addcategory/';
  static const LISTCATEGORY = '/product/categorylist/';
  static const DELETECATEGORY = '/product/categorydelete/';
  static const UPDATECATEGORY = '/product/categoryupdate/';

  // SubCategory
  static const ADDSUBCATEGORY = '/product/addsubcategory/';
  static const LISTSUBCATEGORY = '/product/subcategorylist/';
  static const DELETESUBCATEGORY = '/product/subcategorydelete/';
  static const UPDATESUBCATEGORY = '/product/subcategoryupdate/';

  // Product
  static const ADDPRODUCT = '/product/addproduct/';
  static const LISTPRODUCT = '/product/productlist/';
  static const DELETEPRODUCT = '/product/productdelete/';
  static const UPDATEPRODUCT = '/product/productupdate/';

  // Staff
  static const LISTSTAFF = '/staff/stafflist/';
  static const UPDATESTAFF = '/staff/update_profile/';
  static const ADDSTAFF = '/staff/register/';
}
