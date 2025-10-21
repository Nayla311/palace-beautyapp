import 'package:naila_pusing/models/service.dart';

class MakeUpService extends Service {
  final List<String> _makeupTypes;
  final bool _includesLashes;

  MakeUpService(
    String title,
    String description,
    String price,
    String duration,
    this._makeupTypes,
    this._includesLashes,
    String image,
  ) : super(title, description, price, 'Make Up Artist', duration, '💄', image);

  List<String> get makeupTypes => _makeupTypes;
  bool get includesLashes => _includesLashes;

  @override
  String displayInfo() {
    return "💄 Make Up: $title → $price";
  }

  @override
  String getServiceType() {
    return "Professional Make Up Artist Service";
  }

  @override
  List<String> getServiceFeatures() {
    return [
      "Professional makeup application",
      "High-quality cosmetic products",
      "Customized look for your occasion",
      if (_includesLashes) "Free eyelash application",
      "Touch-up kit included",
    ];
  }

  // Static method to get all makeup services
  static List<MakeUpService> getAllMakeUpServices() {
    return [
      MakeUpService(
        "Wedding Makeup",
        "Complete bridal makeup package with premium products",
        "Rp 500.000",
        "3 hours",
        ["Bridal", "Natural", "Glamour"],
        true,
        'assets/wedding makeup.JPG',
      ),
      MakeUpService(
        "Party Makeup",
        "Stunning makeup for special occasions",
        "Rp 300.000",
        "2 hours",
        ["Party", "Evening", "Bold"],
        false,
        'assets/party makeup.jpg',
      ),
      MakeUpService(
        "Daily Makeup",
        "Natural everyday makeup look",
        "Rp 200.000",
        "1 hour",
        ["Natural", "Casual", "Light"],
        false,
        'assets/daily makeup.jpg',
      ),
    ];
  }
}
