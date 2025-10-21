import 'package:naila_pusing/models/service.dart';

class FacialTreatmentService extends Service {
  final String _skinType;
  final List<String> _treatments;

  FacialTreatmentService(
    String title,
    String description,
    String price,
    String duration,
    this._skinType,
    this._treatments,
    String image,
  ) : super(title, description, price, 'Facial Treatment', duration, '🧴', image);

  String get skinType => _skinType;
  List<String> get treatments => _treatments;

  @override
  String displayInfo() {
    return "🧴 Facial: $title → $price";
  }

  @override
  String getServiceType() {
    return "Professional Facial Treatment Service";
  }

  @override
  List<String> getServiceFeatures() {
    return [
      "Deep pore cleansing",
      "Professional skin analysis",
      "Customized treatment for $_skinType skin",
      "Relaxing facial massage",
      "Moisturizing and protection",
    ];
  }

  // Static method to get all facial treatment services
  static List<FacialTreatmentService> getAllFacialTreatmentServices() {
    return [
      FacialTreatmentService(
        "Deep Cleansing Facial",
        "Thorough facial cleansing and hydration",
        "Rp 300.000",
        "2 hours",
        "All Skin Types",
        ["Cleansing", "Exfoliation", "Extraction", "Mask"],
        'assets/deep cleansing facial.jpg',
      ),
      FacialTreatmentService(
        "Anti-Aging Facial",
        "Advanced treatment for mature skin",
        "Rp 450.000",
        "2.5 hours",
        "Mature Skin",
        ["Anti-Aging", "Firming", "Collagen Boost"],
        'assets/anti-aging facial.jpg',
      ),
      FacialTreatmentService(
        "Acne Treatment",
        "Specialized treatment for acne-prone skin",
        "Rp 350.000",
        "2 hours",
        "Acne-Prone",
        ["Deep Cleansing", "Acne Treatment", "Oil Control"],
        'assets/acne treatment.jpg',
      ),
    ];
  }
}
