// Future<List<Product>> fetchProduct() async {
//   idUser() => GetStorage('id');
//   final response = await http
//       .post(Uri.parse('http://66.42.50.59/api/listProduct'), headers: {
//     "Accept": "application/json",
//   }, body: {
//     "id": idUser,
//   });

//   if (response.statusCode == 200) {
//     // final parsed =
//     //     json.decode(response.body)['data'].cast<Map<String, dynamic>>();

//     return Product.fromJsonList(jsonDecode(response.body)['data'] as List);
//   } else {
//     throw Exception('Failed to load Product');
//   }
// }



// List<Product> demoProducts = [
//   Product(
//     id: 1,
//     images: [
//       "assets/images/ps4_console_white_1.png",
//       "assets/images/ps4_console_white_2.png",
//       "assets/images/ps4_console_white_3.png",
//       "assets/images/ps4_console_white_4.png",
//     ],
//     colors: [
//       Color(0xFFF6625E),
//       Color(0xFF836DB8),
//       Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     title: "Wireless Controller for PS4™",
//     price: "64.000",
//     description: description,
//     stock: 0,
//     isFavourite: true,
//     isPopular: true,
//   ),
//   Product(
//     id: 2,
//     images: [
//       "assets/images/Image Popular Product 2.png",
//     ],
//     colors: [
//       Color(0xFFF6625E),
//       Color(0xFF836DB8),
//       Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     title: "Nike Sport White - Man Pant",
//     price: "50.000",
//     description: description,
//     stock: 100,
//     isPopular: true,
//   ),
//   Product(
//     id: 3,
//     images: [
//       "assets/images/glap.png",
//     ],
//     colors: [
//       Color(0xFFF6625E),
//       Color(0xFF836DB8),
//       Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     title: "Gloves XC Omega - Polygon",
//     price: "36.000",
//     description: description,
//     stock: 100,
//     isFavourite: true,
//     isPopular: true,
//   ),
//   Product(
//     id: 4,
//     images: [
//       "assets/images/wireless headset.png",
//     ],
//     colors: [
//       Color(0xFFF6625E),
//       Color(0xFF836DB8),
//       Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     title: "Logitech Head",
//     price: "20.000",
//     description: description,
//     stock: 100,
//     isFavourite: true,
//   ),
// ];
