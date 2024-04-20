/// seat_layout_id : ""
/// cols : 11
/// gap : 2
/// gap_col_index : 5
/// is_last_filled : true
/// row_beaks : [5,3,2]
/// rows : 10
/// seat_type : [{"price":95,"status":true,"title":"Thường"},{"price":100,"status":true,"title":"Vip"},{"price":120,"status":true,"title":"Vip Pro"}]

class SeatModel {
  SeatModel({
    String? seatLayoutId,
    int? cols,
    num? gap,
    int? gapColIndex,
    bool? isLastFilled,
    List<int>? rowBeaks,
    int? rows,
    List<SeatsType>? seatType,
    List<String>? seatSelected,
    String? movieId, // Thêm trường dữ liệu movie_id kiểu String
  }) {
    _seatLayoutId = seatLayoutId;
    _cols = cols;
    _gap = gap;
    _gapColIndex = gapColIndex;
    _isLastFilled = isLastFilled;
    _rowBeaks = rowBeaks;
    _rows = rows;
    _seatType = seatType;
    _seatSelected = seatSelected;
    _movieId = movieId; // Gán giá trị cho trường dữ liệu movie_id
  }

  SeatModel.fromJson(dynamic json) {
    _seatLayoutId = json['seat_layout_id'];
    _cols = json['cols'];
    _gap = json['gap'];
    _gapColIndex = json['gap_col_index'];
    _isLastFilled = json['is_last_filled'];
    _rowBeaks = json['row_beaks'] != null ? json['row_beaks'].cast<int>() : [];
    _rows = json['rows'];
    if (json['seat_type'] != null) {
      _seatType = [];
      json['seat_type'].forEach((v) {
        _seatType?.add(SeatsType.fromJson(v));
      });
    }
    _seatSelected = json['seat_selected'] != null ? json['seat_selected'].cast<String>() : [];
    _movieId = json['movie_id']; // Lấy giá trị cho trường dữ liệu movie_id
  }

  String? _seatLayoutId;
  int? _cols;
  num? _gap;
  int? _gapColIndex;
  bool? _isLastFilled;
  List<int>? _rowBeaks;
  int? _rows;
  List<SeatsType>? _seatType;
  List<String>? _seatSelected;
  String? _movieId; // Trường dữ liệu movie_id kiểu String

  SeatModel copyWith({
    String? seatLayoutId,
    int? cols,
    num? gap,
    int? gapColIndex,
    bool? isLastFilled,
    List<int>? rowBeaks,
    int? rows,
    List<SeatsType>? seatType,
    List<String>? seatSelected,
    String? movieId, // Thêm trường dữ liệu movie_id kiểu String
  }) =>
      SeatModel(
        seatLayoutId: seatLayoutId ?? _seatLayoutId,
        cols: cols ?? _cols,
        gap: gap ?? _gap,
        gapColIndex: gapColIndex ?? _gapColIndex,
        isLastFilled: isLastFilled ?? _isLastFilled,
        rowBeaks: rowBeaks ?? _rowBeaks,
        rows: rows ?? _rows,
        seatType: seatType ?? _seatType,
        seatSelected: seatSelected ?? _seatSelected,
        movieId: movieId ?? _movieId, // Gán giá trị cho trường dữ liệu movie_id
      );

  String? get seatLayoutId => _seatLayoutId;
  int? get cols => _cols;
  num? get gap => _gap;
  int? get gapColIndex => _gapColIndex;
  bool? get isLastFilled => _isLastFilled;
  List<int>? get rowBeaks => _rowBeaks;
  int? get rows => _rows;
  List<SeatsType>? get seatType => _seatType;
  List<String>? get seatSelected => _seatSelected;
  String? get movieId => _movieId; // Trường dữ liệu movie_id kiểu String

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['seat_layout_id'] = _seatLayoutId;
    map['cols'] = _cols;
    map['gap'] = _gap;
    map['gap_col_index'] = _gapColIndex;
    map['is_last_filled'] = _isLastFilled;
    map['row_beaks'] = _rowBeaks;
    map['rows'] = _rows;
    if (_seatType != null) {
      map['seat_type'] = _seatType?.map((v) => v.toJson()).toList();
    }
    map['seat_selected'] = _seatSelected;
    map['movie_id'] = _movieId; // Trường dữ liệu movie_id kiểu String
    return map;
  }
}


/// price : 95
/// status : true
/// title : "Thường"

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

  set status(bool? value) {
    _status = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['price'] = _price;
    map['status'] = _status;
    map['title'] = _title;
    return map;
  }
}
