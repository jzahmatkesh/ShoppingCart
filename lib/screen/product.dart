class Product {
    Product({
        this.id,
        this.name,
        this.note,
        this.price,
        this.off,
        this.picurl,
    });

    int id;
    String name;
    String note;
    double price;
    double off;
    String picurl;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        note: json["note"],
        price: json["price"],
        off: json["off"].toDouble(),
        picurl: json["picurl"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "note": note,
        "price": price,
        "off": off,
        "picurl": picurl,
    };

    static Future<List<Product>> loadData() async{
      return await Future.delayed(Duration(seconds: 3), (){
        return [
          Product(id: 1, name: 'power bank', note: '20000 MAH power bank', price: 123, off: 0.02, picurl: 'https://bornnordic.com/pub/media/catalog/product/cache/c4218f1997800f206b38e4323d8d1cf4/a/1/a1223g11-anker-powercore-select-2-port-10.000-mah-powerbank_-sort_1.jpg'),
          Product(id: 2, name: '36 Pack AAA', note: 'Amazon Basics 36 Pack AAA High-Performance Alkaline Batteries, 10-Year Shelf Life, Easy to Open Value Pack', price: 10.99, off: 0.05, picurl: 'https://images-na.ssl-images-amazon.com/images/I/71nDX36Y9UL._AC_SX679_.jpg'),
          Product(id: 3, name: '1500W Oscillating', note: 'AmazonBasics 1500W Oscillating Ceramic Heater with Adjustable Thermostat, Black', price: 32.99, off: 0.10, picurl: 'https://images-na.ssl-images-amazon.com/images/I/91jm6TmgkxL._AC_SX679_.jpg'),
          Product(id: 4, name: 'Low-Back Computer Task Office Desk Chair', note: 'AmazonBasics Low-Back Computer Task Office Desk Chair with Swivel Casters - Blue', price: 55.42, off: 0.20, picurl: 'https://images-na.ssl-images-amazon.com/images/I/71rpJTFtMgL._AC_SX679_.jpg'),
          Product(id: 5, name: 'iPhone Charging Cables 2Pack', note: 'iPhone Charging Cables 2Pack 3FT+6FT Fast Charger iPhone Cord MFi Certified Lightning USB Cable Braided Phone Charger for iPhone 12 Pro/12 Mini/11 Pro Max XS XR X 10 8 7 Plus 6s 6 5s SE iPad Pro Air', price: 7.99, off: 0.10, picurl: 'https://images-na.ssl-images-amazon.com/images/I/61eHHZS2YWL._AC_SX679_.jpg'),
          Product(id: 6, name: '23A Alkaline Battery', note: 'Amazon Basics 23A Alkaline Battery - Pack of 4', price: 6.19, off: 0.10, picurl: 'https://images-na.ssl-images-amazon.com/images/I/51ciiDjwK3L._AC_SX679_.jpg'),
          Product(id: 7, name: 'Humidifier', note: 'Amazon Basics Humidifier, 4 L, Black', price: 34.99, off: 0.10, picurl: 'https://images-na.ssl-images-amazon.com/images/I/71n3DlokliL._AC_SL1500_.jpg'),
          Product(id: 8, name: 'Basics 3-Button USB Wired Computer Mouse', note: 'Amazon Basics 3-Button USB Wired Computer Mouse (Black), 1-Pack', price: 10.24, off: 0.10, picurl: 'https://images-na.ssl-images-amazon.com/images/I/61i0CV-tKpL._AC_SX679_.jpg'),
        ];
      });
    }
}
