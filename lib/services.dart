import 'package:http/http.dart' as http;
import 'json_data.dart';

class Services {
  static const String url =
      "https://forbes400.onrender.com/api/forbes400?limit=100";

  static Future<List<Billionaire>?> getBillionaire() async {
    try {
      // Convert the URL string to a Uri
      final response = await http.get(Uri.parse(url)).timeout(
            const Duration(
                seconds: 10), // Add timeout to prevent indefinite waits
          );

      if (response.statusCode == 200) {
        // Parse response body if the status is 200 (OK)
        return billionaireFromJson(response.body);
      } else {
        // Handle non-200 responses
        return null;
      }
    } catch (e) {
      // Catch and log errors
      return null; // Return null in case of errors
    }
  }
}
