import 'dart:convert';


class Item {
    String scanDate;
    String uuid;
    String itemName;
    String itemBrand;
    String giftValue;
    bool hasGift;
    String itemImage;
    Item({
      this.scanDate,
      this.uuid,
      this.itemName,
      this.itemBrand,
      this.itemImage,
      this.hasGift,
      this.giftValue,
    });

    factory Item.fromJson(Map<String, dynamic> json) => new Item(
      scanDate: json["scan_date"],
      uuid: json["uuid"],
      itemName: json["item_name"],
      itemBrand: json["item_brand"],
      itemImage: json["item_image"],
      hasGift: json["has_gift"],
      giftValue: json["gift_value"].toString(),
    );
}