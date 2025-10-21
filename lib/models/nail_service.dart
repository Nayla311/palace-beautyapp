import 'package:palace_beautyapp/models/service.dart';

class NailCareService extends Service {
  final bool _includesArt;
  final List<String> _nailTypes;

  NailCareService(
    String title,
    String description,
    String price,
    String duration,
    this._includesArt,
    this._nailTypes,
    String image,
  ) : super(title, description, price, 'Nail Care', duration, '💅', image);

  bool get includesArt => _includesArt;
  List<String> get nailTypes => _nailTypes;

  @override
  String displayInfo() {
    return "💅 Nail Care: $title → $price";
  }

  @override
  String getServiceType() {
    return "Professional Nail Care Service";
  }

  @override
  List<String> getServiceFeatures() {
    return [
      "Professional manicure & pedicure",
      "Nail shaping and cuticle care",
      "Base and top coat application",
      if (_includesArt) "Custom nail art design",
      "Hand and foot massage",
    ];
  }

  // Static method to get all nail care services
  static List<NailCareService> getAllNailCareServices() {
    return [
      NailCareService(
        "Luxury Nail Art",
        "Premium manicure with custom nail art design",
        "Rp 200.000",
        "2 hours",
        true,
        ["Gel", "Acrylic", "Natural"],
        'assets/luxury nailart.JPG',
      ),
      NailCareService(
        "Basic Manicure",
        "Essential nail care and polish",
        "Rp 100.000",
        "1 hour",
        false,
        ["Regular Polish", "Natural"],
        'assets/basic manicure.jpg',
      ),
      NailCareService(
        "Spa Pedicure",
        "Relaxing foot treatment with nail care",
        "Rp 150.000",
        "1.5 hours",
        false,
        ["Spa Treatment", "Regular Polish"],
        'assets/spa pedicure.jpg',
      ),
    ];
  }
}
