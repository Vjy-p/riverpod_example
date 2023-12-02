import 'package:example_riverpod/services/Common/commonServices.dart';
import 'package:example_riverpod/utils/constants.dart';

class ProductServices {
  getAllProducts() async {
    return CommonServices()
        .getUrl(url: Uri.parse("${Constants.baseUrl}products?limit=10"));
  }

  // Future getProduct(id) async {
  //   final response =
  //       await http.get(Uri.parse("${Constants.baseUrl}products/$id"));
  //   debugPrint("\nresponse : ${response.body}");
  //   if (response.statusCode == 200) {
  //     return SingleProductModel.fromJson(jsonDecode(response.body));
  //   } else {
  //     debugPrint("\nError ${response.statusCode}");
  //     return null;
  //   }
  // }

  // Future getSearchData(search) async {
  //   final response = await http
  //       .get(Uri.parse("${Constants.baseUrl}products/search?q=$search"));
  //   debugPrint("\nresponse : ${response.body}");
  //   if (response.statusCode == 200) {
  //     return ProductsModel.fromJson(jsonDecode(response.body));
  //   } else {
  //     debugPrint("\nError ${response.statusCode}");
  //     return null;
  //   }
  // }
}
