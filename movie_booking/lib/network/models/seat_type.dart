import 'package:intl/intl.dart';

class SeatsType {
  SeatsType({
    num? price,
    bool? status,
    String? title,
  }) {
    _price = price;
    _status = status;
    _title = title;
  }

  SeatsType.fromJson(dynamic json) {
    _price = json['price'];
    _status = json['status'];
    _title = json['title'];
  }
  num? _price;
  bool? _status;
  String? _title;
  SeatsType copyWith({
    num? price,
    bool? status,
    String? title,
  }) =>
      SeatsType(
        price: price ?? _price,
        status: status ?? _status,
        title: title ?? _title,
      );
  num? get price => _price;
  bool? get status => _status;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['price'] = _price;
    map['status'] = _status;
    map['title'] = _title;
    return map;
  }

  String formatPriceInVND() {
    if (_price != null) {
      final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
      return formatter.format(_price);
    }
    return '';
  }

}
