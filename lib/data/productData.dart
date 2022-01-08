import 'package:intl/intl.dart';
import 'package:usa_app/models/product_model.dart';

List<ProductModel> GetAllProducts() {
  List<ProductModel> products = [];
  ProductModel productModel = new ProductModel();

  //1
  productModel = new ProductModel();
  productModel.appName = "Bank of David";
  productModel.sessionId = "usa001001001";
  productModel.date = DateTime.now();
  productModel.accountStatus = 1;
  products.add(productModel);

  //2
  productModel = new ProductModel();
  productModel.sessionId = "usa001001001";
  productModel.appName = "Bank of America";
  productModel.date = DateTime.now();
  productModel.accountStatus = 1;

  products.add(productModel);

  //3
  productModel = new ProductModel();
  productModel.sessionId = "usa001001001";
  productModel.appName = "Bank of Ivory Coast";
  productModel.date = DateTime.now();
  productModel.accountStatus = 1;

  products.add(productModel);

  //4
  productModel = new ProductModel();
  productModel.sessionId = "usa001001001";
  productModel.appName = "Bank of Ghana";
  productModel.date = DateTime.now();
  productModel.accountStatus = 1;

  products.add(productModel);

  //5
  productModel = new ProductModel();
  productModel.sessionId = "usa001001001";
  productModel.appName = "Bank of Nigeria";
  productModel.date = DateTime.now();
  productModel.accountStatus = 1;

  products.add(productModel);

  //6
  productModel = new ProductModel();
  productModel.sessionId = "usa001001001";
  productModel.appName = "Bank of Ivory Coast";
  productModel.date = DateTime.now();
  productModel.accountStatus = 0;

  products.add(productModel);

  //7
  productModel = new ProductModel();
  productModel.sessionId = "usa001001001";
  productModel.appName = "Bank of Ghana";
  productModel.date = DateTime.now();
  productModel.accountStatus = 0;

  products.add(productModel);

  //8
  productModel = new ProductModel();
  productModel.sessionId = "usa001001001";
  productModel.appName = "Bank of Ivory Coast";
  productModel.date = DateTime.now();
  productModel.accountStatus = 0;

  products.add(productModel);

  //9
  productModel = new ProductModel();
  productModel.sessionId = "usa001001001";
  productModel.appName = "Bank of Ghana";
  productModel.date = DateTime.now();
  productModel.accountStatus = 0;

  products.add(productModel);

  //10
  productModel = new ProductModel();
  productModel.sessionId = "usa001001001";
  productModel.appName = "Bank of Nigeria";
  productModel.date = DateTime.now();
  productModel.accountStatus = 0;

  products.add(productModel);

  return products.where((element) => element.accountStatus == 1).toList();
}
