import 'dart:convert';


class Item {
    int id;
    String scanDate;
    String uuid;
    String itemName;
    String itemBrand;
    String giftValue;
    bool hasGift;
    int totalGift;
    String itemImage;
    Item({
      this.id,
      this.scanDate,
      this.uuid,
      this.itemName,
      this.itemBrand,
      this.itemImage,
      this.hasGift,
      this.totalGift,
      this.giftValue,
    });

    factory Item.fromJson(Map<String, dynamic> json) => new Item(
      id: json["id"],
      scanDate: json["scan_date"],
      uuid: json["uuid"],
      itemName: json["item_name"],
      itemBrand: json["item_brand"],
      itemImage: json["item_image"],
      hasGift: json["has_gift"],
      totalGift: json["total_gifts"],
      giftValue: json["gift_value"].toString(),
    );
}