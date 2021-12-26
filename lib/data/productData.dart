import 'package:usa_app/models/product_model.dart';

List<ProductModel> GetAllProducts() {
  List<ProductModel> products = [];
  ProductModel productModel = new ProductModel();

  //1
  productModel = new ProductModel();
  productModel.productName = "Bank OF XUWUDAWEI";
  productModel.productImage = "assets/images/app_logo.jpeg";
  productModel.date = "09/20";
  productModel.accountStatus = "active";
  productModel.productDescription = "Made with ❤️ by Xearth";
  products.add(productModel);

  //2
  productModel = new ProductModel();
  productModel.productName = "Bank OF XUWUDAWEI";
  productModel.productImage = "assets/images/app_logo.jpeg";
  productModel.date = "09/20";
  productModel.accountStatus = "blocked";
  productModel.productDescription = "Made with ❤️ by Xearth";
  products.add(productModel);

  //3
  productModel = new ProductModel();
  productModel.productName = "Bank OF XUWUDAWEI";
  productModel.productImage = "assets/images/app_logo.jpeg";
  productModel.date = "09/20";
  productModel.accountStatus = "suspended";
  productModel.productDescription = "Made with ❤️ by Xearth";
  products.add(productModel);

  //4
  productModel = new ProductModel();
  productModel.productName = "Bank OF XUWUDAWEI";
  productModel.productImage = "assets/images/app_logo.jpeg";
  productModel.date = "09/20";
  productModel.accountStatus = "active";
  productModel.productDescription = "Made with ❤️ by Xearth";
  products.add(productModel);

  //5
  productModel = new ProductModel();
  productModel.productName = "Bank OF XUWUDAWEI";
  productModel.productImage = "assets/images/app_logo.jpeg";
  productModel.date = "09/20";
  productModel.accountStatus = "suspended";
  productModel.productDescription = "Made with ❤️ by Xearth";
  products.add(productModel);

  return products;
}
