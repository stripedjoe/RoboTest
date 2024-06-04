class Product {
  final String name;
  final String imageUrl;
  final String category;
  final String numberEquivalent;

  const Product(
      {required this.name,
      required this.imageUrl,
      required this.category,
      required this.numberEquivalent});

  Product.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        imageUrl = json['imageUrl'] as String,
        category = json['category'] as String,
        numberEquivalent = json['numberEquivalent'] as String;

  Map<String, dynamic> toJson() => {
        'name': name,
        'imageUrl': imageUrl,
        'category': category,
        'numberEquivalent': numberEquivalent
      };
}

final List<Product> productsItems = [
  const Product(
    name: 'Jacket 1',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/party%2Fjacket1.png?alt=media&token=a37b4f10-293d-4975-b676-119556fa20ac',
    category: 'Party',
    numberEquivalent: '11',
  ),
  const Product(
    name: 'Jacket 2',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/party%2Fjacket2.jpg?alt=media&token=9dde9e0d-3199-4f2f-87f5-dccd83d984eb',
    category: 'Party',
    numberEquivalent: '12',
  ),
  const Product(
    name: 'Blazer and Pants',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/party%2Fblazerandpants.jpg?alt=media&token=61628aed-36d8-4dac-b682-acd94823486a',
    category: 'Party',
    numberEquivalent: '13',
  ),
  const Product(
    name: 'Dress 1',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/party%2Fdress1.jpg?alt=media&token=cb71b130-5ef3-4a14-ab4a-b0cb22efec2b',
    category: 'Party',
    numberEquivalent: '14',
  ),
  const Product(
    name: 'Dress 2',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/party%2Fdress2.jpg?alt=media&token=e5c771f9-54e1-40ac-9f2c-6ca923b69538',
    category: 'Party',
    numberEquivalent: '15',
  ),
  const Product(
    name: 'Dress 3',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/party%2Fdress3.jpg?alt=media&token=110f351e-9035-43a8-a96f-23d087403036',
    category: 'Party',
    numberEquivalent: '16',
  ),
  const Product(
    name: 'Dress 4',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/party%2Fdress4.png?alt=media&token=68a8ce82-ba70-4268-b8ff-c52bd769c28e',
    category: 'Party',
    numberEquivalent: '17',
  ),
  const Product(
    name: 'Wedding 1',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/wedding%2Fwedding1.png?alt=media&token=da464a44-dda6-44a4-af14-cf61936fab93',
    category: 'Wedding',
    numberEquivalent: '18',
  ),
  const Product(
    name: 'Wedding 2',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/wedding%2Fwedding2.png?alt=media&token=0336e2d9-fba4-4049-8460-ea341e3e6cfb',
    category: 'Wedding',
    numberEquivalent: '19',
  ),
  const Product(
    name: 'Wedding 3',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/wedding%2Fwedding3.png?alt=media&token=5f9205e8-692d-4923-99c8-3f42c3218e0b',
    category: 'Wedding',
    numberEquivalent: '20',
  ),
  const Product(
    name: 'Wedding 4',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/wedding%2Fwedding4.png?alt=media&token=78da2099-2a2a-489a-9416-296028034879',
    category: 'Wedding',
    numberEquivalent: '21',
  ),
  const Product(
    name: 'Business 1',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/business%2Fbusiness1.png?alt=media&token=c30d4f17-6a1e-42fb-b723-1436873c1e5f',
    category: 'Business',
    numberEquivalent: '22',
  ),
  const Product(
    name: 'Business 2',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/business%2Fbusiness2.png?alt=media&token=2e4b7e7d-e981-41b4-9550-2a7f974a3095',
    category: 'Business',
    numberEquivalent: '23',
  ),
  const Product(
    name: 'Business 3',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/business%2Fbusiness3.png?alt=media&token=a3c634e3-8d9b-4d56-87d5-289fe558eaf4',
    category: 'Business',
    numberEquivalent: '24',
  ),
  const Product(
    name: 'Business 4',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/business%2Fbusiness4.png?alt=media&token=f666dae1-fdf2-4060-9dc5-42f27738df93',
    category: 'Business',
    numberEquivalent: '25',
  ),
  const Product(
    name: 'Beach 1',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/beach%2Fbeach1.png?alt=media&token=d2f5d06c-0b00-48b2-aa47-d07522e30e2b',
    category: 'Beach',
    numberEquivalent: '26',
  ),
  const Product(
    name: 'Beach 2',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/beach%2Fbeach2.png?alt=media&token=c52c3d40-58ad-44bd-9ad9-8b4d93507577',
    category: 'Beach',
    numberEquivalent: '27',
  ),
  const Product(
    name: 'Beach 3',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/beach%2Fbeach3.png?alt=media&token=acce52de-44bc-4ae5-a732-f9dad4ec3f37',
    category: 'Beach',
    numberEquivalent: '28',
  ),
  const Product(
    name: 'Beach 4',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/beach%2Fbeach4.png?alt=media&token=4b34d5c0-d4c1-4310-8d32-61b8d2970e39',
    category: 'Beach',
    numberEquivalent: '29',
  ),
  const Product(
    name: 'Sports 1',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/sports%2Fsports1.jpg?alt=media&token=00ff60bf-e429-47ff-a109-efc416c4bd32',
    category: 'Sports',
    numberEquivalent: '30',
  ),
  const Product(
    name: 'Sports 2',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/sports%2Fsports2.jpg?alt=media&token=e16a570b-339a-4840-ba3d-e52ef1a64e1b',
    category: 'Sports',
    numberEquivalent: '31',
  ),
  const Product(
    name: 'Sports 3',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/sports%2Fsports3.png?alt=media&token=928a2da1-9e01-405b-b117-d9bed091928b',
    category: 'Sports',
    numberEquivalent: '32',
  ),
  const Product(
    name: 'Sports 4',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/sports%2Fsports4.png?alt=media&token=d83efb3c-83be-4b57-a875-6db478b56c57',
    category: 'Sports',
    numberEquivalent: '33',
  ),
];
